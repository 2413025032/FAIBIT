import 'package:sqflite/sqflite.dart';

import '../models/models.dart';

class SqliteQuizQuestionRecord {
  const SqliteQuizQuestionRecord({
    required this.attemptId,
    required this.questionIndex,
    required this.result,
  });

  final String attemptId;
  final int questionIndex;
  final QuizQuestionResult result;
}

class SqliteQuizAttemptRecord {
  const SqliteQuizAttemptRecord({
    required this.attempt,
    required this.questions,
  });

  final QuizAttempt attempt;
  final List<SqliteQuizQuestionRecord> questions;
}

class SqliteQuizHistoryRepository {
  const SqliteQuizHistoryRepository(this.database);

  final Database database;

  Future<void> saveAttempt(QuizAttempt attempt) async {
    await database.transaction((transaction) async {
      await transaction.insert(
        'quiz_attempts',
        _attemptValues(attempt),
        conflictAlgorithm: ConflictAlgorithm.ignore,
      );

      for (var index = 0; index < attempt.questions.length; index++) {
        final result = attempt.questions[index];
        await transaction.insert('quiz_question_results', {
          'attempt_id': attempt.id,
          'question_index': index,
          'question': result.question,
          'selected_answer': result.selectedAnswer,
          'correct_answer': result.correctAnswer,
          'is_correct': result.isCorrect ? 1 : 0,
          'explanation': result.explanation,
        }, conflictAlgorithm: ConflictAlgorithm.ignore);
      }
    });
  }

  Future<List<QuizAttempt>> loadAttempts() async {
    final records = await loadRecords();
    return records.map((record) => record.attempt).toList();
  }

  Future<List<SqliteQuizAttemptRecord>> loadRecords() async {
    final attemptRows = await database.query(
      'quiz_attempts',
      orderBy: 'completed_at DESC',
    );
    final records = <SqliteQuizAttemptRecord>[];

    for (final row in attemptRows) {
      final questionRows = await database.query(
        'quiz_question_results',
        where: 'attempt_id = ?',
        whereArgs: [row['id']],
        orderBy: 'question_index ASC',
      );
      records.add(
        SqliteQuizAttemptRecord(
          attempt: _attemptFromRows(row, questionRows),
          questions: questionRows.map(_questionRecordFromRow).toList(),
        ),
      );
    }
    return records;
  }

  Future<int> deleteAttempt(String id) =>
      database.delete('quiz_attempts', where: 'id = ?', whereArgs: [id]);

  static Map<String, Object?> _attemptValues(QuizAttempt attempt) => {
    'id': attempt.id,
    'completed_at': attempt.completedAt.toIso8601String(),
    'type': attempt.type,
    'material': attempt.material,
    'total_questions': attempt.totalQuestions,
    'correct_answers': attempt.correctAnswers,
    'incorrect_answers': attempt.incorrectAnswers,
    'score': attempt.score,
    'duration_seconds': attempt.durationSeconds,
  };

  static QuizAttempt _attemptFromRows(
    Map<String, Object?> attempt,
    List<Map<String, Object?>> questions,
  ) => QuizAttempt(
    id: attempt['id']! as String,
    completedAt: DateTime.parse(attempt['completed_at']! as String),
    type: attempt['type']! as String,
    material: attempt['material']! as String,
    totalQuestions: attempt['total_questions']! as int,
    correctAnswers: attempt['correct_answers']! as int,
    incorrectAnswers: attempt['incorrect_answers']! as int,
    score: attempt['score']! as int,
    durationSeconds: attempt['duration_seconds']! as int,
    questions: questions
        .map(
          (row) => QuizQuestionResult(
            question: row['question']! as String,
            selectedAnswer: row['selected_answer']! as String,
            correctAnswer: row['correct_answer']! as String,
            isCorrect: row['is_correct']! as int == 1,
            explanation: row['explanation']! as String,
          ),
        )
        .toList(),
  );

  static SqliteQuizQuestionRecord _questionRecordFromRow(
    Map<String, Object?> row,
  ) => SqliteQuizQuestionRecord(
    attemptId: row['attempt_id']! as String,
    questionIndex: row['question_index']! as int,
    result: QuizQuestionResult(
      question: row['question']! as String,
      selectedAnswer: row['selected_answer']! as String,
      correctAnswer: row['correct_answer']! as String,
      isCorrect: row['is_correct']! as int == 1,
      explanation: row['explanation']! as String,
    ),
  );
}
