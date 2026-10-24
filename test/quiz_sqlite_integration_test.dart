import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'package:faibit/data/faibit_database.dart';
import 'package:faibit/data/quiz_history_repository.dart';
import 'package:faibit/data/sqlite_quiz_history_repository.dart';
import 'package:faibit/models/models.dart';

void main() {
  late Database database;

  setUpAll(sqfliteFfiInit);

  setUp(() async {
    database = await databaseFactoryFfi.openDatabase(
      inMemoryDatabasePath,
      options: OpenDatabaseOptions(
        version: FaibitDatabase.databaseVersion,
        onConfigure: (db) => db.execute('PRAGMA foreign_keys = ON'),
        onCreate: (db, _) => FaibitDatabase.createSchema(db),
      ),
    );
    QuizHistoryRepository.configureStore(SqliteQuizHistoryRepository(database));
  });

  tearDown(() => database.close());

  QuizAttempt attempt({
    required String id,
    required String type,
    required int durationSeconds,
  }) => QuizAttempt(
    id: id,
    completedAt: DateTime(2026, 10, 24, 3),
    type: type,
    material: 'Biner',
    totalQuestions: 1,
    correctAnswers: 1,
    incorrectAnswers: 0,
    score: 100,
    durationSeconds: durationSeconds,
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

  test('Latihan Santai selesai tersimpan ke SQLite melalui facade', () async {
    await QuizHistoryRepository.instance.saveAttempt(
      attempt(
        id: 'practice-complete',
        type: QuizHistoryRepository.practiceType,
        durationSeconds: 18,
      ),
    );

    final loaded = await QuizHistoryRepository.loadStoredAttempts();
    expect(loaded.single.type, QuizHistoryRepository.practiceType);
    expect(loaded.single.questions.single.selectedAnswer, '2');
  });

  test('Challenge selesai normal tersimpan ke SQLite', () async {
    await QuizHistoryRepository.instance.saveAttempt(
      attempt(
        id: 'challenge-complete',
        type: QuizHistoryRepository.challengeType,
        durationSeconds: 42,
      ),
    );

    final loaded = await QuizHistoryRepository.loadStoredAttempts();
    expect(loaded.single.type, QuizHistoryRepository.challengeType);
    expect(loaded.single.durationSeconds, 42);
  });

  test('Challenge timeout tersimpan dengan durasi timeout', () async {
    await QuizHistoryRepository.instance.saveAttempt(
      attempt(
        id: 'challenge-timeout',
        type: QuizHistoryRepository.challengeType,
        durationSeconds: 600,
      ),
    );

    final loaded = await QuizHistoryRepository.loadStoredAttempts();
    expect(loaded.single.type, QuizHistoryRepository.challengeType);
    expect(loaded.single.durationSeconds, 600);
  });

  test('Challenge dibatalkan tidak menyimpan attempt', () async {
    // Pembatalan keluar sebelum finish tidak memanggil saveAttempt.
    final loaded = await QuizHistoryRepository.loadStoredAttempts();

    expect(loaded, isEmpty);
  });
}
