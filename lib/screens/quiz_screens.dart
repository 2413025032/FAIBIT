import 'dart:async';

import 'package:flutter/material.dart';

import '../data/quiz_history_repository.dart';
import '../data/mock_data.dart';
import '../models/models.dart';
import '../theme/app_theme.dart';
import '../services/sound_manager.dart';
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
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const FaiMascot(
                    assetName: 'faibit_thinking.png',
                    width: 126,
                    height: 152,
                    semanticLabel: 'Fai sedang berpikir',
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Latihan Santai',
                          style: Theme.of(context).textTheme.headlineSmall
                              ?.copyWith(fontWeight: FontWeight.w800),
                        ),
                        const SizedBox(height: 7),
                        Text(
                          'Latihan materi $materialTitle tanpa batas waktu.',
                        ),
                      ],
                    ),
                  ),
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
              onPressed: () {
                unawaited(SoundManager.instance.playButtonClick());

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => QuizPage(materialTitle: materialTitle),
                  ),
                );
              },
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
  bool completionStarted = false;
  late final List<Question> _sessionQuestions;

  List<Question> get practiceQuestions => _sessionQuestions;

  @override
  void initState() {
    super.initState();
    _sessionQuestions = selectQuestionsForSession(
      bank: questions,
      materialTitle: widget.materialTitle,
    );
  }


  void nextQuestion() {
    final question = practiceQuestions[currentQuestion];
    final isCorrect = selected == question.correct;

    if (isCorrect) {
      unawaited(SoundManager.instance.playCorrectAnswer());
    } else {
      unawaited(SoundManager.instance.playWrongAnswer());
    }

    answers.add(selected);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => FeedbackPage(
          question: question,
          selected: selected,
          onContinue: _continueAfterFeedback,
        ),
      ),
    );
  }

  QuizAttempt _createAttempt(List<int> completedAnswers, Duration duration) {
    return QuizAttempt(
      id: 'practice-${DateTime.now().microsecondsSinceEpoch}',
      completedAt: DateTime.now(),
      type: QuizHistoryRepository.practiceType,
      material: widget.materialTitle,
      totalQuestions: practiceQuestions.length,
      correctAnswers: practiceQuestions
          .asMap()
          .entries
          .where((entry) => completedAnswers[entry.key] == entry.value.correct)
          .length,
      incorrectAnswers: practiceQuestions.length -
          practiceQuestions
              .asMap()
              .entries
              .where(
                (entry) => completedAnswers[entry.key] == entry.value.correct,
              )
              .length,
      score: (practiceQuestions
                  .asMap()
                  .entries
                  .where(
                    (entry) =>
                        completedAnswers[entry.key] == entry.value.correct,
                  )
                  .length *
              100 /
              practiceQuestions.length)
          .round(),
      durationSeconds: duration.inSeconds,
      questions: _snapshotQuestions(practiceQuestions, completedAnswers),
    );
  }

  void _continueAfterFeedback() async {
    if (currentQuestion == totalQuestions - 1) {
      if (completionStarted) return;
      completionStarted = true;
      final completedAnswers = List<int>.from(answers);
      try {
        await QuizHistoryRepository.instance.saveAttempt(
          _createAttempt(
            completedAnswers,
            DateTime.now().difference(startedAt),
          ),
        );
      } catch (error) {
        completionStarted = false;
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Riwayat gagal disimpan: $error')),
          );
        }
        return;
      }
      if (!mounted) return;
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
                onPressed: onNext == null
                    ? null
                    : () {
                        // Tombol selanjutnya Challenge memakai bunyi klik.
                        // Latihan Santai tetap hanya memakai bunyi benar/salah.
                        if (buttonColor != null) {
                          unawaited(SoundManager.instance.playButtonClick());
                        }
                        onNext!();
                      },
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
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Icon(
                  ok ? Icons.check_circle_outline : Icons.lightbulb_outline,
                  size: 56,
                  color: ok
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.tertiary,
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
                OutlineCard(
                  padding: const EdgeInsets.fromLTRB(10, 12, 14, 12),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      FaiMascot(
                        assetName: ok
                            ? 'faibit_happy.png'
                            : 'faibit_encourage.png',
                        width: 106,
                        height: 124,
                        semanticLabel: ok
                            ? 'Fai senang'
                            : 'Fai menyemangati',
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: SpeechBubble(
                          child: Text(
                            ok
                                ? 'Fai ikut senang! Pertahankan pemahamanmu '
                                      'dan lanjutkan dengan percaya diri.'
                                : 'Tidak apa-apa, proses belajar memang '
                                      'bertahap. Fai mendukungmu untuk mencoba '
                                      'lagi di soal berikutnya.',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 14),
                FilledButton(
                  onPressed: () {
                    unawaited(SoundManager.instance.playButtonClick());
                    onContinue();
                  },                  
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

class QuizResultPage extends StatefulWidget {
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
  State<QuizResultPage> createState() => _QuizResultPageState();
}

class _QuizResultPageState extends State<QuizResultPage> {
  @override
  void initState() {
    super.initState();
    unawaited(SoundManager.instance.playQuizComplete());
  }

  @override
  Widget build(BuildContext context) => ResultPage(
    materialTitle: widget.materialTitle,
    questions: widget.questions,
    answers: widget.answers,
    duration: widget.duration,
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
  int selectedDurationMinutes = 10;

  static const _timeChoices = <_ChallengeTimeChoice>[
    _ChallengeTimeChoice(
      minutes: 15,
      level: 'EASY',
      description: 'Waktu lebih leluasa',
    ),
    _ChallengeTimeChoice(
      minutes: 10,
      level: 'MEDIUM',
      description: 'Tantangan seimbang',
    ),
    _ChallengeTimeChoice(
      minutes: 5,
      level: 'HARD',
      description: 'Butuh fokus tinggi',
    ),
    _ChallengeTimeChoice(
      minutes: 3,
      level: 'EXTREME',
      description: 'Uji kecepatanmu',
    ),
  ];

  Color _levelColor(String level) {
    switch (level) {
      case 'EASY':
        return const Color(0xFF299B78);
      case 'MEDIUM':
        return const Color(0xFF4E8FA5);
      case 'HARD':
        return const Color(0xFFE28A3B);
      default:
        return const Color(0xFFCA5E68);
    }
  }

  Widget _buildTimeChoice(_ChallengeTimeChoice choice) {
    final theme = Theme.of(context);
    final accent = _levelColor(choice.level);
    final isSelected = selectedDurationMinutes == choice.minutes;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      decoration: BoxDecoration(
        color: isSelected
            ? accent.withValues(alpha: 0.10)
            : theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isSelected ? accent : theme.colorScheme.outlineVariant,
          width: isSelected ? 2 : 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            unawaited(SoundManager.instance.playButtonClick());
            setState(() => selectedDurationMinutes = choice.minutes);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.timer_outlined, color: accent, size: 19),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        '${choice.minutes} menit',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    if (isSelected)
                      Icon(Icons.check_circle, color: accent, size: 18),
                  ],
                ),
                const SizedBox(height: 7),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 9,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: accent.withValues(alpha: 0.14),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Text(
                    choice.level,
                    style: TextStyle(
                      color: accent,
                      fontSize: 10,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.8,
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  choice.description,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PageTitle(title: 'Persiapan Challenge'),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              OutlineCard(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const FaiMascot(
                      assetName: 'faibit_challenge.png',
                      width: 132,
                      height: 144,
                      semanticLabel: 'Fai untuk challenge',
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Challenge',
                            style: Theme.of(context).textTheme.headlineSmall
                                ?.copyWith(
                                  color: AppTheme.challenge.primaryDark,
                                  fontWeight: FontWeight.w800,
                                ),
                          ),
                          const SizedBox(height: 7),
                          const Text(
                            'Uji pemahamanmu tentang sistem bilangan '
                            'dengan waktu yang terbatas.',
                          ),
                        ],
                      ),
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
              const Text(
                'Pilih Batas Waktu',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 5),
              Text(
                'Semakin singkat waktunya, semakin tinggi tingkat tantangannya.',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: 12),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _timeChoices.length,
                gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 1.72,
                    ),
                itemBuilder: (context, index) =>
                    _buildTimeChoice(_timeChoices[index]),
              ),
              const SizedBox(height: 16),
              OutlineCard(
                child: const _ChallengeInfo(
                  icon: Icons.quiz_outlined,
                  title: 'Jumlah Soal',
                  value: '10 soal',
                ),
              ),
              const SizedBox(height: 18),
              FilledButton(
                onPressed: () {
                  unawaited(SoundManager.instance.playButtonClick());
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ChallengePage(
                        profile: widget.profile,
                        materialTitle: selectedMaterial,
                        durationMinutes: selectedDurationMinutes,
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
      ),
    );
  }
}

class _ChallengeTimeChoice {
  const _ChallengeTimeChoice({
    required this.minutes,
    required this.level,
    required this.description,
  });

  final int minutes;
  final String level;
  final String description;
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
  Widget build(BuildContext context) => Row(
    children: [
      Icon(icon),
      const SizedBox(width: 12),
      Expanded(child: Text(title)),
      Text(value, style: const TextStyle(fontWeight: FontWeight.w700)),
    ],
  );
}

class ChallengePage extends StatefulWidget {
  const ChallengePage({
    super.key,
    required this.profile,
    this.materialTitle = 'Biner',
    this.durationMinutes = 10,
  });

  final UserProfile profile;
  final String materialTitle;
  final int durationMinutes;

  @override
  State<ChallengePage> createState() => _ChallengePageState();
}

class _ChallengePageState extends State<ChallengePage> {
  late int seconds;
  int currentQuestion = 0;
  int selected = -1;
  int countdown = 3;
  bool isCountingDown = true;
  bool isExitDialogVisible = false;
  bool completionStarted = false;

  Timer? timer;
  Timer? countdownTimer;
  DateTime? startedAt;

  final List<int> answers = [];
  late final List<Question> _sessionQuestions;

  List<Question> get challengeQuestions => _sessionQuestions;

  @override
  void initState() {
    super.initState();
    seconds = widget.durationMinutes * 60;
    _sessionQuestions = selectQuestionsForSession(
      bank: challengeQuestionBank,
      materialTitle: widget.materialTitle,
    );

    // Bunyi saat angka 3 pertama kali ditampilkan.
    unawaited(SoundManager.instance.playButtonClick());

    countdownTimer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (!mounted) return;
      if (countdown <= 1) {
        t.cancel();
        setState(() {
          countdown = 0;
          isCountingDown = false;
        });
        _startTimer();
      } else {
        setState(() => countdown--);
        // Bunyi saat hitung mundur berubah menjadi 2 dan 1.
        unawaited(SoundManager.instance.playButtonClick());
      }
    });
  }

  void _startTimer() {
    startedAt = DateTime.now();
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
    countdownTimer?.cancel();
    timer?.cancel();
    super.dispose();
  }

  Future<void> _confirmExit() async {
    if (isExitDialogVisible || !mounted) return;
    isExitDialogVisible = true;
    final shouldExit = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Keluar dari Challenge?'),
        content: const Text(
          'Sesi challenge akan dibatalkan dan progres sesi ini tidak disimpan.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Lanjut'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text('Keluar'),
          ),
        ],
      ),
    );
    isExitDialogVisible = false;
    if (shouldExit == true && mounted) {
      countdownTimer?.cancel();
      timer?.cancel();
      Navigator.pop(context);
    }
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

  void finish({bool timeExpired = false}) async {
    if (completionStarted) return;
    completionStarted = true;
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
    final duration = Duration(
      seconds: timeExpired
          ? widget.durationMinutes * 60
          : DateTime.now().difference(startedAt ?? DateTime.now()).inSeconds,
    );

    try {
      await QuizHistoryRepository.instance.saveAttempt(
        QuizAttempt(
          id: 'challenge-${DateTime.now().microsecondsSinceEpoch}',
          completedAt: DateTime.now(),
          type: QuizHistoryRepository.challengeType,
          material: widget.materialTitle,
          totalQuestions: totalQuestions,
          correctAnswers: correctAnswers,
          incorrectAnswers: totalQuestions - correctAnswers,
          score: (correctAnswers * 100 / totalQuestions).round(),
          durationSeconds: duration.inSeconds,
          questions: _snapshotQuestions(challengeQuestions, answers),
        ),
      );
    } catch (error) {
      completionStarted = false;
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Riwayat gagal disimpan: $error')));
      }
      return;
    }
    if (!mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => ChallengeReactionPage(
          profile: widget.profile,
          materialTitle: widget.materialTitle,
          totalQuestions: totalQuestions,
          correctAnswers: correctAnswers,
          incorrectAnswers: totalQuestions - correctAnswers,
          score: (correctAnswers * 100 / totalQuestions).round(),
          duration: duration,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final question = challengeQuestions[currentQuestion];

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) _confirmExit();
      },
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              const PageTitle(title: 'Challenge', showBack: false),

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
                      isCountingDown ? 'Siap...' : formattedTime,
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
                child: isCountingDown
                    ? Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const FaiMascot(
                              assetName: 'faibit_challenge.png',
                              width: 150,
                              height: 150,
                              semanticLabel: 'Fai bersiap untuk challenge',
                            ),
                            Text(
                              '$countdown',
                              style: Theme.of(context).textTheme.displaySmall
                                  ?.copyWith(
                                    color: AppTheme.challenge.primary,
                                    fontWeight: FontWeight.w800,
                                  ),
                            ),
                          ],
                        ),
                      )
                    : _QuestionScreen(
                        showHeader: false,
                        title: '',
                        number: '',
                        value: 0,
                        question: question,
                        selected: selected,
                        onSelected: (i) {
                          unawaited(SoundManager.instance.playButtonClick());
                          setState(() => selected = i);
                        },
                        onNext: selected < 0
                            ? null
                            : () {
                                unawaited(SoundManager.instance.playButtonClick());
                                nextQuestion();
                              },
                        buttonColor: AppTheme.challenge.primary,
                        radioActiveColor: AppTheme.challenge.primary,
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ChallengeReactionPage extends StatefulWidget {
  const ChallengeReactionPage({
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
  State<ChallengeReactionPage> createState() => _ChallengeReactionPageState();
}

class _ChallengeReactionPageState extends State<ChallengeReactionPage> {
  Timer? _transitionTimer;
  bool _isOpeningResult = false;

  bool get _isSuccessful => widget.score >= 50;

  // Durasi mengikuti seluruh frame pada masing-masing Animated WebP:
  // celebration sekitar 3,6 detik dan encouragement sekitar 6 detik.
  Duration get _animationDuration => _isSuccessful
      ? const Duration(milliseconds: 3700)
      : const Duration(milliseconds: 6100);

  String get _animationAsset => _isSuccessful
      ? 'assets/images/fai/fai_celebration_3_transparent.webp'
      : 'assets/images/fai/fai_encouragement_transparent.webp';


  @override
  void initState() {
    super.initState();

    // SFX mengikuti hasil akhir Challenge.
    if (_isSuccessful) {
      unawaited(SoundManager.instance.playFaiCelebration());
    } else {
      unawaited(SoundManager.instance.playFaiEncouragement());
    }

    _transitionTimer = Timer(_animationDuration, () {
      unawaited(_openResult());
    });
  }


  @override
  void dispose() {
    _transitionTimer?.cancel();
    super.dispose();
  }


  Future<void> _openResult({bool playClick = false}) async {
    if (!mounted || _isOpeningResult) return;

    _isOpeningResult = true;
    _transitionTimer?.cancel();

    // Hentikan suara Fai sebelum berpindah ke halaman hasil.
    await SoundManager.instance.stop();

    // Jika pengguna menekan Skip, bunyikan klik setelah suara Fai berhenti.
    if (playClick) {
      await SoundManager.instance.playButtonClick();
    }

    if (!mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => ChallengeResultPage(
          profile: widget.profile,
          materialTitle: widget.materialTitle,
          totalQuestions: widget.totalQuestions,
          correctAnswers: widget.correctAnswers,
          incorrectAnswers: widget.incorrectAnswers,
          score: widget.score,
          duration: widget.duration,
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.challenge.surface,
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Layar ini sengaja hanya berisi animasi Fai, tanpa teks lain.
            Center(
              child: SizedBox(
                width: 280,
                height: 368,
                child: Image.asset(
                  _animationAsset,
                  fit: BoxFit.contain,
                  gaplessPlayback: true,
                  semanticLabel: _isSuccessful
                      ? 'Animasi Fai merayakan keberhasilan challenge'
                      : 'Animasi Fai menyemangati pengguna',
                  errorBuilder: (_, _, _) => FaiMascot(
                    assetName: _isSuccessful
                        ? 'faibit_celebrate2.png'
                        : 'faibit_encourage.png',
                    fallbackAssetName: _isSuccessful
                        ? 'faibit_celebrate.png'
                        : null,
                    width: 280,
                    height: 368,
                    semanticLabel: 'Fai',
                  ),
                ),
              ),
            ),
            Positioned(
              top: 8,
              right: 8,
              child: Opacity(
                opacity: 0.48,
                child: TextButton(
                  onPressed: () {
                    unawaited(_openResult(playClick: true));
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: AppTheme.challenge.accentDark,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: const Text(
                    'Skip',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
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

  bool get _isSuccessful => score >= 50;

  @override
  Widget build(BuildContext context) {
    final durationLabel = _formatDuration(duration);
    final resultColor = _isSuccessful
        ? AppTheme.greenTeal
        : AppTheme.challenge.primaryDark;
    final resultSurface = _isSuccessful
        ? AppTheme.tealSurface
        : AppTheme.challenge.surface;

    return Scaffold(
      appBar: const PageTitle(title: 'Hasil Challenge'),
      body: _PlayChallengeCompleteSound(
        child: SafeArea(
          child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              OutlineCard(
                child: Column(
                  children: [
                    _isSuccessful
                        ? const FaiMascot(
                            assetName: 'faibit_celebrate2.png',
                            fallbackAssetName: 'faibit_celebrate.png',
                            width: 190,
                            height: 220,
                            semanticLabel: 'Fai merayakan hasil challenge',
                          )
                        : const FaiMascot(
                            assetName: 'faibit_encourage.png',
                            width: 190,
                            height: 220,
                            semanticLabel: 'Fai menyemangati pengguna',
                          ),
                    const SizedBox(height: 10),
                    Text(
                      _isSuccessful ? 'Hebat! Challenge Selesai!' : 'Tetap Semangat!',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      _isSuccessful
                          ? 'Kamu berhasil menyelesaikan challenge ini. Pertahankan semangat belajarmu!'
                          : 'Tidak apa-apa, masih ada kesempatan untuk belajar lagi. Fai tetap menyemangatimu!',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: AppTheme.challenge.accentDark),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              AnimatedContainer(
                duration: const Duration(milliseconds: 350),
                curve: Curves.easeInOut,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 18,
                ),
                decoration: BoxDecoration(
                  color: resultSurface,
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
                    TweenAnimationBuilder<double>(
                      tween: Tween<double>(begin: 0, end: score.toDouble()),
                      duration: const Duration(milliseconds: 1100),
                      curve: Curves.easeOutCubic,
                      builder: (context, value, _) => Text(
                        '${value.round()}%',
                        style: TextStyle(
                          color: resultColor,
                          fontSize: 48,
                          fontWeight: FontWeight.w800,
                          height: 1.1,
                        ),
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
                onPressed: () {
                  unawaited(SoundManager.instance.playButtonClick());
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
                child: const Text('Kembali ke Menu'),
              ),
              const SizedBox(height: 10),
              FilledButton(
                onPressed: () {
                  unawaited(SoundManager.instance.playButtonClick());
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ChallengePreparationPage(profile: profile),
                    ),
                  );
                },
                style: FilledButton.styleFrom(
                  backgroundColor: AppTheme.challenge.primary,
                ),
                child: const Text('Coba Lagi'),
              ),
            ],
          ),
        ),
      ),
      ),
    );
  }
}

class _PlayChallengeCompleteSound extends StatefulWidget {
  const _PlayChallengeCompleteSound({required this.child});

  final Widget child;

  @override
  State<_PlayChallengeCompleteSound> createState() =>
      _PlayChallengeCompleteSoundState();
}

class _PlayChallengeCompleteSoundState
    extends State<_PlayChallengeCompleteSound> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        unawaited(SoundManager.instance.playQuizComplete());
      }
    });
  }

  @override
  Widget build(BuildContext context) => widget.child;
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
                    const FaiMascot(
                      assetName: 'faibit_celebrate.png',
                      width: 132,
                      height: 154,
                      semanticLabel: 'Fai merayakan hasil latihan',
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
                onPressed: () {
                  unawaited(SoundManager.instance.playButtonClick());
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => QuizReviewPage(
                        materialTitle: materialTitle,
                        questions: questions,
                        answers: answers,
                      ),
                    ),
                  );
                },
                child: const Text('Lihat Pembahasan'),
              ),
              const SizedBox(height: 10),
              FilledButton(
                onPressed: () {
                  unawaited(SoundManager.instance.playButtonClick());
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => QuizPage(materialTitle: materialTitle),
                    ),
                  );
                },
                child: const Text('Coba Latihan Lagi'),
              ),
              const SizedBox(height: 10),
              OutlinedButton(
                onPressed: () {
                  unawaited(SoundManager.instance.playButtonClick());
                  Navigator.popUntil(context, (r) => r.isFirst);
                },
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

List<QuizQuestionResult> _snapshotQuestions(
  List<Question> questions,
  List<int> answers,
) => questions.asMap().entries.map((entry) {
  final question = entry.value;
  final selectedIndex = entry.key < answers.length ? answers[entry.key] : -1;
  final selectedAnswer =
      selectedIndex >= 0 && selectedIndex < question.options.length
      ? question.options[selectedIndex]
      : 'Tidak dijawab';
  return QuizQuestionResult(
    question: question.question,
    selectedAnswer: selectedAnswer,
    correctAnswer: question.options[question.correct],
    isCorrect: selectedIndex == question.correct,
    explanation: question.explanation,
  );
}).toList();

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
