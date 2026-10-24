import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'package:faibit/data/faibit_database.dart';
import 'package:faibit/data/sqlite_quiz_history_migrator.dart';
import 'package:faibit/data/sqlite_quiz_history_provider.dart';
import 'package:faibit/data/quiz_history_repository.dart';
import 'package:faibit/models/models.dart';

void main() {
  late Database database;

  setUpAll(sqfliteFfiInit);

  setUp(() async {
    await SqliteQuizHistoryProvider.dispose();
    database = await databaseFactoryFfi.openDatabase(
      inMemoryDatabasePath,
      options: OpenDatabaseOptions(
        version: FaibitDatabase.databaseVersion,
        onConfigure: (db) => db.execute('PRAGMA foreign_keys = ON'),
        onCreate: (db, _) => FaibitDatabase.createSchema(db),
      ),
    );
  });

  tearDown(() async {
    await SqliteQuizHistoryProvider.dispose();
    await database.close();
  });

  QuizAttempt attempt(String id) => QuizAttempt(
    id: id,
    completedAt: DateTime(2026, 10, 24, 3),
    type: 'Latihan Santai',
    material: 'Biner',
    totalQuestions: 1,
    correctAnswers: 1,
    incorrectAnswers: 0,
    score: 100,
    durationSeconds: 10,
    questions: const [
      QuizQuestionResult(
        question: '1 + 1 = ...',
        selectedAnswer: '2',
        correctAnswer: '2',
        isCorrect: true,
        explanation: 'Penjumlahan dasar.',
      ),
    ],
  );

  test('initializes active SQLite provider after migration', () async {
    final source = attempt('startup-1').toJson();
    SharedPreferences.setMockInitialValues({
      SqliteQuizHistoryMigrator.sourceKey: jsonEncode([source]),
    });
    final preferences = await SharedPreferences.getInstance();

    final provider = await SqliteQuizHistoryProvider.initialize(
      preferences: preferences,
      database: database,
    );

    expect(SqliteQuizHistoryProvider.isInitialized, isTrue);
    expect(SqliteQuizHistoryProvider.active, same(provider));
    expect(await provider.repository.loadAttempts(), hasLength(1));
    expect(preferences.getBool(SqliteQuizHistoryMigrator.markerKey), isTrue);
  });

  test('SQLite provider can be selected as the active history store', () async {
    SharedPreferences.setMockInitialValues({});
    final preferences = await SharedPreferences.getInstance();
    final provider = await SqliteQuizHistoryProvider.initialize(
      preferences: preferences,
      database: database,
    );
    QuizHistoryRepository.configureStore(provider.repository);

    await QuizHistoryRepository.instance.saveAttempt(attempt('active-store'));

    final loaded = await QuizHistoryRepository.loadStoredAttempts();
    expect(loaded.map((item) => item.id), ['active-store']);
    expect(QuizHistoryRepository.instance, same(provider.repository));
  });

  test('migration failure does not activate SQLite or alter source', () async {
    const raw = '{invalid';
    SharedPreferences.setMockInitialValues({
      SqliteQuizHistoryMigrator.sourceKey: raw,
    });
    final preferences = await SharedPreferences.getInstance();

    expect(
      () => SqliteQuizHistoryProvider.initialize(
        preferences: preferences,
        database: database,
      ),
      throwsA(isA<FormatException>()),
    );
    expect(preferences.getString(SqliteQuizHistoryMigrator.sourceKey), raw);
    expect(preferences.getBool(SqliteQuizHistoryMigrator.markerKey), isNull);
    expect(SqliteQuizHistoryProvider.isInitialized, isFalse);
    expect(await database.query('quiz_attempts'), isEmpty);
  });

  test('repeated initialization returns the same provider', () async {
    SharedPreferences.setMockInitialValues({});
    final preferences = await SharedPreferences.getInstance();

    final first = await SqliteQuizHistoryProvider.initialize(
      preferences: preferences,
      database: database,
    );
    final second = await SqliteQuizHistoryProvider.initialize(
      preferences: preferences,
      database: database,
    );

    expect(second, same(first));
    expect(SqliteQuizHistoryProvider.active, same(first));
  });

  test('concurrent initialization shares one provider and migration', () async {
    final source = attempt('concurrent-1').toJson();
    SharedPreferences.setMockInitialValues({
      SqliteQuizHistoryMigrator.sourceKey: jsonEncode([source]),
    });
    final preferences = await SharedPreferences.getInstance();

    final firstFuture = SqliteQuizHistoryProvider.initialize(
      preferences: preferences,
      database: database,
    );
    final secondFuture = SqliteQuizHistoryProvider.initialize(
      preferences: preferences,
      database: database,
    );
    final providers = await Future.wait([firstFuture, secondFuture]);

    expect(providers[0], same(providers[1]));
    expect(await providers[0].repository.loadAttempts(), hasLength(1));
  });

  test('failed initialization keeps an injected database open', () async {
    const raw = '{invalid';
    SharedPreferences.setMockInitialValues({
      SqliteQuizHistoryMigrator.sourceKey: raw,
    });
    final preferences = await SharedPreferences.getInstance();

    expect(
      () => SqliteQuizHistoryProvider.initialize(
        preferences: preferences,
        database: database,
      ),
      throwsA(isA<FormatException>()),
    );

    expect(await database.query('quiz_attempts'), isEmpty);
  });
}
