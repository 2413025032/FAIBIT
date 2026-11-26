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
  final Future<void> Function(UserProfile) onProfileChanged;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late Future<List<QuizAttempt>> _recentAttempts;

  UserProfile get profile => widget.profile;

  @override
  void initState() {
    super.initState();
    _recentAttempts = QuizHistoryRepository.loadStoredAttempts();
    QuizHistoryRepository.attemptsRevision.addListener(_refreshAttempts);
  }

  @override
  void dispose() {
    QuizHistoryRepository.attemptsRevision.removeListener(_refreshAttempts);
    super.dispose();
  }

  void _refreshAttempts() {
    if (!mounted) return;
    setState(() {
      _recentAttempts = QuizHistoryRepository.loadStoredAttempts();
    });
  }

  void _openEdit(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => EditProfilePage(
          profile: profile,
          onSaved: widget.onProfileChanged,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Scaffold(
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
        child: FutureBuilder<List<QuizAttempt>>(
          future: _recentAttempts,
          builder: (context, snapshot) {
            final attempts = snapshot.data ?? const <QuizAttempt>[];
            final practiceCount = attempts.where((item) {
              final type = item.type.trim().toLowerCase();
              return type == QuizHistoryRepository.practiceType.toLowerCase() ||
                  type == 'latihan' ||
                  type == 'practice';
            }).length;
            final challengeCount = attempts.where((item) {
              return item.type.trim().toLowerCase() ==
                      QuizHistoryRepository.challengeType.toLowerCase() ||
                  item.type.trim().toLowerCase() == 'tantangan';
            }).length;
            final recent = attempts.take(3).toList();

            final profilePrimary = Theme.of(context).colorScheme.primary;
            final profileDeep = Color.lerp(profilePrimary, Colors.black, 0.22)!;

            return ListView(
              padding: const EdgeInsets.fromLTRB(18, 8, 18, 28),
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(20, 22, 20, 18),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [profilePrimary, profileDeep],
                    ),
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: profilePrimary.withValues(alpha: 0.22),
                        blurRadius: 18,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(3),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.white.withValues(alpha: 0.8),
                                width: 2,
                              ),
                            ),
                            child: CircleAvatar(
                              radius: 39,
                              backgroundColor: Colors.white.withValues(alpha: 0.2),
                              foregroundColor: Colors.white,
                              backgroundImage: profile.photoPath != null
                                  ? FileImage(File(profile.photoPath!))
                                  : null,
                              child: profile.photoPath == null
                                  ? const Icon(Icons.person_outline, size: 42)
                                  : null,
                            ),
                          ),
                          const SizedBox(width: 15),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  profile.name,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: theme.textTheme.titleLarge?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  'Kelas ${profile.schoolClass}',
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    color: Colors.white.withValues(alpha: 0.92),
                                  ),
                                ),
                                Text(
                                  profile.school,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    color: Colors.white.withValues(alpha: 0.82),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        child: FilledButton.icon(
                          onPressed: () => _openEdit(context),
                          icon: const Icon(Icons.edit_outlined, size: 18),
                          label: const Text('Edit Profil'),
                          style: FilledButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: const Color(0xFF08765D),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'Aktivitas Belajar',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 10),
                if (snapshot.connectionState == ConnectionState.waiting)
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 22),
                    child: Center(child: CircularProgressIndicator()),
                  )
                else if (snapshot.hasError)
                  OutlineCard(
                    child: Text(
                      'Aktivitas belajar belum dapat dimuat.',
                      style: theme.textTheme.bodyMedium,
                    ),
                  )
                else
                  Row(
                    children: [
                      Expanded(
                        child: _ProfileStat(
                          icon: Icons.assignment_outlined,
                          label: 'Total Sesi',
                          value: '${attempts.length}',
                          color: colors.primary,
                        ),
                      ),
                      const SizedBox(width: 9),
                      Expanded(
                        child: _ProfileStat(
                          icon: Icons.edit_note_rounded,
                          label: 'Latihan',
                          value: '$practiceCount',
                          color: colors.primary,
                        ),
                      ),
                      const SizedBox(width: 9),
                      Expanded(
                        child: _ProfileStat(
                          icon: Icons.timer_outlined,
                          label: 'Challenge',
                          value: '$challengeCount',
                          color: AppTheme.challengeOrange,
                        ),
                      ),
                    ],
                  ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Aktivitas Terbaru',
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    if (attempts.isNotEmpty)
                      Text(
                        '${attempts.length} aktivitas',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: colors.onSurfaceVariant,
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 10),
                if (snapshot.connectionState == ConnectionState.waiting)
                  const SizedBox.shrink()
                else if (recent.isEmpty)
                  OutlineCard(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Icon(
                          Icons.auto_stories_outlined,
                          size: 38,
                          color: colors.primary,
                        ),
                        const SizedBox(height: 9),
                        Text(
                          'Belum ada aktivitas belajar',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          'Mulai Latihan Santai atau Challenge. Hasil pengerjaanmu akan muncul di sini.',
                          textAlign: TextAlign.center,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: colors.onSurfaceVariant,
                            height: 1.45,
                          ),
                        ),
                      ],
                    ),
                  )
                else
                  ...recent.map(
                    (attempt) => Padding(
                      padding: const EdgeInsets.only(bottom: 9),
                      child: OutlineCard(
                        padding: const EdgeInsets.all(14),
                        child: _AttemptSummary(attempt: attempt),
                      ),
                    ),
                  ),
                const SizedBox(height: 14),
                Text(
                  'Informasi Akun',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 10),
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
              ],
            );
          },
        ),
      ),
    );
  }
}

class _ProfileStat extends StatelessWidget {
  const _ProfileStat({
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
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 13),
    child: Column(
      children: [
        Icon(icon, color: color, size: 21),
        const SizedBox(height: 7),
        Text(
          value,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.labelSmall,
        ),
      ],
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
