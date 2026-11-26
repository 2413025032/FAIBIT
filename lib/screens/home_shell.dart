import 'dart:io';

import 'package:flutter/material.dart';

import '../models/models.dart';
import '../data/user_profile_repository.dart';
import '../data/material_progress_repository.dart';
import '../data/mock_data.dart' show materials;
import '../screens/profile_settings_screens.dart';
import '../widgets/ui.dart';
import 'history_profile.dart';
import 'material_screens.dart';
import 'quiz_screens.dart';
import 'number_system_screen.dart';
import 'bit_playground_screen.dart';
import 'number_reference_table_screen.dart';

enum RootDestination { home, materials, history, profile }

class HomeShell extends StatefulWidget {
  const HomeShell({super.key, required this.profile});

  final UserProfile profile;

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  RootDestination destination = RootDestination.home;
  int historyRefreshToken = 0;
  late UserProfile profile;

  @override
  void initState() {
    super.initState();
    profile = widget.profile;
  }

  void selectDestination(RootDestination value) {
    if (value == destination) return;
    if (value == RootDestination.history) {
      historyRefreshToken++;
    }
    setState(() => destination = value);
  }

  Future<void> updateProfile(UserProfile value) async {
    await UserProfileRepository.instance.save(value);
    setState(() => profile = value);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      child: IndexedStack(
        index: destination.index,
        children: [
          HomePage(profile: profile, onDestinationSelected: selectDestination),
          const MaterialListPage(),
          HistoryPage(refreshToken: historyRefreshToken),
          ProfilePage(profile: profile, onProfileChanged: updateProfile),
        ],
      ),
    ),
    bottomNavigationBar: NavigationBar(
      selectedIndex: destination.index,
      onDestinationSelected: (index) {
        final selectedDestination = switch (index) {
          0 => RootDestination.home,
          1 => RootDestination.materials,
          2 => RootDestination.history,
          3 => RootDestination.profile,
          _ => RootDestination.home,
        };
        selectDestination(selectedDestination);
      },
      labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
      destinations: const [
        NavigationDestination(
          icon: Icon(Icons.home_outlined),
          selectedIcon: Icon(Icons.home),
          label: 'Beranda',
        ),
        NavigationDestination(
          icon: Icon(Icons.menu_book_outlined),
          selectedIcon: Icon(Icons.menu_book),
          label: 'Materi',
        ),
        NavigationDestination(
          icon: Icon(Icons.history_outlined),
          selectedIcon: Icon(Icons.history),
          label: 'Riwayat',
        ),
        NavigationDestination(
          icon: Icon(Icons.person_outline),
          selectedIcon: Icon(Icons.person),
          label: 'Profil',
        ),
      ],
    ),
  );
}

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
    required this.profile,
    required this.onDestinationSelected,
  });

  final UserProfile profile;
  final ValueChanged<RootDestination> onDestinationSelected;

  void _openChildPage(BuildContext context, Widget page) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => page));
  }

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.fromLTRB(20, 12, 20, 8),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'SELAMAT DATANG',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      letterSpacing: 1.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Halo, ${profile.greetingName}!',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontSize: 21,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text(
                    'Kelas ${profile.schoolClass}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            _HomeProfilePhoto(photoPath: profile.photoPath, name: profile.name),
            const SizedBox(width: 2),
            IconButton(
              tooltip: 'Pengaturan',
              onPressed: () => _openChildPage(context, const SettingsPage()),
              icon: const Icon(Icons.settings_outlined),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _FaiWelcomeCard(),
                const SizedBox(height: 14),
                const _MaterialProgressCard(),
                const SizedBox(height: 14),
                GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  childAspectRatio: 1.35,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  children: [
                    _menu(
                      context,
                      'Materi',
                      Icons.menu_book_outlined,
                      () => onDestinationSelected(RootDestination.materials),
                    ),
                    _menu(
                      context,
                      'Latihan Santai',
                      Icons.edit_note_outlined,
                      () => _openChildPage(
                        context,
                        const PracticeMaterialSelectionPage(),
                      ),
                    ),
                    _menu(
                      context,
                      'Challenge',
                      Icons.emoji_events_outlined,
                      () => _openChildPage(
                        context,
                        ChallengePreparationPage(profile: profile),
                      ),
                    ),
                    _menu(
                      context,
                      'Konversi Bilangan',
                      Icons.swap_horiz_rounded,
                      () => _openChildPage(
                        context,
                        const InteractiveNumberSystemPage(),
                      ),
                    ),
                    _menu(
                      context,
                      'Bit Playground',
                      Icons.memory_rounded,
                      () => _openChildPage(
                        context,
                        const BitPlaygroundPage(),
                      ),
                    ),
                    _menu(
                      context,
                      'Tabel Referensi',
                      Icons.table_chart_outlined,
                      () => _openChildPage(
                        context,
                        const NumberReferenceTablePage(),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
              ],
            ),
          ),
        ),
      ],
    ),
  );

  Widget _menu(
    BuildContext context,
    String text,
    IconData icon,
    VoidCallback tap,
  ) => OutlineCard(
    onTap: tap,
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, size: 30, color: Theme.of(context).colorScheme.primary),
        const SizedBox(height: 9),
        Text(
          text,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ],
    ),
  );
}

class _HomeProfilePhoto extends StatelessWidget {
  const _HomeProfilePhoto({required this.photoPath, required this.name});

  final String? photoPath;
  final String name;

  @override
  Widget build(BuildContext context) {
    final path = photoPath;
    final hasPhoto = path != null && path.isNotEmpty && File(path).existsSync();

    return Container(
      width: 46,
      height: 46,
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.55),
          width: 1.5,
        ),
      ),
      child: ClipOval(
        child: hasPhoto
            ? Image.file(
                File(path!),
                width: 42,
                height: 42,
                fit: BoxFit.cover,
                errorBuilder: (_, _, _) => _fallbackAvatar(context),
              )
            : _fallbackAvatar(context),
      ),
    );
  }

  Widget _fallbackAvatar(BuildContext context) => Container(
    color: Theme.of(context).colorScheme.primaryContainer,
    alignment: Alignment.center,
    child: Text(
      name.trim().isEmpty ? '?' : name.trim()[0].toUpperCase(),
      style: TextStyle(
        color: Theme.of(context).colorScheme.primary,
        fontWeight: FontWeight.w800,
        fontSize: 18,
      ),
    ),
  );
}

class _FaiWelcomeCard extends StatelessWidget {
  const _FaiWelcomeCard();

  @override
  Widget build(BuildContext context) => Container(
    height: 190,
    padding: const EdgeInsets.fromLTRB(18, 16, 8, 12),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFF159B79), Color(0xFF0B6557)],
      ),
      borderRadius: BorderRadius.circular(20),
      boxShadow: const [
        BoxShadow(
          color: Color(0x24107A62),
          blurRadius: 16,
          offset: Offset(0, 7),
        ),
      ],
    ),
    child: Row(
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'TEMAN BELAJARMU',
                style: TextStyle(
                  color: Color(0xFFD5F2E9),
                  fontSize: 10,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.1,
                ),
              ),
              SizedBox(height: 7),
              Text(
                'Hai! Aku Fai 👋',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(height: 6),
              Text(
                'Yuk, belajar sistem bilangan bersamaku!',
                style: TextStyle(
                  color: Color(0xFFF0FFFA),
                  fontSize: 12,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 2),
        FaiMascot(
          assetName: 'faibit_nyapa.png',
          fallbackAssetName: 'faibit_melambai.png',
          width: 154,
          height: 180,
          semanticLabel: 'Fai menyapa pengguna di beranda',
        ),
      ],
    ),
  );
}


class _MaterialProgressCard extends StatefulWidget {
  const _MaterialProgressCard();

  @override
  State<_MaterialProgressCard> createState() => _MaterialProgressCardState();
}

class _MaterialProgressCardState extends State<_MaterialProgressCard> {
  late Future<Set<String>> _completedFuture;

  @override
  void initState() {
    super.initState();
    _completedFuture = MaterialProgressRepository.loadCompletedTitles();
    MaterialProgressRepository.revision.addListener(_reloadProgress);
  }

  @override
  void dispose() {
    MaterialProgressRepository.revision.removeListener(_reloadProgress);
    super.dispose();
  }

  void _reloadProgress() {
    if (!mounted) return;
    setState(() {
      _completedFuture = MaterialProgressRepository.loadCompletedTitles();
    });
  }

  @override
  Widget build(BuildContext context) {
    final total = materials.length;

    return OutlineCard(
      child: FutureBuilder<Set<String>>(
        future: _completedFuture,
        builder: (context, snapshot) {
          final completedTitles = snapshot.data ?? const <String>{};
          final completedCount = materials
              .where((material) => completedTitles.contains(material.title.trim()))
              .length;
          final progress = total == 0 ? 0.0 : completedCount / total;
          final percentage = (progress * 100).round();

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Progress Materi',
                style: TextStyle(fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('$completedCount dari $total materi'),
                  Text('$percentage%'),
                ],
              ),
              const SizedBox(height: 9),
              ProgressLine(value: progress),
              if (snapshot.hasError) ...[
                const SizedBox(height: 6),
                Text(
                  'Progres belum dapat dimuat. Coba buka kembali beranda.',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ],
          );
        },
      ),
    );
  }
}
