import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import '../data/sqlite_quiz_history_migrator.dart';
import '../data/sqlite_quiz_history_provider.dart';
import '../data/user_profile_repository.dart';

import '../models/models.dart';
import '../settings/app_settings.dart';
import '../theme/app_theme.dart';
import '../widgets/ui.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({
    super.key,
    required this.profile,
    required this.onSaved,
  });

  final UserProfile profile;
  final Future<void> Function(UserProfile) onSaved;

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late final TextEditingController _nameController;
  late final TextEditingController _classController;
  late final TextEditingController _schoolController;

  File? _profileImage;

  Future<void> _pickProfileImage() async {
    final picker = ImagePicker();

    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile == null) return;

    setState(() {
      _profileImage = File(pickedFile.path);
    });
  }

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.profile.name);
    _classController = TextEditingController(text: widget.profile.schoolClass);
    _schoolController = TextEditingController(text: widget.profile.school);

    if (widget.profile.photoPath != null) {
      _profileImage = File(widget.profile.photoPath!);
    }
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
        _schoolController.text.trim() != widget.profile.school ||
        _profileImage?.path != widget.profile.photoPath;
  }

  Future<void> _save() async {
    final name = _nameController.text.trim();
    final schoolClass = _classController.text.trim();
    final school = _schoolController.text.trim();

    if (name.isEmpty || schoolClass.isEmpty || school.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Nama, kelas, dan sekolah wajib diisi.')),
      );
      return;
    }

    final updatedProfile = UserProfile(
      name: name,
      schoolClass: schoolClass,
      school: school,
      photoPath: _profileImage?.path,
    );

    await widget.onSaved(updatedProfile);
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
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Perubahan belum disimpan',
                style: Theme.of(context).textTheme.titleLarge
                    ?.copyWith(fontWeight: FontWeight.w700),
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
                    CircleAvatar(
                      radius: 48,
                      backgroundColor: AppTheme.tealSurface,
                      foregroundColor: AppTheme.darkGray,
                      backgroundImage: _profileImage != null
                          ? FileImage(_profileImage!)
                          : null,
                      child: _profileImage == null
                          ? const Icon(Icons.person_outline, size: 52)
                          : null,
                    ),
                    Material(
                      color: Theme.of(context).colorScheme.primary,
                      shape: const CircleBorder(),
                      child: InkWell(
                        onTap: _pickProfileImage,
                        customBorder: const CircleBorder(),
                        child: const Padding(
                          padding: EdgeInsets.all(7),
                          child: Icon(
                            Icons.edit_outlined,
                            color: Colors.white,
                            size: 18,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 28),
              Text('Nama', style: Theme.of(context).textTheme.labelLarge),
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
              Text('Kelas', style: Theme.of(context).textTheme.labelLarge),
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
              Text('Sekolah', style: Theme.of(context).textTheme.labelLarge),
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

  Future<void> _showDeleteConfirmation(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Hapus Data'),
        content: const Text(
          'Semua riwayat kuis, profil pengguna, dan pengaturan lokal '
          'akan dihapus. Setelah itu, kamu perlu mengisi identitas kembali. '
          'Tindakan ini tidak dapat dibatalkan.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Batal'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text('Hapus Data'),
          ),
        ],
      ),
    );

    if (confirmed != true || !context.mounted) return;
    await _deleteAllLocalData(context);
  }

  Future<void> _deleteAllLocalData(BuildContext context) async {
    final settings = AppSettingsScope.of(context);

    try {
      // Remove the legacy source first so startup migration cannot restore it.
      final preferences = UserProfileRepository.instance.preferences;
      for (final key in [
        SqliteQuizHistoryMigrator.sourceKey,
        SqliteQuizHistoryMigrator.markerKey,
      ]) {
        if (preferences.containsKey(key)) {
          final removed = await preferences.remove(key);
          if (!removed) {
            throw StateError('Data riwayat lama tidak dapat dihapus: $key.');
          }
        }
      }

      // Clear both SQLite tables in one database transaction.
      await SqliteQuizHistoryProvider.active.repository.deleteAll();

      // Remove the profile and reset only FAIBIT's own display preferences.
      await UserProfileRepository.instance.clear();
      await settings.reset();

      if (!context.mounted) return;
      Navigator.of(context).pushNamedAndRemoveUntil(
        '/identity',
        (route) => false,
      );
    } catch (error) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Data belum berhasil dihapus: $error')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final settings = AppSettingsScope.of(context);
    return Scaffold(
      appBar: const PageTitle(title: 'Pengaturan', showBack: true),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text('Tampilan', style: TextStyle(fontWeight: FontWeight.w700)),
          const SizedBox(height: 10),
          OutlineCard(
            child: RadioGroup<ThemeMode>(
              groupValue: settings.themeMode,
              onChanged: (value) {
                if (value != null) settings.setThemeMode(value);
              },
              child: const Column(
                children: [
                  RadioListTile<ThemeMode>(
                    value: ThemeMode.light,
                    title: Text('Light Mode'),
                    subtitle: Text('Gunakan tampilan terang'),
                    contentPadding: EdgeInsets.zero,
                  ),
                  RadioListTile<ThemeMode>(
                    value: ThemeMode.dark,
                    title: Text('Dark Mode'),
                    subtitle: Text('Gunakan tampilan gelap'),
                    contentPadding: EdgeInsets.zero,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Kenyamanan Membaca',
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 10),
          OutlineCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text('Pratinjau teks materi'),
                const SizedBox(height: 8),
                Text(
                  'Nilai tempat membantu memahami posisi setiap digit.',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 12),
                RadioGroup<ReadingSize>(
                  groupValue: settings.readingSize,
                  onChanged: (value) {
                    if (value != null) settings.setReadingSize(value);
                  },
                  child: Column(
                    children: [
                      for (final size in ReadingSize.values)
                        RadioListTile<ReadingSize>(
                          value: size,
                          title: Text(size.label),
                          subtitle: Text(
                            'Contoh ukuran teks ${size.label.toLowerCase()}',
                            style: TextStyle(fontSize: 13 * size.scale),
                          ),
                          contentPadding: EdgeInsets.zero,
                        ),
                    ],
                  ),
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
              MaterialPageRoute(builder: (_) => const MaterialSourcesPage()),
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
            onTap: () =>
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => const AboutPage())),
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
          const Text('Data', style: TextStyle(fontWeight: FontWeight.w700)),
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

  static const List<_MaterialReference> _references = [
    _MaterialReference(
      title: 'Introduction to Computer Science',
      author: 'Franchitti, J.-C. (2024)',
      publisher: 'OpenStax',
      description:
          'Menjadi referensi untuk memahami representasi informasi '
          'pada tingkat mesin dan kaitannya dengan sistem bilangan.',
      url:
          'https://openstax.org/books/introduction-computer-science/pages/5-3-machine-level-information-representation',
    ),
    _MaterialReference(
      title: 'Binary, Octal, and Hexadecimal',
      author: 'Lumen Learning',
      publisher: 'Mathematics LibreTexts',
      description:
          'Membahas sistem bilangan biner, oktal, dan heksadesimal '
          'sebagai bagian dari sistem numerasi.',
      url:
          'https://math.libretexts.org/Courses/Lumen_Learning/Introduction_to_College_Mathematics_(Lumen)/05:_Module_3:_Numeration_System/05.3:_Binary_Octal_and_Hexadecimal',
    ),
    _MaterialReference(
      title: 'Number Bases',
      author: 'Thangarajah, P.',
      publisher: 'Mathematics LibreTexts – Mount Royal University',
      description:
          'Menjadi referensi untuk memahami konsep basis bilangan '
          'dan sistem numerasi.',
      url:
          'https://math.libretexts.org/Courses/Mount_Royal_University/Higher_Arithmetic/7:_Numeration_Systems/7.2:_Number_Bases',
    ),
    _MaterialReference(
      title:
          'Media Pembelajaran Sistem Bilangan pada Standar Kompetensi '
          'Menerapkan Dasar-Dasar Teknik Digital',
      author: 'Harjiyono, P. (2011)',
      publisher: 'Universitas Negeri Yogyakarta',
      description:
          'Membahas media pembelajaran sistem bilangan dalam konteks '
          'kompetensi dasar-dasar teknik digital.',
      url: 'https://eprints.uny.ac.id/19227/',
    ),
  ];

  Future<void> _copyLink(BuildContext context, String url) async {
    await Clipboard.setData(ClipboardData(text: url));

    if (!context.mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Tautan sumber berhasil disalin.'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Scaffold(
      appBar: const PageTitle(
        title: 'Sumber Materi',
        showBack: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: colors.primaryContainer,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.menu_book_rounded,
                  size: 32,
                  color: colors.onPrimaryContainer,
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Referensi Pembelajaran',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: colors.onPrimaryContainer,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Materi FAIBIT disusun berdasarkan '
                        'berbagai referensi pembelajaran yang '
                        'membahas sistem bilangan dan representasi '
                        'informasi digital.',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: colors.onPrimaryContainer,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Daftar Referensi',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Berikut merupakan sumber yang digunakan '
            'sebagai acuan penyusunan materi FAIBIT.',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: colors.onSurfaceVariant,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 16),
          ...List.generate(_references.length, (index) {
            final source = _references[index];

            return Padding(
              padding: const EdgeInsets.only(bottom: 14),
              child: _MaterialReferenceCard(
                number: index + 1,
                reference: source,
                onCopy: () => _copyLink(context, source.url),
              ),
            );
          }),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: colors.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.info_outline,
                  color: colors.onSurfaceVariant,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Materi FAIBIT merupakan hasil penyusunan '
                    'ulang untuk kebutuhan pembelajaran. '
                    'Silakan kunjungi sumber asli untuk '
                    'mempelajari referensi secara lebih lengkap.',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: colors.onSurfaceVariant,
                      height: 1.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class _MaterialReference {
  final String title;
  final String author;
  final String publisher;
  final String description;
  final String url;

  const _MaterialReference({
    required this.title,
    required this.author,
    required this.publisher,
    required this.description,
    required this.url,
  });
}

class _MaterialReferenceCard extends StatelessWidget {
  const _MaterialReferenceCard({
    required this.number,
    required this.reference,
    required this.onCopy,
  });

  final int number;
  final _MaterialReference reference;
  final Future<void> Function() onCopy;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Card(
      elevation: 0,
      color: colors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: colors.outlineVariant),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 17,
                  backgroundColor: colors.primaryContainer,
                  child: Text(
                    number.toString().padLeft(2, '0'),
                    style: theme.textTheme.labelMedium?.copyWith(
                      color: colors.onPrimaryContainer,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    reference.title,
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              reference.author,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 3),
            Text(
              reference.publisher,
              style: theme.textTheme.bodySmall?.copyWith(
                color: colors.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              reference.description,
              style: theme.textTheme.bodyMedium?.copyWith(
                height: 1.5,
              ),
            ),
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerRight,
              child: OutlinedButton.icon(
                onPressed: onCopy,
                icon: const Icon(Icons.copy_rounded, size: 18),
                label: const Text('Salin Tautan'),
              ),
            ),
          ],
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
      appBar: const PageTitle(title: 'Tentang Aplikasi', showBack: true),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('FAIBIT', style: Theme.of(context).textTheme.headlineSmall),
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
