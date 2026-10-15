import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:faibit/data/quiz_history_repository.dart';
import 'package:faibit/models/models.dart';

void main() {
  QuizAttempt createAttempt(String id, {DateTime? completedAt}) => QuizAttempt(
    id: id,
    completedAt: completedAt ?? DateTime(2026, 10, 15, 8, 30),
    type: 'Latihan Santai',
    material: 'Semua Materi',
    totalQuestions: 1,
    correctAnswers: 1,
    incorrectAnswers: 0,
    score: 100,
    durationSeconds: 12,
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

  test('saves, reloads, and deduplicates quiz attempts', () async {
    SharedPreferences.setMockInitialValues({});
    final preferences = await SharedPreferences.getInstance();
    final repository = QuizHistoryRepository(preferences);
    final attempt = createAttempt('attempt-1');

    await repository.saveAttempt(attempt);
    await repository.saveAttempt(attempt);

    final loaded = await repository.loadAttempts();
    expect(loaded, hasLength(1));
    expect(loaded.single.id, 'attempt-1');
    expect(loaded.single.questions.single.question, '1 + 1 = ...');
    expect(loaded.single.questions.single.selectedAnswer, '2');
  });

  test('loads attempts newest first from persistent preferences', () async {
    SharedPreferences.setMockInitialValues({});
    final preferences = await SharedPreferences.getInstance();
    final repository = QuizHistoryRepository(preferences);

    await repository.saveAttempt(createAttempt('older'));
    await repository.saveAttempt(
      createAttempt('newer', completedAt: DateTime(2026, 10, 16)),
    );

    final loaded = await repository.loadAttempts();
    expect(loaded.map((attempt) => attempt.id), ['newer', 'older']);
  });
}
