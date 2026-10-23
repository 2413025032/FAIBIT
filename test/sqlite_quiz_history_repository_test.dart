import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'package:faibit/data/faibit_database.dart';
import 'package:faibit/data/sqlite_quiz_history_repository.dart';
import 'package:faibit/models/models.dart';

void main() {
  final openDatabases = <Database>[];

  setUpAll(() {
    sqfliteFfiInit();
  });

  Future<Database> openDatabase() async {
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
    openDatabases.add(database);
    return database;
  }

  tearDown(() async {
    for (final database in openDatabases) {
      await database.close();
    }
    openDatabases.clear();
  });

  Future<SqliteQuizHistoryRepository> createRepository() async =>
      SqliteQuizHistoryRepository(await openDatabase());

  QuizAttempt createAttempt(
    String id, {
    DateTime? completedAt,
    String type = 'Latihan Santai',
  }) => QuizAttempt(
    id: id,
    completedAt: completedAt ?? DateTime(2026, 10, 15, 8, 30),
    type: type,
    material: 'Biner',
    totalQuestions: 2,
    correctAnswers: 1,
    incorrectAnswers: 1,
    score: 50,
    durationSeconds: 90,
    questions: const [
      QuizQuestionResult(
        question: 'Soal pertama',
        selectedAnswer: 'A',
        correctAnswer: 'A',
        isCorrect: true,
        explanation: 'Pembahasan pertama',
      ),
      QuizQuestionResult(
        question: 'Soal kedua',
        selectedAnswer: 'B',
        correctAnswer: 'C',
        isCorrect: false,
        explanation: 'Pembahasan kedua',
      ),
    ],
  );

  test('empty database returns no attempts', () async {
    final repository = await createRepository();
    expect(await repository.loadAttempts(), isEmpty);
  });

  test('saves and reloads an attempt with ordered question details', () async {
    final repository = await createRepository();
    final attempt = createAttempt('attempt-1');

    await repository.saveAttempt(attempt);
    final loaded = await repository.loadAttempts();

    expect(loaded, hasLength(1));
    expect(loaded.single.id, attempt.id);
    expect(loaded.single.completedAt, attempt.completedAt);
    expect(loaded.single.type, attempt.type);
    expect(loaded.single.material, attempt.material);
    expect(loaded.single.totalQuestions, attempt.totalQuestions);
    expect(loaded.single.correctAnswers, attempt.correctAnswers);
    expect(loaded.single.incorrectAnswers, attempt.incorrectAnswers);
    expect(loaded.single.score, attempt.score);
    expect(loaded.single.durationSeconds, attempt.durationSeconds);
    expect(loaded.single.questions.map((question) => question.question), [
      'Soal pertama',
      'Soal kedua',
    ]);
    expect(loaded.single.questions[1].isCorrect, isFalse);
  });

  test('orders attempts newest first', () async {
    final repository = await createRepository();
    await repository.saveAttempt(
      createAttempt('older', completedAt: DateTime(2026, 1, 1)),
    );
    await repository.saveAttempt(
      createAttempt('newer', completedAt: DateTime(2026, 2, 1)),
    );

    final loaded = await repository.loadAttempts();
    expect(loaded.map((attempt) => attempt.id), ['newer', 'older']);
  });

  test('same attempt ID does not duplicate attempt or details', () async {
    final repository = await createRepository();
    final attempt = createAttempt('same-id');

    await repository.saveAttempt(attempt);
    await repository.saveAttempt(attempt);

    final loaded = await repository.loadAttempts();
    expect(loaded, hasLength(1));
    expect(loaded.single.questions, hasLength(2));
  });

  test('rolls back parent when saving question details fails', () async {
    final database = await openDatabase();
    final repository = SqliteQuizHistoryRepository(database);
    await database.execute('''
      CREATE TRIGGER fail_question_insert
      BEFORE INSERT ON quiz_question_results
      BEGIN
        SELECT RAISE(ABORT, 'forced detail failure');
      END
    ''');

    expect(
      () => repository.saveAttempt(createAttempt('rolled-back')),
      throwsA(isA<DatabaseException>()),
    );
    expect(await repository.loadAttempts(), isEmpty);
  });

  test('deleting an attempt cascades to its question details', () async {
    final database = await openDatabase();
    final repository = SqliteQuizHistoryRepository(database);
    await repository.saveAttempt(createAttempt('delete-me'));

    await repository.deleteAttempt('delete-me');

    expect(await repository.loadAttempts(), isEmpty);
    expect(
      await database.query(
        'quiz_question_results',
        where: 'attempt_id = ?',
        whereArgs: ['delete-me'],
      ),
      isEmpty,
    );
  });
}
