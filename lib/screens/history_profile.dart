import 'dart:io';

import 'package:flutter/material.dart';

import '../data/mock_data.dart';
import '../models/models.dart';
import '../theme/app_theme.dart';
import '../widgets/ui.dart';
import 'profile_settings_screens.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});
  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  int filter = 0;
  final labels = ['Semua', 'Materi', 'Latihan', 'Challenge'];

  @override
  Widget build(BuildContext context) {
    final shown = filter == 0
        ? activities
        : activities.where((a) => a.type == labels[filter]).toList();
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
          child: ListView.separated(
            padding: const EdgeInsets.all(20),
            itemCount: shown.length,
            separatorBuilder: (_, _) => const SizedBox(height: 9),
            itemBuilder: (_, i) {
              final a = shown[i];
              return OutlineCard(
                child: ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: CircleAvatar(
                    backgroundColor: AppTheme.soft,
                    foregroundColor: AppTheme.ink,
                    child: Icon(
                      a.type == 'Materi'
                          ? Icons.menu_book_outlined
                          : Icons.emoji_events_outlined,
                    ),
                  ),
                  title: Text(
                    a.title,
                    style: const TextStyle(fontWeight: FontWeight.w700),
                  ),
                  subtitle: Text('${a.detail}\n${a.time}'),
                  trailing: const Icon(Icons.chevron_right),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
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
  UserProfile get profile => widget.profile;
  ValueChanged<UserProfile> get onProfileChanged => widget.onProfileChanged;

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
                          Text('Kelas ${profile.schoolClass}'),
                          Text(
                            profile.school,
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
                  icon: Icons.person_outline,
                  label: 'Nama',
                  value: profile.name,
                ),
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
          OutlineCard(child: _ActivitySummary(activity: activities.first)),
        ],
      ),
    ),
  );
}

class _ActivitySummary extends StatelessWidget {
  const _ActivitySummary({required this.activity});

  final ActivityItem activity;

  @override
  Widget build(BuildContext context) => Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      CircleAvatar(
        radius: 22,
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        foregroundColor: Theme.of(context).colorScheme.primary,
        child: Icon(
          activity.type == 'Materi'
              ? Icons.menu_book_outlined
              : activity.type == 'Challenge'
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
              activity.title,
              style: Theme.of(context).textTheme.titleMedium
                  ?.copyWith(fontSize: 14),
            ),
            if (activity.detail.isNotEmpty) ...[
              const SizedBox(height: 3),
              Text(activity.detail),
            ],
            const SizedBox(height: 3),
            Text(activity.time, style: Theme.of(context).textTheme.bodySmall),
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
