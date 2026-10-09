import 'dart:async';

import 'package:flutter/material.dart';

import '../data/mock_data.dart';
import '../models/models.dart';
import '../theme/app_theme.dart';
import '../widgets/ui.dart';

const practiceMaterials = [
  'Desimal',
  'Biner',
  'Oktal',
  'Heksadesimal',
  'Konversi',
];

class PracticeMaterialSelectionPage extends StatelessWidget {
  const PracticeMaterialSelectionPage({super.key});

  static const choices = ['Semua Materi', ...practiceMaterials];

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: const PageTitle(title: 'Pilih Materi Latihan'),
    body: SafeArea(
      child: ListView.separated(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
        itemCount: choices.length,
        separatorBuilder: (_, _) => const SizedBox(height: 10),
        itemBuilder: (context, index) {
          final title = choices[index];
          final description = title == 'Semua Materi'
              ? 'Latihan dari seluruh materi sistem bilangan'
              : materials.firstWhere((item) => item.title == title).description;
          return OutlineCard(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => PracticePreparationPage(materialTitle: title),
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xFFD0D0D0)),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Center(
                    child: Text(
                      '${index + 1}',
                      style: const TextStyle(fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
                const SizedBox(width: 13),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(fontWeight: FontWeight.w800),
                      ),
                      const SizedBox(height: 3),
                      Text(description, style: const TextStyle(fontSize: 12)),
                    ],
                  ),
                ),
                const Icon(Icons.chevron_right),
              ],
            ),
          );
        },
      ),
    ),
  );
}

class PracticePreparationPage extends StatelessWidget {
  const PracticePreparationPage({super.key, required this.materialTitle});

  final String materialTitle;

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: const PageTitle(title: 'Persiapan Latihan'),
    body: SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            OutlineCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FaiMascot(
                    assetName: 'faibit_thinking.png',
                    width: 78,
                    height: 92,
                    semanticLabel: 'Fai sedang berpikir',
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Siap untuk Latihan Santai?',
                    style: TextStyle(fontSize: 21, fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(height: 8),
                  Text('Latihan materi $materialTitle tanpa batas waktu.'),
                ],
              ),
            ),
            const SizedBox(height: 20),
            OutlineCard(
              child: Column(
                children: [
                  _PracticeInfo(
                    icon: Icons.menu_book_outlined,
                    title: 'Materi',
                    value: materialTitle,
                  ),
                  const SizedBox(height: 14),
                  const _PracticeInfo(
                    icon: Icons.quiz_outlined,
                    title: 'Jumlah Soal',
                    value: '10 soal',
                  ),
                  const SizedBox(height: 14),
                  const _PracticeInfo(
                    icon: Icons.all_inclusive,
                    title: 'Waktu',
                    value: 'Tanpa batas waktu',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),
            FilledButton(
              onPressed: () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => QuizPage(materialTitle: materialTitle),
                ),
              ),
              child: const Text('Mulai Latihan'),
            ),
          ],
        ),
      ),
    ),
  );
}

class _PracticeInfo extends StatelessWidget {
  const _PracticeInfo({
    required this.icon,
    required this.title,
    required this.value,
  });

  final IconData icon;
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) => Row(
    children: [
      Icon(icon),
      const SizedBox(width: 12),
      Expanded(child: Text(title)),
      Flexible(
        child: Text(
          value,
          textAlign: TextAlign.end,
          style: const TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
    ],
  );
}

class QuizPage extends StatefulWidget {
  const QuizPage({super.key, this.materialTitle = 'Semua Materi'});

  final String materialTitle;

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  static const totalQuestions = 10;

  int currentQuestion = 0;
  int selected = -1;
  final List<int> answers = [];
  final DateTime startedAt = DateTime.now();

  List<Question> get practiceQuestions {
    if (widget.materialTitle != 'Semua Materi') {
      return questions
          .where((question) => question.material == widget.materialTitle)
          .take(totalQuestions)
          .toList();
    }

    final byMaterial = <String, List<Question>>{};
    for (final question in questions) {
      byMaterial.putIfAbsent(question.material, () => []).add(question);
    }

    return [
      for (var index = 0; index < 2; index++)
        for (final material in practiceMaterials)
          if (index < (byMaterial[material]?.length ?? 0))
            byMaterial[material]![index],
    ];
  }

  void nextQuestion() {
    answers.add(selected);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => FeedbackPage(
          question: practiceQuestions[currentQuestion],
          selected: selected,
          onContinue: _continueAfterFeedback,
        ),
      ),
    );
  }

  void _continueAfterFeedback() {
    if (currentQuestion == totalQuestions - 1) {
      final completedAnswers = List<int>.from(answers);
      Navigator.pop(context);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => QuizResultPage(
              materialTitle: widget.materialTitle,
              questions: practiceQuestions,
              answers: completedAnswers,
              duration: DateTime.now().difference(startedAt),
            ),
          ),
        );
      });
      return;
    }

    Navigator.pop(context);
    setState(() {
      currentQuestion++;
      selected = -1;
    });
  }

  @override
  Widget build(BuildContext context) {
    final question = practiceQuestions[currentQuestion];

    return Scaffold(
      body: SafeArea(
        child: _QuestionScreen(
          title: 'Latihan Santai',
          number: 'Soal ${currentQuestion + 1} dari $totalQuestions',
          value: (currentQuestion + 1) / totalQuestions,
          question: question,
          selected: selected,
          onSelected: (i) => setState(() => selected = i),
          onNext: selected < 0 ? null : nextQuestion,
        ),
      ),
    );
  }
}

class _QuestionScreen extends StatelessWidget {
  const _QuestionScreen({
    this.showHeader = true,
    required this.title,
    required this.number,
    required this.value,
    required this.question,
    required this.selected,
    required this.onSelected,
    required this.onNext,
    this.buttonColor,
    this.radioActiveColor,
  });
  final bool showHeader;
  final String title, number;
  final double value;
  final Question question;
  final int selected;
  final ValueChanged<int> onSelected;
  final VoidCallback? onNext;
  final Color? buttonColor;
  final Color? radioActiveColor;
  @override
  Widget build(BuildContext context) => Column(
    children: [
      if (showHeader) PageTitle(title: title),
      Expanded(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(number, style: const TextStyle(fontWeight: FontWeight.w700)),
              const SizedBox(height: 8),
              if (value > 0) ProgressLine(value: value),
              const SizedBox(height: 24),
              OutlineCard(
                child: Text(
                  question.question,
                  style: const TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(height: 14),
              RadioGroup<int>(
                groupValue: selected,
                onChanged: (value) {
                  if (value != null) {
                    onSelected(value);
                  }
                },
                child: Column(
                  children: List.generate(
                    question.options.length,
                    (i) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: OutlineCard(
                        onTap: () => onSelected(i),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        child: RadioListTile<int>(
                          value: i,
                          title: Text(
                            '${String.fromCharCode(65 + i)}.   ${question.options[i]}',
                          ),
                          contentPadding: EdgeInsets.zero,
                          activeColor: radioActiveColor ?? Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              FilledButton(
                onPressed: onNext,
                style: buttonColor == null
                    ? null
                    : FilledButton.styleFrom(backgroundColor: buttonColor),
                child: const Text('Selanjutnya'),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}

class FeedbackPage extends StatelessWidget {
  const FeedbackPage({
    super.key,
    required this.question,
    required this.selected,
    required this.onContinue,
  });
  final Question question;
  final int selected;
  final VoidCallback onContinue;
  @override
  Widget build(BuildContext context) {
    final ok = selected == question.correct;
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Icon(
                  ok ? Icons.check_circle_outline : Icons.lightbulb_outline,
                  size: 58,
                  color: AppTheme.greenTeal,
                ),
                Text(
                  ok ? 'Benar!' : 'Belum tepat',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 18),
                OutlineCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Jawabanmu: ${question.options[selected]}'),
                      Text(
                        'Jawaban benar: ${question.options[question.correct]}',
                      ),
                      const Divider(),
                      const Text(
                        'Pembahasan:',
                        style: TextStyle(fontWeight: FontWeight.w800),
                      ),
                      Text(question.explanation),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    FaiMascot(
                      assetName: ok
                          ? 'faibit_happy.png'
                          : 'faibit_encourage.png',
                      width: 62,
                      height: 74,
                      semanticLabel: ok ? 'Fai senang' : 'Fai menyemangati',
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: OutlineCard(
                        child: Text(
                          ok
                              ? 'Fai ikut senang! Pertahankan pemahamanmu '
                                    'dan lanjutkan dengan percaya diri.'
                              : 'Tidak apa-apa, proses belajar memang bertahap. '
                                    'Fai mendukungmu untuk mencoba lagi di soal berikutnya.',
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                FilledButton(
                  onPressed: onContinue,
                  child: const Text('Lanjut ke Soal Berikutnya'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class QuizResultPage extends StatelessWidget {
  const QuizResultPage({
    super.key,
    required this.materialTitle,
    required this.questions,
    required this.answers,
    required this.duration,
  });

  final String materialTitle;
  final List<Question> questions;
  final List<int> answers;
  final Duration duration;

  @override
  Widget build(BuildContext context) => ResultPage(
    materialTitle: materialTitle,
    questions: questions,
    answers: answers,
    duration: duration,
  );
}

class ChallengePreparationPage extends StatefulWidget {
  const ChallengePreparationPage({super.key, required this.profile});

  final UserProfile profile;

  @override
  State<ChallengePreparationPage> createState() =>
      _ChallengePreparationPageState();
}

class _ChallengePreparationPageState extends State<ChallengePreparationPage> {
  String selectedMaterial = materials.first.title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PageTitle(title: 'Persiapan Challenge'),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            OutlineCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const FaiMascot(
                    assetName: 'faibit_challenge.png',
                    width: 78,
                    height: 92,
                    semanticLabel: 'Fai untuk challenge',
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Siap untuk Challenge?',
                    style: TextStyle(fontSize: 21, fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Uji pemahamanmu tentang sistem bilangan '
                    'dengan waktu yang terbatas.',
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              'Pilih Materi',
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 8),

            DropdownButtonFormField<String>(
              value: selectedMaterial,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.menu_book_outlined),
                border: OutlineInputBorder(),
              ),
              items: materials
                  .map(
                    (material) => DropdownMenuItem(
                      value: material.title,
                      child: Text(material.title),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() => selectedMaterial = value);
                }
              },
            ),

            const SizedBox(height: 20),

            OutlineCard(
              child: Column(
                children: const [
                  _ChallengeInfo(
                    icon: Icons.quiz_outlined,
                    title: 'Jumlah Soal',
                    value: '10 soal',
                  ),
                  SizedBox(height: 14),
                  _ChallengeInfo(
                    icon: Icons.timer_outlined,
                    title: 'Batas Waktu',
                    value: '10 menit',
                  ),
                ],
              ),
            ),

            const Spacer(),

            FilledButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ChallengePage(
                      profile: widget.profile,
                      materialTitle: selectedMaterial,
                    ),
                  ),
                );
              },
              style: FilledButton.styleFrom(
                backgroundColor: AppTheme.challenge.primary,
              ),
              child: const Text('Mulai Challenge'),
            ),
          ],
        ),
      ),
    );
  }
}

class _ChallengeInfo extends StatelessWidget {
  const _ChallengeInfo({
    required this.icon,
    required this.title,
    required this.value,
  });

  final IconData icon;
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon),
        const SizedBox(width: 12),
        Expanded(child: Text(title)),
        Text(value, style: const TextStyle(fontWeight: FontWeight.w700)),
      ],
    );
  }
}

class ChallengePage extends StatefulWidget {
  const ChallengePage({
    super.key,
    required this.profile,
    this.materialTitle = 'Biner',
  });

  final UserProfile profile;
  final String materialTitle;

  @override
  State<ChallengePage> createState() => _ChallengePageState();
}

class _ChallengePageState extends State<ChallengePage> {
  int seconds = 10 * 60;
  int currentQuestion = 0;
  int selected = -1;

  Timer? timer;

  final List<int> answers = [];

  List<Question> get challengeQuestions => questions
      .where((question) => question.material == widget.materialTitle)
      .take(10)
      .toList();

  @override
  void initState() {
    super.initState();

    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (seconds <= 1) {
        t.cancel();
        finish(timeExpired: true);
      } else if (mounted) {
        setState(() => seconds--);
      }
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  String get formattedTime {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;

    return '${minutes.toString().padLeft(2, '0')}:'
        '${remainingSeconds.toString().padLeft(2, '0')}';
  }

  void nextQuestion() {
    answers.add(selected);

    if (currentQuestion < challengeQuestions.length - 1) {
      setState(() {
        currentQuestion++;
        selected = -1;
      });
    } else {
      finish();
    }
  }

  void finish({bool timeExpired = false}) {
    timer?.cancel();

    if (!mounted) return;

    if (answers.length == currentQuestion) {
      answers.add(selected);
    }

    final correctAnswers = challengeQuestions
        .asMap()
        .entries
        .where(
          (entry) =>
              entry.key < answers.length &&
              answers[entry.key] == entry.value.correct,
        )
        .length;
    final totalQuestions = challengeQuestions.length;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => ChallengeResultPage(
          profile: widget.profile,
          materialTitle: widget.materialTitle,
          totalQuestions: totalQuestions,
          correctAnswers: correctAnswers,
          incorrectAnswers: totalQuestions - correctAnswers,
          score: (correctAnswers * 100 / totalQuestions).round(),
          duration: Duration(
            seconds: timeExpired ? 10 * 60 : 10 * 60 - seconds,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final question = challengeQuestions[currentQuestion];

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const PageTitle(title: 'Challenge'),

            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 8),
              child: Row(
                children: [
                  Text(
                    'Soal ${currentQuestion + 1} dari ${challengeQuestions.length}',
                    style: const TextStyle(fontWeight: FontWeight.w700),
                  ),
                  const Spacer(),
                  const Icon(Icons.timer_outlined),
                  const SizedBox(width: 5),
                  Text(
                    formattedTime,
                    style: const TextStyle(fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(9),
                child: LinearProgressIndicator(
                  value: (currentQuestion + 1) / challengeQuestions.length,
                  minHeight: 10,
                  color: AppTheme.challenge.primary,
                  backgroundColor: AppTheme.challenge.surface,
                ),
              ),
            ),

            Expanded(
              child: _QuestionScreen(
                showHeader: false,
                title: '',
                number: '',
                value: 0,
                question: question,
                selected: selected,
                onSelected: (i) {
                  setState(() => selected = i);
                },
                onNext: selected < 0 ? null : nextQuestion,
                buttonColor: AppTheme.challenge.primary,
                radioActiveColor: AppTheme.challenge.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChallengeResultPage extends StatelessWidget {
  const ChallengeResultPage({
    super.key,
    required this.profile,
    required this.materialTitle,
    required this.totalQuestions,
    required this.correctAnswers,
    required this.incorrectAnswers,
    required this.score,
    required this.duration,
  });

  final UserProfile profile;
  final String materialTitle;
  final int totalQuestions;
  final int correctAnswers;
  final int incorrectAnswers;
  final int score;
  final Duration duration;

  @override
  Widget build(BuildContext context) {
    final durationLabel = _formatDuration(duration);

    return Scaffold(
      appBar: const PageTitle(title: 'Hasil Challenge'),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              OutlineCard(
                child: Column(
                  children: [
                    const FaiMascot(
                      assetName: 'faibit_celebrate.png',
                      width: 86,
                      height: 100,
                      semanticLabel: 'Fai merayakan hasil challenge',
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Challenge Selesai!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Kerja bagus! Kamu berhasil menyelesaikan challenge ini.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: AppTheme.challenge.accentDark),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 18,
                ),
                decoration: BoxDecoration(
                  color: score >= 70
                      ? AppTheme.tealSurface
                      : AppTheme.challenge.surface,
                  borderRadius: BorderRadius.circular(AppTheme.radius),
                ),
                child: Column(
                  children: [
                    const Text(
                      'SKOR AKHIR',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.1,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '$score%',
                      style: TextStyle(
                        color: score >= 70
                            ? AppTheme.greenTeal
                            : AppTheme.challenge.primaryDark,
                        fontSize: 48,
                        fontWeight: FontWeight.w800,
                        height: 1.1,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: _ChallengeResultStat(
                      icon: Icons.check_circle_outline,
                      label: 'Benar',
                      value: '$correctAnswers',
                      color: AppTheme.challenge.primary,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _ChallengeResultStat(
                      icon: Icons.cancel_outlined,
                      label: 'Salah',
                      value: '$incorrectAnswers',
                      color: AppTheme.challenge.accentDark,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              OutlineCard(
                child: Column(
                  children: [
                    _ChallengeResultInfo(
                      icon: Icons.menu_book_outlined,
                      label: 'Materi',
                      value: materialTitle,
                    ),
                    const SizedBox(height: 14),
                    _ChallengeResultInfo(
                      icon: Icons.quiz_outlined,
                      label: 'Jumlah Soal',
                      value: '$totalQuestions soal',
                    ),
                    const SizedBox(height: 14),
                    _ChallengeResultInfo(
                      icon: Icons.timer_outlined,
                      label: 'Waktu',
                      value: durationLabel,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              OutlinedButton(
                onPressed: () =>
                    Navigator.popUntil(context, (route) => route.isFirst),
                child: const Text('Kembali ke Menu'),
              ),
              const SizedBox(height: 10),
              FilledButton(
                onPressed: () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ChallengePreparationPage(profile: profile),
                  ),
                ),
                style: FilledButton.styleFrom(
                  backgroundColor: AppTheme.challenge.primary,
                ),
                child: const Text('Coba Lagi'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ChallengeResultStat extends StatelessWidget {
  const _ChallengeResultStat({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  final IconData icon;
  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) => OutlineCard(
    child: Column(
      children: [
        Icon(icon, color: color, size: 26),
        const SizedBox(height: 6),
        Text(
          value,
          style: TextStyle(
            color: color,
            fontSize: 24,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 2),
        Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
      ],
    ),
  );
}

class _ChallengeResultInfo extends StatelessWidget {
  const _ChallengeResultInfo({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) => Row(
    children: [
      Icon(icon, color: AppTheme.challenge.primary),
      const SizedBox(width: 12),
      Expanded(child: Text(label)),
      Flexible(
        child: Text(
          value,
          textAlign: TextAlign.end,
          style: const TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
    ],
  );
}

class ResultPage extends StatelessWidget {
  const ResultPage({
    super.key,
    required this.materialTitle,
    required this.questions,
    required this.answers,
    required this.duration,
  });

  final String materialTitle;
  final List<Question> questions;
  final List<int> answers;
  final Duration duration;

  @override
  Widget build(BuildContext context) {
    final correct = questions
        .asMap()
        .entries
        .where((entry) => answers[entry.key] == entry.value.correct)
        .length;
    final incorrect = questions.length - correct;
    final score = (correct * 100 / questions.length).round();

    return Scaffold(
      appBar: const PageTitle(title: 'Hasil Latihan'),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              OutlineCard(
                child: Column(
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FaiMascot(
                          assetName: 'faibit_celebrate.png',
                          width: 64,
                          height: 80,
                          semanticLabel: 'Fai merayakan hasil latihan',
                        ),
                        SizedBox(width: 12),
                        Icon(Icons.emoji_events_outlined, size: 54),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Latihan Selesai!',
                      style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      score >= 70
                          ? 'Fai bangga melihat progres belajarmu.'
                          : 'Tetap semangat, Fai siap menemanimu belajar lagi.',
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 18),
                decoration: BoxDecoration(
                  color: AppTheme.tealSurface,
                  borderRadius: BorderRadius.circular(AppTheme.radius),
                ),
                child: Column(
                  children: [
                    const Text(
                      'SKOR LATIHAN',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.1,
                      ),
                    ),
                    Text(
                      '$score%',
                      style: const TextStyle(
                        color: AppTheme.greenTeal,
                        fontSize: 50,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: _PracticeResultStat(
                      icon: Icons.check_circle_outline,
                      label: 'Benar',
                      value: '$correct',
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _PracticeResultStat(
                      icon: Icons.cancel_outlined,
                      label: 'Salah',
                      value: '$incorrect',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              OutlineCard(
                child: Column(
                  children: [
                    _PracticeResultInfo(
                      icon: Icons.menu_book_outlined,
                      label: 'Materi',
                      value: materialTitle,
                    ),
                    const SizedBox(height: 14),
                    _PracticeResultInfo(
                      icon: Icons.quiz_outlined,
                      label: 'Jumlah Soal',
                      value: '${questions.length} soal',
                    ),
                    const SizedBox(height: 14),
                    _PracticeResultInfo(
                      icon: Icons.timer_outlined,
                      label: 'Durasi',
                      value: _formatDuration(duration),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              OutlinedButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => QuizReviewPage(
                      materialTitle: materialTitle,
                      questions: questions,
                      answers: answers,
                    ),
                  ),
                ),
                child: const Text('Lihat Pembahasan'),
              ),
              const SizedBox(height: 10),
              FilledButton(
                onPressed: () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => QuizPage(materialTitle: materialTitle),
                  ),
                ),
                child: const Text('Coba Latihan Lagi'),
              ),
              const SizedBox(height: 10),
              OutlinedButton(
                onPressed: () => Navigator.popUntil(context, (r) => r.isFirst),
                child: const Text('Kembali ke Menu'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

String _formatDuration(Duration duration) {
  final minutes = duration.inMinutes.toString().padLeft(2, '0');
  final seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');
  return '$minutes:$seconds';
}

class _PracticeResultStat extends StatelessWidget {
  const _PracticeResultStat({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) => OutlineCard(
    child: Column(
      children: [
        Icon(icon, color: AppTheme.greenTeal, size: 28),
        const SizedBox(height: 6),
        Text(
          value,
          style: const TextStyle(
            color: AppTheme.greenTeal,
            fontSize: 25,
            fontWeight: FontWeight.w800,
          ),
        ),
        Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
      ],
    ),
  );
}

class _PracticeResultInfo extends StatelessWidget {
  const _PracticeResultInfo({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) => Row(
    children: [
      Icon(icon, color: AppTheme.greenTeal),
      const SizedBox(width: 12),
      Expanded(child: Text(label)),
      Flexible(
        child: Text(
          value,
          textAlign: TextAlign.end,
          style: const TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
    ],
  );
}

class QuizReviewPage extends StatelessWidget {
  const QuizReviewPage({
    super.key,
    required this.materialTitle,
    required this.questions,
    required this.answers,
  });

  final String materialTitle;
  final List<Question> questions;
  final List<int> answers;

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: const PageTitle(title: 'Pembahasan Latihan'),
    body: ListView.separated(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
      itemCount: questions.length,
      separatorBuilder: (_, _) => const SizedBox(height: 12),
      itemBuilder: (_, index) {
        final question = questions[index];
        final answer = answers[index];
        final correct = answer == question.correct;
        return OutlineCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Soal ${index + 1}',
                style: const TextStyle(fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 8),
              Text(
                question.question,
                style: const TextStyle(fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 10),
              Text('Jawabanmu: ${question.options[answer]}'),
              Text('Jawaban benar: ${question.options[question.correct]}'),
              const SizedBox(height: 8),
              Text(
                correct ? 'Benar' : 'Belum tepat',
                style: TextStyle(
                  color: correct
                      ? AppTheme.greenTeal
                      : AppTheme.challengeAccentDark,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const Divider(),
              const Text(
                'Pembahasan',
                style: TextStyle(fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 4),
              Text(question.explanation),
            ],
          ),
        );
      },
    ),
  );
}
