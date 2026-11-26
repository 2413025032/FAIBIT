import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

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
  late final TextEditingController _nicknameController;
  late final TextEditingController _classController;
  late final TextEditingController _schoolController;

  File? _profileImage;

  Future<void> _pickProfileImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 100,
    );

    if (pickedFile == null || !mounted) return;

    final croppedFile = await ImageCropper().cropImage(
      sourcePath: pickedFile.path,
      aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
      compressFormat: ImageCompressFormat.jpg,
      compressQuality: 92,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Atur Foto Profil',
          toolbarColor: AppTheme.greenTeal,
          toolbarWidgetColor: Colors.white,
          activeControlsWidgetColor: AppTheme.greenTeal,
          initAspectRatio: CropAspectRatioPreset.square,
          lockAspectRatio: true,
          cropStyle: CropStyle.circle,
        ),
        IOSUiSettings(
          title: 'Atur Foto Profil',
          aspectRatioLockEnabled: true,
          resetAspectRatioEnabled: false,
          aspectRatioPickerButtonHidden: true,
          cropStyle: CropStyle.circle,
        ),
      ],
    );

    if (croppedFile == null || !mounted) return;

    // Simpan hasil crop di folder permanen aplikasi, bukan cache sementara.
    final appDirectory = await getApplicationDocumentsDirectory();
    final profileDirectory = Directory(
      path.join(appDirectory.path, 'profile_photos'),
    );
    await profileDirectory.create(recursive: true);
    final savedImage = await File(croppedFile.path).copy(
      path.join(
        profileDirectory.path,
        'profile_${DateTime.now().millisecondsSinceEpoch}.jpg',
      ),
    );

    if (!mounted) return;
    setState(() {
      _profileImage = savedImage;
    });
  }

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.profile.name);
    _nicknameController = TextEditingController(
      text: widget.profile.greetingName,
    );
    _classController = TextEditingController(text: widget.profile.schoolClass);
    _schoolController = TextEditingController(text: widget.profile.school);

    if (widget.profile.photoPath != null) {
      _profileImage = File(widget.profile.photoPath!);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _nicknameController.dispose();
    _classController.dispose();
    _schoolController.dispose();
    super.dispose();
  }

  bool get _hasChanges {
    return _nameController.text.trim() != widget.profile.name ||
        normalizeNickname(_nicknameController.text) !=
            widget.profile.greetingName ||
        _classController.text.trim() != widget.profile.schoolClass ||
        _schoolController.text.trim() != widget.profile.school ||
        _profileImage?.path != widget.profile.photoPath;
  }

  Future<void> _save() async {
    final name = normalizeFullName(_nameController.text);
    final nickname = normalizeNickname(_nicknameController.text);
    final schoolClass = _classController.text.trim();
    final school = _schoolController.text.trim();

    if (name.isEmpty ||
        nickname.isEmpty ||
        schoolClass.isEmpty ||
        school.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Nama lengkap, nama panggilan, kelas, dan sekolah wajib diisi.'),
        ),
      );
      return;
    }

    final updatedProfile = UserProfile(
      name: name,
      nickname: nickname,
      schoolClass: schoolClass,
      school: school,
      photoPath: _profileImage?.path,
    );

    await widget.onSaved(updatedProfile);

    if (!mounted) return;

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

        final navigator = Navigator.of(context);
        final shouldPop = await _handleBack();

        if (!mounted) return;

        if (shouldPop) {
          navigator.pop();
        }
      },
      child: Scaffold(
        appBar: PageTitle(
          title: 'Edit Profil',
          showBack: true,
          onBack: () async {
            final navigator = Navigator.of(context);
            final shouldPop = await _handleBack();

            if (!mounted) return;

            if (shouldPop) {
              navigator.pop();
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
              Text(
                'Nama Lengkap',
                style: Theme.of(context).textTheme.labelLarge,
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _nameController,
                onChanged: (_) => setState(() {}),
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  hintText: 'Masukkan nama lengkap',
                  prefixIcon: Icon(Icons.person_outline),
                ),
              ),
              const SizedBox(height: 18),
              Text(
                'Nama Panggilan',
                style: Theme.of(context).textTheme.labelLarge,
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _nicknameController,
                onChanged: (_) => setState(() {}),
                textCapitalization: TextCapitalization.words,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  hintText: 'Nama yang ingin digunakan saat disapa',
                  prefixIcon: Icon(Icons.waving_hand_outlined),
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
            child: RadioGroup<AppThemeMode>(
              groupValue: settings.appThemeMode,
              onChanged: (value) {
                if (value != null) settings.setAppThemeMode(value);
              },
              child: const Column(
                children: [
                  RadioListTile<AppThemeMode>(
                    value: AppThemeMode.light,
                    title: Text('Light Mode'),
                    subtitle: Text('Tampilan terang yang bersih'),
                    contentPadding: EdgeInsets.zero,
                  ),
                  RadioListTile<AppThemeMode>(
                    value: AppThemeMode.dark,
                    title: Text('Dark Mode'),
                    subtitle: Text('Tampilan gelap yang nyaman'),
                    contentPadding: EdgeInsets.zero,
                  ),
                  RadioListTile<AppThemeMode>(
                    value: AppThemeMode.pink,
                    title: Text('Pink Mode'),
                    subtitle: Text('Dusty rose lembut dengan permukaan netral'),
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


class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  static const String _developerPhotoAsset =
      'assets/images/developer/mutiara_salsabilla.png';

  Widget _buildDeveloperPortrait(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: colors.secondaryContainer,
        border: Border.all(
          color: colors.primary.withValues(alpha: 0.4),
          width: 2.5,
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: Image.asset(
        _developerPhotoAsset,
        fit: BoxFit.cover,
        errorBuilder: (_, _, _) => Icon(
          Icons.person_rounded,
          size: 48,
          color: colors.onSecondaryContainer,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Scaffold(
      appBar: const PageTitle(
        title: 'Tentang Aplikasi',
        showBack: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // Identitas aplikasi
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              color: colors.primaryContainer,
              borderRadius: BorderRadius.circular(22),
            ),
            child: Column(
              children: [
                Container(
                  width: 82,
                  height: 82,
                  padding: const EdgeInsets.all(7),
                  decoration: BoxDecoration(
                    color: colors.surface,
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(
                    'assets/images/branding/logo_faibit.png',
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(height: 14),
                Text(
                  'FAIBIT',
                  style: theme.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colors.onPrimaryContainer,
                    letterSpacing: 2,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Fast Arithmatic Bit Interface',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.titleSmall?.copyWith(
                    color: colors.onPrimaryContainer,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Learn Number Systems, The Fun Way!',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: colors.onPrimaryContainer,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                const SizedBox(height: 14),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 7,
                  ),
                  decoration: BoxDecoration(
                    color: colors.surface.withValues(alpha: 0.65),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Text(
                    'Media Pembelajaran Interaktif',
                    style: theme.textTheme.labelMedium?.copyWith(
                      color: colors.onSurface,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 26),

          // Deskripsi aplikasi
          Text(
            'Apa itu FAIBIT?',
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'FAIBIT merupakan aplikasi pembelajaran interaktif '
            'yang dirancang untuk membantu siswa kelas X SMK, '
            'khususnya pada bidang TJKT, dalam memahami konsep '
            'sistem bilangan.',
            style: theme.textTheme.bodyMedium?.copyWith(
              height: 1.6,
              color: colors.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Melalui penyajian materi, latihan soal, dan tantangan '
            'interaktif, FAIBIT menjadi teman belajar digital yang '
            'membantu siswa mempelajari sistem bilangan secara '
            'bertahap dan lebih menyenangkan.',
            style: theme.textTheme.bodyMedium?.copyWith(
              height: 1.6,
              color: colors.onSurfaceVariant,
            ),
          ),

          const SizedBox(height: 26),

          // Materi pembelajaran
          Text(
            'Materi Pembelajaran',
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'FAIBIT menyediakan materi dasar sistem bilangan '
            'yang terdiri dari:',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: colors.onSurfaceVariant,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: const [
              _AboutTopicChip(label: 'Desimal'),
              _AboutTopicChip(label: 'Biner'),
              _AboutTopicChip(label: 'Oktal'),
              _AboutTopicChip(label: 'Heksadesimal'),
              _AboutTopicChip(label: 'Konversi Bilangan'),
            ],
          ),

          const SizedBox(height: 26),

          // Fitur aplikasi
          Text(
            'Fitur FAIBIT',
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          const _AboutFeatureTile(
            icon: Icons.menu_book_rounded,
            title: 'Materi Pembelajaran',
            description:
                'Pelajari konsep sistem bilangan melalui materi '
                'yang disusun secara bertahap.',
          ),
          const _AboutFeatureTile(
            icon: Icons.edit_note_rounded,
            title: 'Latihan Santai',
            description:
                'Uji pemahaman melalui latihan soal tanpa batas '
                'waktu.',
          ),
          const _AboutFeatureTile(
            icon: Icons.timer_rounded,
            title: 'Challenge',
            description:
                'Asah kemampuan menyelesaikan soal melalui '
                'tantangan dengan batas waktu.',
          ),
          const _AboutFeatureTile(
            icon: Icons.swap_horiz_rounded,
            title: 'Konversi Bilangan',
            description:
                'Konversikan bilangan desimal ke biner, oktal, dan '
                'heksadesimal, serta lihat representasi tiap basis.',
          ),
          const _AboutFeatureTile(
            icon: Icons.memory_rounded,
            title: 'Bit Playground',
            description:
                'Eksplorasi nilai 8-bit dengan mengaktifkan atau '
                'menonaktifkan bit dan melihat hasil desimalnya.',
          ),
          const _AboutFeatureTile(
            icon: Icons.table_chart_rounded,
            title: 'Tabel Referensi Bilangan',
            description:
                'Lihat perbandingan bilangan desimal, biner, oktal, dan '
                'heksadesimal dari angka 0 sampai 50 sebagai referensi cepat.',
          ),
          const _AboutFeatureTile(
            icon: Icons.history_rounded,
            title: 'Riwayat Belajar',
            description:
                'Lihat kembali hasil latihan dan challenge '
                'yang telah dikerjakan.',
          ),
          const _AboutFeatureTile(
            icon: Icons.tune_rounded,
            title: 'Pengaturan',
            description:
                'Sesuaikan tema aplikasi dan ukuran teks '
                'dengan kenyamanan belajar.',
          ),

          const SizedBox(height: 26),

          // Profil pengembang
          Text(
            'Tentang Pengembang',
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Card(
            elevation: 0,
            color: colors.surface,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
              side: BorderSide(
                color: colors.outlineVariant,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDeveloperPortrait(context),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Mutiara Salsabilla',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          'Mahasiswa Pendidikan Teknologi Informasi',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: colors.onSurfaceVariant,
                            height: 1.5,
                          ),
                        ),
                        Text(
                          'FKIP, Universitas Lampung',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: colors.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 24),

          // Penutup
          Center(
            child: Column(
              children: [
                Icon(
                  Icons.favorite_rounded,
                  color: colors.primary,
                  size: 22,
                ),
                const SizedBox(height: 8),
                Text(
                  'Belajar Sistem Bilangan dengan Cara '
                  'yang Lebih Menyenangkan.',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: colors.onSurfaceVariant,
                    fontStyle: FontStyle.italic,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'FAIBIT',
                  style: theme.textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                    color: colors.primary,
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

class _AboutTopicChip extends StatelessWidget {
  const _AboutTopicChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 13,
        vertical: 9,
      ),
      decoration: BoxDecoration(
        color: colors.secondaryContainer,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelMedium?.copyWith(
          color: colors.onSecondaryContainer,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _AboutFeatureTile extends StatelessWidget {
  const _AboutFeatureTile({
    required this.icon,
    required this.title,
    required this.description,
  });

  final IconData icon;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Card(
      elevation: 0,
      color: colors.surface,
      margin: const EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: colors.outlineVariant,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: colors.primaryContainer,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: colors.onPrimaryContainer,
              ),
            ),
            const SizedBox(width: 13),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: theme.textTheme.bodySmall?.copyWith(
                      height: 1.5,
                      color: colors.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
