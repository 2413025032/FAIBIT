import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:faibit/data/quiz_history_repository.dart';
import 'package:faibit/models/models.dart';
import 'package:faibit/screens/history_profile.dart';

QuizAttempt _attempt({
  required String id,
  required String type,
  required String material,
}) => QuizAttempt(
  id: id,
  completedAt: DateTime(2026, 10, 15, 10),
  type: type,
  material: material,
  totalQuestions: 1,
  correctAnswers: 1,
  incorrectAnswers: 0,
  score: 100,
  durationSeconds: 10,
  questions: const [
    QuizQuestionResult(
      question: 'Pertanyaan',
      selectedAnswer: 'Benar',
      correctAnswer: 'Benar',
      isCorrect: true,
      explanation: 'Pembahasan',
    ),
  ],
);

void main() {
  testWidgets('loads history and refreshes without async setState error', (
    tester,
  ) async {
    SharedPreferences.setMockInitialValues({});
    final preferences = await SharedPreferences.getInstance();
    QuizHistoryRepository.configure(preferences);
    await QuizHistoryRepository.instance.saveAttempt(
      _attempt(
        id: 'practice-1',
        type: QuizHistoryRepository.practiceType,
        material: 'Biner',
      ),
    );

    await tester.pumpWidget(
      const MaterialApp(home: Scaffold(body: HistoryPage(refreshToken: 0))),
    );
    await tester.pumpAndSettle();
    expect(find.text('Biner'), findsOneWidget);

    await tester.pumpWidget(
      const MaterialApp(home: Scaffold(body: HistoryPage(refreshToken: 1))),
    );
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
  });

  testWidgets('Challenge filter shows saved Challenge attempts', (
    tester,
  ) async {
    SharedPreferences.setMockInitialValues({});
    final preferences = await SharedPreferences.getInstance();
    QuizHistoryRepository.configure(preferences);
    await QuizHistoryRepository.instance.saveAttempt(
      _attempt(
        id: 'practice-1',
        type: QuizHistoryRepository.practiceType,
        material: 'Biner',
      ),
    );
    await QuizHistoryRepository.instance.saveAttempt(
      _attempt(
        id: 'challenge-1',
        type: QuizHistoryRepository.challengeType,
        material: 'Desimal',
      ),
    );

    await tester.pumpWidget(
      const MaterialApp(home: Scaffold(body: HistoryPage(refreshToken: 0))),
    );
    await tester.pumpAndSettle();
    expect(find.text('Biner'), findsOneWidget);
    expect(find.text('Desimal'), findsOneWidget);

    await tester.tap(
      find.widgetWithText(ChoiceChip, QuizHistoryRepository.challengeType),
    );
    await tester.pumpAndSettle();
    expect(find.text('Desimal'), findsOneWidget);
    expect(find.text('Biner'), findsNothing);
  });
}
