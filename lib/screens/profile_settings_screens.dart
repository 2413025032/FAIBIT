import 'package:flutter/material.dart';

import '../models/models.dart';
import '../theme/app_theme.dart';
import '../widgets/ui.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({
    super.key,
    required this.profile,
    required this.onSaved,
  });

  final UserProfile profile;
  final ValueChanged<UserProfile> onSaved;

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late final TextEditingController _nameController;
  late final TextEditingController _classController;
  late final TextEditingController _schoolController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.profile.name);
    _classController = TextEditingController(text: widget.profile.schoolClass);
    _schoolController = TextEditingController(text: widget.profile.school);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _classController.dispose();
    _schoolController.dispose();
    super.dispose();
  }

  bool get _hasChanges {
    return _nameController.text.trim() != widget.profile.name ||
        _classController.text.trim() != widget.profile.schoolClass ||
        _schoolController.text.trim() != widget.profile.school;
  }

  void _save() {
    final name = _nameController.text.trim();
    final schoolClass = _classController.text.trim();
    final school = _schoolController.text.trim();

    if (name.isEmpty || schoolClass.isEmpty || school.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Nama, kelas, dan sekolah wajib diisi.'),
        ),
      );
      return;
    }

    final updatedProfile = UserProfile(
      name: name,
      schoolClass: schoolClass,
      school: school,
    );

    widget.onSaved(updatedProfile);
    Navigator.of(context).pop();
  }

  Future<bool> _handleBack() async {
  if (!_hasChanges) {
    return true;
  }

  final result = await showDialog<String>(
    context: context,
    barrierDismissible: false,
    builder: (dialogContext) => Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 24, 24, 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Perubahan belum disimpan',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            ),
            const SizedBox(height: 12),
            Text(
              'Kamu memiliki perubahan pada profil yang belum disimpan.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 24),
            Wrap(
              alignment: WrapAlignment.end,
              spacing: 8,
              runSpacing: 8,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(dialogContext).pop('cancel');
                  },
                  child: const Text('Batal'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(dialogContext).pop('discard');
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: Theme.of(context).colorScheme.error,
                  ),
                  child: const Text('Buang'),
                ),
                FilledButton(
                  onPressed: () {
                    Navigator.of(dialogContext).pop('save');
                  },
                  child: const Text('Simpan'),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );

  if (result == 'save') {
    _save();
    return false;
  }

  if (result == 'discard') {
    return true;
  }

  return false;
}

@override
Widget build(BuildContext context) {
  return PopScope(
    canPop: !_hasChanges,
    onPopInvokedWithResult: (didPop, result) async {
      if (didPop) return;

      final shouldPop = await _handleBack();

      if (shouldPop && mounted) {
        Navigator.of(context).pop();
      }
    },
    child: Scaffold(
      appBar: PageTitle(
      title: 'Edit Profil',
      showBack: true,
      onBack: () async {
        final shouldPop = await _handleBack();

        if (shouldPop && mounted) {
          Navigator.of(context).pop();
        }
      },
    ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Center(
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  const CircleAvatar(
                    radius: 48,
                    backgroundColor: AppTheme.tealSurface,
                    foregroundColor: AppTheme.darkGray,
                    child: Icon(
                      Icons.person_outline,
                      size: 52,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      shape: BoxShape.circle,
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(7),
                      child: Icon(
                        Icons.edit_outlined,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),
            Text(
              'Nama',
              style: Theme.of(context).textTheme.labelLarge,
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _nameController,
              onChanged: (_) => setState(() {}),
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                hintText: 'Masukkan nama',
                prefixIcon: Icon(Icons.person_outline),
              ),
            ),
            const SizedBox(height: 18),
            Text(
              'Kelas',
              style: Theme.of(context).textTheme.labelLarge,
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _classController,
              onChanged: (_) => setState(() {}),
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                hintText: 'Masukkan kelas',
                prefixIcon: Icon(Icons.school_outlined),
              ),
            ),
            const SizedBox(height: 18),
            Text(
              'Sekolah',
              style: Theme.of(context).textTheme.labelLarge,
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _schoolController,
              onChanged: (_) => setState(() {}),
              textInputAction: TextInputAction.done,
              decoration: const InputDecoration(
                hintText: 'Masukkan sekolah',
                prefixIcon: Icon(Icons.account_balance_outlined),
              ),
            ),
            const SizedBox(height: 28),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: _save,
                child: const Text('Simpan'),
              ),
            ),
          ],
        ),
      ),
    ),
    );
  }
}

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  void _showDeleteConfirmation(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Hapus Data'),
        content: const Text(
          'Semua data lokal FAIBIT akan dihapus. '
          'Tindakan ini tidak dapat dibatalkan.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'Penghapusan data belum terhubung ke penyimpanan lokal.',
                  ),
                ),
              );
            },
            child: const Text('Hapus Data'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PageTitle(
        title: 'Pengaturan',
        showBack: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            'Tampilan',
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 10),
          OutlineCard(
            child: Column(
              children: [
                RadioListTile<String>(
                  value: 'light',
                  groupValue: 'system',
                  onChanged: (_) {},
                  title: const Text('Light'),
                  subtitle: const Text('Gunakan tampilan terang'),
                  contentPadding: EdgeInsets.zero,
                ),
                RadioListTile<String>(
                  value: 'dark',
                  groupValue: 'system',
                  onChanged: (_) {},
                  title: const Text('Dark'),
                  subtitle: const Text('Gunakan tampilan gelap'),
                  contentPadding: EdgeInsets.zero,
                ),
                RadioListTile<String>(
                  value: 'system',
                  groupValue: 'system',
                  onChanged: (_) {},
                  title: const Text('System'),
                  subtitle: const Text(
                    'Ikuti pengaturan tampilan perangkat',
                  ),
                  contentPadding: EdgeInsets.zero,
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Informasi',
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 10),
          OutlineCard(
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => const MaterialSourcesPage(),
              ),
            ),
            child: const Row(
              children: [
                Icon(Icons.menu_book_outlined),
                SizedBox(width: 14),
                Expanded(
                  child: Text(
                    'Sumber Materi',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
                Icon(Icons.chevron_right),
              ],
            ),
          ),
          const SizedBox(height: 10),
          OutlineCard(
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => const AboutPage(),
              ),
            ),
            child: const Row(
              children: [
                Icon(Icons.info_outline),
                SizedBox(width: 14),
                Expanded(
                  child: Text(
                    'Tentang Aplikasi',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
                Icon(Icons.chevron_right),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Data',
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 10),
          OutlineCard(
            onTap: () => _showDeleteConfirmation(context),
            child: const Row(
              children: [
                Icon(Icons.delete_outline),
                SizedBox(width: 14),
                Expanded(
                  child: Text(
                    'Hapus Data',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
                Icon(Icons.chevron_right),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MaterialSourcesPage extends StatelessWidget {
  const MaterialSourcesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PageTitle(
        title: 'Sumber Materi',
        showBack: true,
      ),
      body: const Padding(
        padding: EdgeInsets.all(20),
        child: Text(
          'Sumber materi FAIBIT akan dicantumkan berdasarkan '
          'referensi yang telah ditetapkan pada acuan proyek.',
        ),
      ),
    );
  }
}

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PageTitle(
        title: 'Tentang Aplikasi',
        showBack: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'FAIBIT',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              'Aplikasi pembelajaran interaktif Sistem Bilangan '
              'untuk siswa kelas X SMK/TJKT.',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 20),
            const Text(
              'FAIBIT dirancang sebagai teman belajar digital '
              'untuk membantu siswa mempelajari materi sistem '
              'bilangan melalui materi, latihan, dan challenge.',
            ),
          ],
        ),
      ),
    );
  }
}