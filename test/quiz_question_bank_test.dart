import 'dart:math';

import 'package:flutter_test/flutter_test.dart';

import 'package:faibit/data/mock_data.dart';
import 'package:faibit/models/models.dart';

void main() {
  const materialTitles = [
    'Desimal',
    'Biner',
    'Oktal',
    'Heksadesimal',
    'Konversi',
  ];

  group('FAIBIT question banks', () {
    test('practice and challenge each contain 100 questions', () {
      expect(questions, hasLength(100));
      expect(challengeQuestionBank, hasLength(100));
    });

    for (final material in materialTitles) {
      test('$material has 20 questions per mode with different prompts', () {
        final practice = questions
            .where((question) => question.material == material)
            .toList();
        final challenge = challengeQuestionBank
            .where((question) => question.material == material)
            .toList();

        expect(practice, hasLength(20));
        expect(challenge, hasLength(20));
        expect(
          practice.map((question) => question.question).toSet().intersection(
            challenge.map((question) => question.question).toSet(),
          ),
          isEmpty,
        );
      });
    }

    test('all questions have four options and a valid correct-answer index', () {
      for (final question in [...questions, ...challengeQuestionBank]) {
        expect(question.options, hasLength(4), reason: question.id);
        expect(
          question.correct,
          inInclusiveRange(0, question.options.length - 1),
          reason: question.id,
        );
        expect(question.explanation.trim(), isNotEmpty, reason: question.id);
      }
    });

    test('all question IDs are unique across both banks', () {
      final ids = [
        ...questions.map((question) => question.id),
        ...challengeQuestionBank.map((question) => question.id),
      ];
      expect(ids.toSet(), hasLength(ids.length));
    });

    test('all question categories map to the supported material list', () {
      for (final question in [...questions, ...challengeQuestionBank]) {
        expect(materialTitles, contains(question.material), reason: question.id);
      }
    });

    test('a single-material session contains 3 basic, 4 intermediate, 3 application questions', () {
      for (final bank in [questions, challengeQuestionBank]) {
        for (final material in materialTitles) {
          final selected = selectQuestionsForSession(
            bank: bank,
            materialTitle: material,
            random: Random(42),
          );

          expect(selected, hasLength(quizSessionQuestionCount));
          expect(selected.map((q) => q.id).toSet(), hasLength(10));
          expect(
            selected.where((q) => questionDifficultyLevel(q) == 1),
            hasLength(3),
          );
          expect(
            selected.where((q) => questionDifficultyLevel(q) == 2),
            hasLength(4),
          );
          expect(
            selected.where((q) => questionDifficultyLevel(q) == 3),
            hasLength(3),
          );
        }
      }
    });

    test('all-material practice selects two questions from every material', () {
      final selected = selectQuestionsForSession(
        bank: questions,
        materialTitle: 'Semua Materi',
        random: Random(7),
      );

      expect(selected, hasLength(10));
      for (final material in materialTitles) {
        expect(
          selected.where((question) => question.material == material),
          hasLength(2),
        );
      }
    });

    test('new sessions can produce different question combinations', () {
      final first = selectQuestionsForSession(
        bank: questions,
        materialTitle: 'Biner',
        random: Random(1),
      );
      final second = selectQuestionsForSession(
        bank: questions,
        materialTitle: 'Biner',
        random: Random(2),
      );

      expect(
        first.map((q) => q.id).toSet().intersection(
          second.map((q) => q.id).toSet(),
        ).length,
        lessThan(10),
      );
    });

    test('learning materials include additional examples and visual diagrams', () {
      final sections = materials.expand((material) => material.sections).toList();
      final sectionsWithMoreExamples = sections
          .where((section) => section.additionalExamples.isNotEmpty)
          .length;
      final sectionsWithVisuals = sections
          .where((section) => section.visualKind != MaterialVisualKind.none)
          .length;

      expect(sectionsWithMoreExamples, greaterThanOrEqualTo(25));
      expect(sectionsWithVisuals, greaterThanOrEqualTo(8));
    });
  });
}
