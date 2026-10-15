import 'dart:io';

import 'package:flutter/material.dart';

import '../data/quiz_history_repository.dart';
import '../models/models.dart';
import '../theme/app_theme.dart';
import '../widgets/ui.dart';
import 'quiz_screens.dart';
import 'profile_settings_screens.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key, this.refreshToken = 0});

  final int refreshToken;

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  int filter = 0;
  static const labels = [
    'Semua',
    QuizHistoryRepository.practiceType,
    QuizHistoryRepository.challengeType,
  ];
  late Future<List<QuizAttempt>> _attempts;

  @override
  void initState() {
    super.initState();
    _attempts = QuizHistoryRepository.loadStoredAttempts();
  }

  @override
  void didUpdateWidget(covariant HistoryPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.refreshToken != widget.refreshToken) {
      _reloadAttempts();
    }
  }

  Future<void> _reloadAttempts() async {
    try {
      final attempts = await QuizHistoryRepository.loadStoredAttempts();
      if (!mounted) return;
      setState(() {
        _attempts = Future<List<QuizAttempt>>.value(attempts);
      });
    } catch (error, stackTrace) {
      if (!mounted) return;
      setState(() {
        _attempts = Future<List<QuizAttempt>>.error(error, stackTrace);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const PageTitle(title: 'Riwayat', showBack: false),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 4, 20, 8),
          child: Row(
            children: List.generate(
              labels.length,
              (i) => Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2),
                  child: ChoiceChip(
                    label: Text(
                      labels[i],
                      style: const TextStyle(fontSize: 11),
                    ),
                    selected: filter == i,
                    onSelected: (_) => setState(() => filter = i),
                  ),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: FutureBuilder<List<QuizAttempt>>(
            future: _attempts,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return _HistoryMessage(
                  icon: Icons.error_outline,
                  title: 'Riwayat belum dapat dimuat',
                  message: '${snapshot.error}',
                  onPressed: () {
                    _reloadAttempts();
                  },
                  buttonLabel: 'Coba lagi',
                );
              }
              final attempts = (snapshot.data ?? [])
                  .where(
                    (attempt) => filter == 0 || attempt.type == labels[filter],
                  )
                  .toList();
              if (attempts.isEmpty) {
                return _HistoryMessage(
                  icon: Icons.history_outlined,
                  title: 'Belum ada riwayat kuis',
                  message: 'Selesaikan Latihan Santai atau Challenge untuk melihat hasilnya di sini.',
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const PracticeMaterialSelectionPage(),
                    ),
                  ),
                  buttonLabel: 'Lihat Latihan Santai',
                );
              }
              return ListView.separated(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
                itemCount: attempts.length,
                separatorBuilder: (_, _) => const SizedBox(height: 10),
                itemBuilder: (_, index) =>
                    _AttemptTile(attempt: attempts[index]),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _HistoryMessage extends StatelessWidget {
  const _HistoryMessage({
    required this.icon,
    required this.title,
    required this.message,
    required this.onPressed,
    required this.buttonLabel,
  });

  final IconData icon;
  final String title;
  final String message;
  final VoidCallback onPressed;
  final String buttonLabel;

  @override
  Widget build(BuildContext context) => Center(
    child: Padding(
      padding: const EdgeInsets.all(28),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 54, color: Theme.of(context).colorScheme.primary),
          const SizedBox(height: 12),
          Text(
            title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleLarge
                ?.copyWith(fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 8),
          Text(message, textAlign: TextAlign.center),
          const SizedBox(height: 18),
          OutlinedButton(onPressed: onPressed, child: Text(buttonLabel)),
        ],
      ),
    ),
  );
}

class _AttemptTile extends StatelessWidget {
  const _AttemptTile({required this.attempt});

  final QuizAttempt attempt;

  @override
  Widget build(BuildContext context) => OutlineCard(
    onTap: () => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => QuizAttemptDetailPage(attempt: attempt),
      ),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          backgroundColor: attempt.type == 'Challenge'
              ? AppTheme.challenge.surface
              : Theme.of(context).colorScheme.primaryContainer,
          foregroundColor: attempt.type == 'Challenge'
              ? AppTheme.challenge.primaryDark
              : Theme.of(context).colorScheme.primary,
          child: Icon(
            attempt.type == 'Challenge'
                ? Icons.emoji_events_outlined
                : Icons.edit_note_outlined,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                attempt.type,
                style: Theme.of(context).textTheme.titleMedium
                    ?.copyWith(fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 3),
              Text(attempt.material),
              const SizedBox(height: 5),
              Text(
                '${_formatDate(attempt.completedAt)} • '
                '${_formatDuration(attempt.durationSeconds)}',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: 5),
              Text(
                '${attempt.score}% • ${attempt.correctAnswers} benar, '
                '${attempt.incorrectAnswers} salah',
                style: const TextStyle(fontWeight: FontWeight.w700),
              ),
            ],
          ),
        ),
        const Icon(Icons.chevron_right),
      ],
    ),
  );
}

class QuizAttemptDetailPage extends StatelessWidget {
  const QuizAttemptDetailPage({super.key, required this.attempt});

  final QuizAttempt attempt;

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: PageTitle(title: 'Detail ${attempt.type}'),
    body: SafeArea(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 24),
        children: [
          OutlineCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  attempt.material,
                  style: Theme.of(context).textTheme.headlineSmall
                      ?.copyWith(fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 6),
                Text(_formatDate(attempt.completedAt)),
                Text('Durasi ${_formatDuration(attempt.durationSeconds)}'),
                const Divider(height: 24),
                Text(
                  '${attempt.score}%',
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Text(
                  '${attempt.correctAnswers} benar • '
                  '${attempt.incorrectAnswers} salah dari '
                  '${attempt.totalQuestions} soal',
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          ...attempt.questions.asMap().entries.map(
            (entry) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _QuestionAttemptCard(
                number: entry.key + 1,
                result: entry.value,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

class _QuestionAttemptCard extends StatelessWidget {
  const _QuestionAttemptCard({required this.number, required this.result});

  final int number;
  final QuizQuestionResult result;

  @override
  Widget build(BuildContext context) => OutlineCard(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              result.isCorrect
                  ? Icons.check_circle_outline
                  : Icons.cancel_outlined,
              color: result.isCorrect
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.error,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                'Soal $number',
                style: const TextStyle(fontWeight: FontWeight.w800),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Text(
          result.question,
          style: const TextStyle(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 10),
        Text('Jawabanmu: ${result.selectedAnswer}'),
        Text('Jawaban benar: ${result.correctAnswer}'),
        const Divider(),
        const Text(
          'Pembahasan:',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 3),
        Text(result.explanation),
      ],
    ),
  );
}

String _formatDate(DateTime date) =>
    '${date.day.toString().padLeft(2, '0')}/'
    '${date.month.toString().padLeft(2, '0')}/${date.year} '
    '${date.hour.toString().padLeft(2, '0')}:'
    '${date.minute.toString().padLeft(2, '0')}';

String _formatDuration(int seconds) {
  final minutes = seconds ~/ 60;
  final remainingSeconds = seconds % 60;
  return '${minutes.toString().padLeft(2, '0')}:'
      '${remainingSeconds.toString().padLeft(2, '0')}';
}

class ProfilePage extends StatefulWidget {
  const ProfilePage({
    super.key,
    required this.profile,
    required this.onProfileChanged,
  });

  final UserProfile profile;
  final ValueChanged<UserProfile> onProfileChanged;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late Future<List<QuizAttempt>> _recentAttempts;

  UserProfile get profile => widget.profile;
  ValueChanged<UserProfile> get onProfileChanged => widget.onProfileChanged;

  @override
  void initState() {
    super.initState();
    _recentAttempts = QuizHistoryRepository.loadStoredAttempts();
  }

  void _openEdit(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) =>
            EditProfilePage(profile: profile, onSaved: onProfileChanged),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: PageTitle(
      title: 'Profil',
      showBack: false,
      actions: [
        IconButton(
          tooltip: 'Edit Profil',
          onPressed: () => _openEdit(context),
          icon: const Icon(Icons.edit_outlined),
        ),
      ],
    ),
    body: SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          OutlineCard(
            padding: const EdgeInsets.all(18),
            child: Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 42,
                      backgroundColor: Theme.of(context)
                          .colorScheme
                          .primaryContainer,
                      foregroundColor: Theme.of(context).colorScheme.primary,
                      backgroundImage: profile.photoPath != null
                          ? FileImage(File(profile.photoPath!))
                          : null,
                      child: profile.photoPath == null
                          ? const Icon(Icons.person_outline, size: 46)
                          : null,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            profile.name,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.headlineSmall
                                ?.copyWith(fontWeight: FontWeight.w800),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            'Kelas ${profile.schoolClass} • ${profile.school}',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: () => _openEdit(context),
                    icon: const Icon(Icons.edit_outlined),
                    label: const Text('Edit Profil'),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Informasi Akun',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          OutlineCard(
            child: Column(
              children: [
                _ProfileDetail(
                  icon: Icons.school_outlined,
                  label: 'Kelas',
                  value: profile.schoolClass,
                ),
                _ProfileDetail(
                  icon: Icons.business_outlined,
                  label: 'Sekolah',
                  value: profile.school,
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Aktivitas Terbaru',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          FutureBuilder<List<QuizAttempt>>(
            future: _recentAttempts,
            builder: (context, snapshot) {
              final attempt = snapshot.data != null && snapshot.data!.isNotEmpty
                  ? snapshot.data!.first
                  : null;
              if (attempt == null) return const SizedBox.shrink();
              return OutlineCard(child: _AttemptSummary(attempt: attempt));
            },
          ),
        ],
      ),
    ),
  );
}

class _AttemptSummary extends StatelessWidget {
  const _AttemptSummary({required this.attempt});

  final QuizAttempt attempt;

  @override
  Widget build(BuildContext context) => Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      CircleAvatar(
        radius: 22,
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        foregroundColor: Theme.of(context).colorScheme.primary,
        child: Icon(
          attempt.type == 'Challenge'
              ? Icons.emoji_events_outlined
              : Icons.edit_note_outlined,
        ),
      ),
      const SizedBox(width: 12),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              attempt.type,
              style: Theme.of(context).textTheme.titleMedium
                  ?.copyWith(fontSize: 14),
            ),
            const SizedBox(height: 3),
            Text('${attempt.material} • Skor ${attempt.score}%'),
            const SizedBox(height: 3),
            Text(
              '${_formatDate(attempt.completedAt)} • '
              '${_formatDuration(attempt.durationSeconds)}',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    ],
  );
}

class _ProfileDetail extends StatelessWidget {
  const _ProfileDetail({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Row(
      children: [
        Icon(icon, color: Theme.of(context).colorScheme.primary),
        const SizedBox(width: 12),
        SizedBox(
          width: 70,
          child: Text(label, style: Theme.of(context).textTheme.bodySmall),
        ),
        Expanded(child: Text(value)),
      ],
    ),
  );
}
