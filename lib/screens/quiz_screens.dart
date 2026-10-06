import 'dart:async';

import 'package:flutter/material.dart';

import '../data/mock_data.dart';
import '../models/models.dart';
import '../widgets/ui.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});
  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int selected = -1;
  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      child: _QuestionScreen(
        title: 'Latihan Santai',
        number: 'Soal 3 dari 10',
        value: .3,
        question: questions[0],
        selected: selected,
        onSelected: (i) => setState(() => selected = i),
        onNext: selected < 0
            ? null
            : () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      FeedbackPage(question: questions[0], selected: selected),
                ),
              ),
      ),
    ),
  );
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
  });
  final bool showHeader;
  final String title, number;
  final double value;
  final Question question;
  final int selected;
  final ValueChanged<int> onSelected;
  final VoidCallback? onNext;
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
                          activeColor: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              FilledButton(
                onPressed: onNext,
                child: const Text('Selanjutnya'),
              ),
            ]
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
  const ChallengePreparationPage({
    super.key,
    required this.profile,
  });

  final UserProfile profile;

  @override
  State<ChallengePreparationPage> createState() =>
      _ChallengePreparationPageState();
}

class _ChallengePreparationPageState
    extends State<ChallengePreparationPage> {
  String selectedMaterial = materials.first.title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PageTitle(
        title: 'Persiapan Challenge',
      ),
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
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.w800,
                    ),
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
              style: TextStyle(
                fontWeight: FontWeight.w700,
              ),
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
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.w700,
          ),
        ),
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

  List<Question> get challengeQuestions => questions;

  @override
  void initState() {
    super.initState();

    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (seconds <= 1) {
        t.cancel();
        finish();
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

  void finish() {
    timer?.cancel();

    if (!mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => ChallengeResultPage(
          profile: widget.profile,
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
            const PageTitle(
              title: 'Challenge',
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 8),
              child: Row(
                children: [
                  Text(
                    'Soal ${currentQuestion + 1} dari ${challengeQuestions.length}',
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const Spacer(),
                  const Icon(Icons.timer_outlined),
                  const SizedBox(width: 5),
                  Text(
                    formattedTime,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ProgressLine(
                value: (currentQuestion + 1) /
                    challengeQuestions.length,
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChallengeResultPage extends StatelessWidget {
  const ChallengeResultPage({super.key, required this.profile});

  final UserProfile profile;
  @override
  Widget build(BuildContext context) => ResultPage(
    challenge: true,
    onRetry: () => Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => ChallengePage(profile: profile)),
    ),
  );
}

class ResultPage extends StatelessWidget {
  const ResultPage({super.key, required this.challenge, required this.onRetry});
  final bool challenge;
  final VoidCallback onRetry;
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
              child: const Column(
                children: [
                  _Stat('Materi', 'Biner'),
                  _Stat('Jumlah Soal', '10'),
                  _Stat('Jawaban Benar', '8'),
                  _Stat('Jawaban Salah', '2'),
                  _Stat('Skor', '80%'),
                  _Stat('Waktu', '05:12'),
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
