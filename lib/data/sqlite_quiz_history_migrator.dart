import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/models.dart';
import 'sqlite_quiz_history_repository.dart';

class SqliteQuizHistoryMigrationResult {
  const SqliteQuizHistoryMigrationResult({
    required this.sourceAttemptCount,
    required this.verifiedQuestionCount,
  });

  final int sourceAttemptCount;
  final int verifiedQuestionCount;
}

class SqliteQuizHistoryMigrator {
  const SqliteQuizHistoryMigrator({
    required this.preferences,
    required this.repository,
  });

  static const sourceKey = 'quiz_attempts_v1';
  static const markerKey = 'quiz_history_sqlite_migration_v1';

  final SharedPreferences preferences;
  final SqliteQuizHistoryRepository repository;

  Future<SqliteQuizHistoryMigrationResult> migrate() async {
    final attempts = _decodeAttempts(preferences.getString(sourceKey));
    _rejectDuplicateIds(attempts);

    final existing = {
      for (final record in await repository.loadRecords())
        record.attempt.id: record,
    };

    for (final attempt in attempts) {
      final existingRecord = existing[attempt.id];
      if (existingRecord != null) {
        _verifyAttempt(attempt, existingRecord);
      }
      await repository.saveAttempt(attempt);
    }

    final stored = {
      for (final record in await repository.loadRecords())
        record.attempt.id: record,
    };
    var verifiedQuestionCount = 0;
    for (final attempt in attempts) {
      final record = stored[attempt.id];
      if (record == null) {
        throw StateError(
          'Verifikasi migrasi gagal untuk attempt ${attempt.id}.',
        );
      }
      _verifyAttempt(attempt, record, requireAllDetails: true);
      verifiedQuestionCount += attempt.questions.length;
    }

    final marked = await preferences.setBool(markerKey, true);
    if (!marked) {
      throw StateError('Marker migrasi riwayat tidak dapat disimpan.');
    }
    return SqliteQuizHistoryMigrationResult(
      sourceAttemptCount: attempts.length,
      verifiedQuestionCount: verifiedQuestionCount,
    );
  }

  void _verifyAttempt(
    QuizAttempt source,
    SqliteQuizAttemptRecord stored, {
    bool requireAllDetails = false,
  }) {
    final actual = stored.attempt;
    if (actual.id != source.id ||
        actual.completedAt != source.completedAt ||
        actual.type != source.type ||
        actual.material != source.material ||
        actual.totalQuestions != source.totalQuestions ||
        actual.correctAnswers != source.correctAnswers ||
        actual.incorrectAnswers != source.incorrectAnswers ||
        actual.score != source.score ||
        actual.durationSeconds != source.durationSeconds) {
      throw StateError(
        'Konflik metadata pada attempt ${source.id}; data SQLite '
        'tidak ditimpa.',
      );
    }

    final byIndex = {
      for (final question in stored.questions) question.questionIndex: question,
    };
    for (var index = 0; index < source.questions.length; index++) {
      final storedQuestion = byIndex[index];
      if (storedQuestion == null) {
        if (requireAllDetails) {
          throw StateError(
            'Detail soal $index tidak ditemukan pada attempt ${source.id}.',
          );
        }
        continue;
      }
      if (storedQuestion.attemptId != source.id ||
          !_sameQuestion(storedQuestion.result, source.questions[index])) {
        throw StateError(
          'Konflik detail soal $index pada attempt ${source.id}.',
        );
      }
    }
  }

  bool _sameQuestion(QuizQuestionResult left, QuizQuestionResult right) =>
      left.question == right.question &&
      left.selectedAnswer == right.selectedAnswer &&
      left.correctAnswer == right.correctAnswer &&
      left.isCorrect == right.isCorrect &&
      left.explanation == right.explanation;

  void _rejectDuplicateIds(List<QuizAttempt> attempts) {
    final seen = <String>{};
    for (final attempt in attempts) {
      if (!seen.add(attempt.id)) {
        throw FormatException(
          'Migrasi riwayat gagal: ID attempt duplikat pada sumber.',
        );
      }
    }
  }

  List<QuizAttempt> _decodeAttempts(String? raw) {
    if (raw == null || raw.isEmpty) return const [];
    final decoded = _decodeJson(raw);
    if (decoded is! List) {
      throw const FormatException(
        'Migrasi riwayat gagal: sumber harus berupa array JSON.',
      );
    }
    final attempts = <QuizAttempt>[];
    for (var index = 0; index < decoded.length; index++) {
      final item = decoded[index];
      if (item is! Map<String, dynamic>) {
        throw FormatException(
          'Migrasi riwayat gagal: attempt indeks $index tidak valid.',
        );
      }
      _validateAttemptJson(item, index);
      attempts.add(QuizAttempt.fromJson(item));
    }
    return attempts;
  }

  dynamic _decodeJson(String raw) {
    try {
      return jsonDecode(raw);
    } on FormatException {
      throw const FormatException(
        'Migrasi riwayat gagal: JSON sumber tidak valid.',
      );
    }
  }

  void _validateAttemptJson(Map<String, dynamic> json, int index) {
    const fields = [
      'id',
      'completedAt',
      'type',
      'material',
      'totalQuestions',
      'correctAnswers',
      'incorrectAnswers',
      'score',
      'durationSeconds',
      'questions',
    ];
    for (final field in fields) {
      if (!json.containsKey(field) || json[field] == null) {
        throw FormatException(
          'Migrasi riwayat gagal: field $field pada attempt indeks $index '
          'wajib diisi.',
        );
      }
    }
    if (json['id'] is! String ||
        (json['id'] as String).isEmpty ||
        json['completedAt'] is! String ||
        DateTime.tryParse(json['completedAt'] as String) == null ||
        json['type'] is! String ||
        json['material'] is! String ||
        json['questions'] is! List ||
        fields.skip(4).take(5).any((field) => json[field] is! int)) {
      throw FormatException(
        'Migrasi riwayat gagal: tipe field attempt indeks $index tidak valid.',
      );
    }

    final questions = json['questions'] as List<dynamic>;
    for (
      var questionIndex = 0;
      questionIndex < questions.length;
      questionIndex++
    ) {
      final question = questions[questionIndex];
      if (question is! Map<String, dynamic>) {
        throw FormatException(
          'Migrasi riwayat gagal: detail soal indeks $questionIndex tidak valid.',
        );
      }
      const questionFields = [
        'question',
        'selectedAnswer',
        'correctAnswer',
        'isCorrect',
        'explanation',
      ];
      for (final field in questionFields) {
        if (!question.containsKey(field) || question[field] == null) {
          throw FormatException(
            'Migrasi riwayat gagal: field $field pada detail soal '
            'indeks $questionIndex wajib diisi.',
          );
        }
      }
      if (question['question'] is! String ||
          question['selectedAnswer'] is! String ||
          question['correctAnswer'] is! String ||
          question['isCorrect'] is! bool ||
          question['explanation'] is! String) {
        throw FormatException(
          'Migrasi riwayat gagal: tipe detail soal indeks $questionIndex '
          'tidak valid.',
        );
      }
    }
  }
}
