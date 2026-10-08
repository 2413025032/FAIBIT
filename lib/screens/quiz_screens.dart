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

class PracticePreparationPage extends StatefulWidget {
  const PracticePreparationPage({super.key});

  @override
  State<PracticePreparationPage> createState() =>
      _PracticePreparationPageState();
}

class _PracticePreparationPageState extends State<PracticePreparationPage> {
  static const materials = [
    'Semua Materi',
    'Desimal',
    'Biner',
    'Oktal',
    'Heksadesimal',
    'Konversi',
  ];

  String selectedMaterial = materials.first;

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
                  const Icon(Icons.edit_note_outlined, size: 42),
                  const SizedBox(height: 10),
                  const Text(
                    'Siap untuk Latihan Santai?',
                    style: TextStyle(fontSize: 21, fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Latih pemahamanmu tentang sistem bilangan '
                    'tanpa batas waktu.',
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
              initialValue: selectedMaterial,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.menu_book_outlined),
                border: OutlineInputBorder(),
              ),
              items: materials
                  .map(
                    (material) => DropdownMenuItem(
                      value: material,
                      child: Text(material),
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
            const OutlineCard(
              child: Column(
                children: [
                  _PracticeInfo(
                    icon: Icons.quiz_outlined,
                    title: 'Jumlah Soal',
                    value: '10 soal',
                  ),
                  SizedBox(height: 14),
                  _PracticeInfo(
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
                  builder: (_) => QuizPage(materialTitle: selectedMaterial),
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
    if (currentQuestion == totalQuestions - 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const QuizResultPage()),
      );
      return;
    }

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
  });
  final Question question;
  final int selected;
  @override
  Widget build(BuildContext context) {
    final ok = selected == question.correct;
    return Scaffold(
      appBar: const PageTitle(title: 'Latihan Santai'),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Icon(
              ok ? Icons.check_circle_outline : Icons.error_outline,
              size: 58,
            ),
            Text(
              ok ? 'Benar!' : 'Belum tepat',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 23, fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 18),
            OutlineCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Jawabanmu: ${question.options[selected]}'),
                  Text('Jawaban benar: ${question.options[question.correct]}'),
                  const Divider(),
                  const Text(
                    'Pembahasan:',
                    style: TextStyle(fontWeight: FontWeight.w800),
                  ),
                  Text(question.explanation),
                ],
              ),
            ),
            const Spacer(),
            const Row(
              children: [
                EmptySlot(width: 62, height: 74),
                SizedBox(width: 10),
                Expanded(
                  child: OutlineCard(
                    child: Text('Mantap! Kamu sudah memahami konsepnya.'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            FilledButton(
              onPressed: () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const QuizResultPage()),
              ),
              child: const Text('Lanjut ke Soal Berikutnya'),
            ),
          ],
        ),
      ),
    );
  }
}

class QuizResultPage extends StatelessWidget {
  const QuizResultPage({super.key});
  @override
  Widget build(BuildContext context) =>
      ResultPage(challenge: false, onRetry: () => Navigator.pop(context));
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
                  const Icon(Icons.bolt_outlined, size: 42),
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

  List<Question> get challengeQuestions => questions.take(10).toList();

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
                    Icon(
                      Icons.emoji_events_outlined,
                      size: 64,
                      color: AppTheme.challenge.primary,
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
    required this.challenge,
    required this.onRetry,
    this.materialTitle,
    this.totalQuestions,
    this.correctAnswers,
    this.incorrectAnswers,
    this.score,
    this.duration,
  });

  final bool challenge;
  final VoidCallback onRetry;
  final String? materialTitle;
  final int? totalQuestions;
  final int? correctAnswers;
  final int? incorrectAnswers;
  final int? score;
  final Duration? duration;

  @override
  Widget build(BuildContext context) {
    final label = challenge ? 'Challenge' : 'Latihan';
    return Scaffold(
      appBar: PageTitle(title: 'Hasil $label'),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Icon(Icons.emoji_events_outlined, size: 68),
            Text(
              '$label Selesai!',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 21, fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 14),
            OutlineCard(
              child: Column(
                children: [
                  _Stat('Materi', materialTitle ?? 'Biner'),
                  _Stat('Jumlah Soal', '${totalQuestions ?? 10}'),
                  _Stat('Jawaban Benar', '${correctAnswers ?? 8}'),
                  _Stat('Jawaban Salah', '${incorrectAnswers ?? 2}'),
                  _Stat('Skor', '${score ?? 80}%'),
                  _Stat(
                    'Waktu',
                    duration == null ? '05:12' : _formatDuration(duration!),
                  ),
                ],
              ),
            ),
            const Spacer(),
            OutlinedButton(
              onPressed: () => Navigator.popUntil(context, (r) => r.isFirst),
              child: const Text('Kembali ke Menu'),
            ),
            FilledButton(
              onPressed: onRetry,
              child: Text(challenge ? 'Coba Lagi' : 'Lihat Pembahasan'),
            ),
          ],
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

class _Stat extends StatelessWidget {
  const _Stat(this.a, this.b);
  final String a, b;
  @override
  Widget build(BuildContext context) => Row(
    children: [
      Expanded(child: Text(a)),
      Text(': $b'),
    ],
  );
}
