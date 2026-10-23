import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'package:faibit/data/faibit_database.dart';
import 'package:faibit/data/sqlite_quiz_history_migrator.dart';
import 'package:faibit/data/sqlite_quiz_history_repository.dart';
import 'package:faibit/models/models.dart';

void main() {
  setUpAll(sqfliteFfiInit);

  final databases = <Database>[];

  Future<SqliteQuizHistoryRepository> createRepository() async {
    final database = await databaseFactoryFfi.openDatabase(
      inMemoryDatabasePath,
      options: OpenDatabaseOptions(
        singleInstance: false,
        version: FaibitDatabase.databaseVersion,
        onConfigure: (database) async {
          await database.execute('PRAGMA foreign_keys = ON');
        },
        onCreate: (database, version) => FaibitDatabase.createSchema(database),
      ),
    );
    databases.add(database);
    return SqliteQuizHistoryRepository(database);
  }

  tearDown(() async {
    for (final database in databases) {
      await database.close();
    }
    databases.clear();
  });

  QuizAttempt createAttempt(String id, {List<QuizQuestionResult>? questions}) =>
      QuizAttempt(
        id: id,
        completedAt: DateTime(2026, 10, 24, 2),
        type: 'Latihan Santai',
        material: 'Biner',
        totalQuestions: questions?.length ?? 1,
        correctAnswers: 1,
        incorrectAnswers: 0,
        score: 100,
        durationSeconds: 20,
        questions:
            questions ??
            const [
              QuizQuestionResult(
                question: 'Pertanyaan lama',
                selectedAnswer: 'A',
                correctAnswer: 'A',
                isCorrect: true,
                explanation: 'Pembahasan lama',
              ),
            ],
      );

  String encodeAttempts(List<QuizAttempt> attempts) =>
      jsonEncode(attempts.map((attempt) => attempt.toJson()).toList());

  Future<
    (SharedPreferences, SqliteQuizHistoryMigrator, SqliteQuizHistoryRepository)
  >
  createMigrator(String? raw) async {
    final initialValues = <String, Object>{};
    if (raw != null) {
      initialValues[SqliteQuizHistoryMigrator.sourceKey] = raw;
    }
    SharedPreferences.setMockInitialValues(initialValues);
    final preferences = await SharedPreferences.getInstance();
    final repository = await createRepository();
    return (
      preferences,
      SqliteQuizHistoryMigrator(
        preferences: preferences,
        repository: repository,
      ),
      repository,
    );
  }

  test('migrates multiple attempts and verifies details', () async {
    final first = createAttempt('first');
    final second = createAttempt('second', questions: const []);
    final (preferences, migrator, repository) = await createMigrator(
      encodeAttempts([first, second]),
    );

    final result = await migrator.migrate();
    final loaded = await repository.loadAttempts();

    expect(result.sourceAttemptCount, 2);
    expect(result.verifiedQuestionCount, 1);
    expect(loaded.map((attempt) => attempt.id), ['first', 'second']);
    expect(loaded.first.questions.single.question, 'Pertanyaan lama');
    expect(preferences.getBool(SqliteQuizHistoryMigrator.markerKey), isTrue);
    expect(
      preferences.getString(SqliteQuizHistoryMigrator.sourceKey),
      isNotNull,
    );
  });

  test('rerunning migration does not duplicate attempts or details', () async {
    final attempt = createAttempt('same');
    final (preferences, migrator, repository) = await createMigrator(
      encodeAttempts([attempt]),
    );

    await migrator.migrate();
    await migrator.migrate();

    final loaded = await repository.loadAttempts();
    expect(loaded, hasLength(1));
    expect(loaded.single.questions, hasLength(1));
    expect(preferences.getBool(SqliteQuizHistoryMigrator.markerKey), isTrue);
  });

  test('rerun after database commit but before marker is safe', () async {
    final attempt = createAttempt('committed-before-marker');
    final (preferences, migrator, repository) = await createMigrator(
      encodeAttempts([attempt]),
    );

    await migrator.migrate();
    await preferences.remove(SqliteQuizHistoryMigrator.markerKey);
    await migrator.migrate();

    expect(await repository.loadAttempts(), hasLength(1));
    expect(preferences.getBool(SqliteQuizHistoryMigrator.markerKey), isTrue);
    expect(
      preferences.getString(SqliteQuizHistoryMigrator.sourceKey),
      isNotNull,
    );
  });

  test('empty and empty array sources complete as no-op migrations', () async {
    for (final raw in [null, '', '[]']) {
      final (preferences, migrator, repository) = await createMigrator(raw);

      final result = await migrator.migrate();

      expect(result.sourceAttemptCount, 0);
      expect(await repository.loadAttempts(), isEmpty);
      expect(preferences.getBool(SqliteQuizHistoryMigrator.markerKey), isTrue);
    }
  });

  test('invalid JSON fails and preserves source without marker', () async {
    const raw = '{invalid';
    final (preferences, migrator, repository) = await createMigrator(raw);

    expect(migrator.migrate(), throwsFormatException);

    expect(preferences.getString(SqliteQuizHistoryMigrator.sourceKey), raw);
    expect(preferences.getBool(SqliteQuizHistoryMigrator.markerKey), isNull);
    expect(await repository.loadAttempts(), isEmpty);
  });

  test('existing SQLite attempt is not overwritten', () async {
    final existing = createAttempt('existing');
    final incoming = createAttempt('existing');
    final (preferences, migrator, repository) = await createMigrator(
      encodeAttempts([incoming]),
    );
    await repository.saveAttempt(existing);

    await migrator.migrate();

    final loaded = await repository.loadAttempts();
    expect(loaded.single.questions, hasLength(1));
    expect(preferences.getBool(SqliteQuizHistoryMigrator.markerKey), isTrue);
  });

  test('conflicting parent metadata fails without marker', () async {
    final source = createAttempt('conflicting-parent');
    final conflicting = source.toJson()
      ..['score'] = 40
      ..['material'] = 'Desimal';
    final raw = jsonEncode([source.toJson()]);
    final (preferences, migrator, repository) = await createMigrator(raw);
    await repository.saveAttempt(QuizAttempt.fromJson(conflicting));

    expect(migrator.migrate(), throwsA(isA<StateError>()));
    expect(preferences.getBool(SqliteQuizHistoryMigrator.markerKey), isNull);
    expect(preferences.getString(SqliteQuizHistoryMigrator.sourceKey), raw);
    final stored = (await repository.loadAttempts()).single;
    expect(stored.score, 40);
    expect(stored.material, 'Desimal');
  });

  test(
    'missing details are completed without changing existing details',
    () async {
      final source = createAttempt('partial-details');
      final (preferences, migrator, repository) = await createMigrator(
        encodeAttempts([source]),
      );
      await repository.saveAttempt(source);
      await repository.database.delete(
        'quiz_question_results',
        where: 'attempt_id = ? AND question_index = ?',
        whereArgs: [source.id, 0],
      );

      await migrator.migrate();

      final stored = (await repository.loadAttempts()).single;
      expect(stored.questions, hasLength(1));
      expect(
        stored.questions.single.question,
        source.questions.single.question,
      );
      expect(preferences.getBool(SqliteQuizHistoryMigrator.markerKey), isTrue);
    },
  );

  test('conflicting existing detail fails without marker', () async {
    final source = createAttempt('conflicting-detail');
    final conflictingQuestion = QuizQuestionResult(
      question: 'Pertanyaan berbeda',
      selectedAnswer: source.questions.single.selectedAnswer,
      correctAnswer: source.questions.single.correctAnswer,
      isCorrect: source.questions.single.isCorrect,
      explanation: source.questions.single.explanation,
    );
    final (preferences, migrator, repository) = await createMigrator(
      encodeAttempts([source]),
    );
    await repository.saveAttempt(
      createAttempt('conflicting-detail', questions: [conflictingQuestion]),
    );

    expect(migrator.migrate(), throwsA(isA<StateError>()));
    expect(preferences.getBool(SqliteQuizHistoryMigrator.markerKey), isNull);
  });

  test(
    'duplicate source ID and wrong field types fail without marker',
    () async {
      final source = createAttempt('duplicate');
      final duplicateRaw = encodeAttempts([source, source]);
      final (duplicatePreferences, duplicateMigrator, _) = await createMigrator(
        duplicateRaw,
      );

      expect(duplicateMigrator.migrate(), throwsFormatException);
      expect(
        duplicatePreferences.getBool(SqliteQuizHistoryMigrator.markerKey),
        isNull,
      );

      final invalid = source.toJson()
        ..['score'] = '100'
        ..['questions'] = [
          {...source.questions.single.toJson(), 'isCorrect': 'true'},
        ];
      final (invalidPreferences, invalidMigrator, _) = await createMigrator(
        jsonEncode([invalid]),
      );

      expect(invalidMigrator.migrate(), throwsFormatException);
      expect(
        invalidPreferences.getBool(SqliteQuizHistoryMigrator.markerKey),
        isNull,
      );
    },
  );

  test('missing and null required fields fail without marker', () async {
    final source = createAttempt('missing-field').toJson()..remove('material');
    final (missingPreferences, missingMigrator, _) = await createMigrator(
      jsonEncode([source]),
    );
    expect(missingMigrator.migrate(), throwsFormatException);
    expect(
      missingPreferences.getBool(SqliteQuizHistoryMigrator.markerKey),
      isNull,
    );

    final nullSource = createAttempt('null-field').toJson()..['score'] = null;
    final (nullPreferences, nullMigrator, _) = await createMigrator(
      jsonEncode([nullSource]),
    );
    expect(nullMigrator.migrate(), throwsFormatException);
    expect(
      nullPreferences.getBool(SqliteQuizHistoryMigrator.markerKey),
      isNull,
    );
  });

  test('failed detail insert leaves no partial parent and no marker', () async {
    final attempt = createAttempt('failed');
    final (preferences, migrator, repository) = await createMigrator(
      encodeAttempts([attempt]),
    );
    await repository.database.execute('''
      CREATE TRIGGER fail_migration_detail
      BEFORE INSERT ON quiz_question_results
      BEGIN
        SELECT RAISE(ABORT, 'forced migration failure');
      END
    ''');

    expect(migrator.migrate(), throwsA(isA<DatabaseException>()));

    expect(await repository.loadAttempts(), isEmpty);
    expect(preferences.getBool(SqliteQuizHistoryMigrator.markerKey), isNull);
    expect(
      preferences.getString(SqliteQuizHistoryMigrator.sourceKey),
      isNotNull,
    );
  });
}
