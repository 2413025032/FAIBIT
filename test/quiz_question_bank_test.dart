import 'package:flutter_test/flutter_test.dart';

import 'package:faibit/data/mock_data.dart';

void main() {
  const materialTitles = [
    'Desimal',
    'Biner',
    'Oktal',
    'Heksadesimal',
    'Konversi',
  ];

  group('FAIBIT question banks', () {
    test('practice and challenge each contain 50 questions', () {
      expect(questions, hasLength(50));
      expect(challengeQuestionBank, hasLength(50));
    });

    for (final material in materialTitles) {
      test('$material has 10 questions per mode with different prompts', () {
        final practice = questions
            .where((question) => question.material == material)
            .toList();
        final challenge = challengeQuestionBank
            .where((question) => question.material == material)
            .toList();

        expect(practice, hasLength(10));
        expect(challenge, hasLength(10));
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
