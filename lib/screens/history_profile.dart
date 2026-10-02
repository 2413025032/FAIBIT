import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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

  File? _profileImage;

  Future<void> _pickProfileImage() async {
    final picker = ImagePicker();

    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile == null) return;

    setState(() {
      _profileImage = File(pickedFile.path);
    });
  }

  void _openEdit(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => EditProfilePage(
          profile: profile,
          onSaved: onProfileChanged,
        ),
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
            child: Row(
              children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  CircleAvatar(
                    radius: 34,
                    backgroundColor: AppTheme.tealSurface,
                    foregroundColor: AppTheme.darkGray,
                    backgroundImage:
                        _profileImage != null ? FileImage(_profileImage!) : null,
                    child: _profileImage == null
                        ? const Icon(Icons.person_outline, size: 38)
                        : null,
                  ),
                  Positioned(
                    right: -4,
                    bottom: -4,
                    child: Material(
                      color: Theme.of(context).colorScheme.primary,
                      shape: const CircleBorder(),
                      child: InkWell(
                        onTap: _pickProfileImage,
                        customBorder: const CircleBorder(),
                        child: const Padding(
                          padding: EdgeInsets.all(7),
                          child: Icon(
                            Icons.edit_outlined,
                            size: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        profile.name,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 3),
                      Text('Kelas ${profile.schoolClass}'),
                      Text(profile.school, style: Theme.of(context).textTheme.bodySmall),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Text('Akun Saya', style: TextStyle(fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          _ProfileDetail(label: 'Nama', value: profile.name),
          _ProfileDetail(label: 'Kelas', value: profile.schoolClass),
          _ProfileDetail(label: 'Sekolah', value: profile.school),
          const SizedBox(height: 20),
          OutlineCard(
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const SettingsPage()),
            ),
            child: const Row(
              children: [
                Icon(Icons.settings_outlined),
                SizedBox(width: 14),
                Expanded(
                  child: Text(
                    'Pengaturan',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                ),
                Icon(Icons.chevron_right),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

class _ProfileDetail extends StatelessWidget {
  const _ProfileDetail({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Row(
      children: [
        SizedBox(
          width: 78,
          child: Text(label, style: Theme.of(context).textTheme.bodySmall),
        ),
        Expanded(child: Text(value)),
      ],
    ),
  );
}
