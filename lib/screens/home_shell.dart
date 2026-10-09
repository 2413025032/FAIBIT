import 'package:flutter/material.dart';

import '../models/models.dart';
import '../screens/profile_settings_screens.dart';
import '../widgets/ui.dart';
import 'history_profile.dart';
import 'material_screens.dart';
import 'quiz_screens.dart';

enum RootDestination { home, materials, history, profile }

class HomeShell extends StatefulWidget {
  const HomeShell({super.key, required this.profile});

  final UserProfile profile;

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  RootDestination destination = RootDestination.home;
  late UserProfile profile;

  @override
  void initState() {
    super.initState();
    profile = widget.profile;
  }

  void selectDestination(RootDestination value) {
    if (value == destination) return;
    setState(() => destination = value);
  }

  void updateProfile(UserProfile value) {
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
          const HistoryPage(),
          ProfilePage(profile: profile, onProfileChanged: updateProfile),
        ],
      ),
    ),
    bottomNavigationBar: NavigationBar(
      selectedIndex: destination.index,
      onDestinationSelected: (index) {
        selectDestination(RootDestination.values[index]);
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
            const Expanded(
              child: Text(
                'FAIBIT',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
              ),
            ),
            IconButton(
              tooltip: 'Pengaturan',
              onPressed: () => _openChildPage(context, const SettingsPage()),
              icon: const Icon(Icons.settings_outlined),
            ),
          ],
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                LayoutBuilder(
                  builder: (context, constraints) {
                    final mascotWidth = (constraints.maxWidth * 0.32).clamp(
                      100.0,
                      142.0,
                    );
                    return OutlineCard(
                      padding: const EdgeInsets.fromLTRB(18, 16, 12, 16),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Hai,',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                        ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    '${profile.name}!',
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall
                                        ?.copyWith(fontWeight: FontWeight.w800),
                                  ),
                                  const SizedBox(height: 3),
                                  Text('Kelas ${profile.schoolClass}'),
                                  const SizedBox(height: 12),
                                  Text(
                                    'Semangat belajar hari ini! '
                                    'Sedikit demi sedikit, hasilnya pasti terasa.',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          FaiMascot(
                            assetName: 'faibit_melambai.png',
                            width: mascotWidth,
                            height: 164,
                            semanticLabel: 'Fai melambai',
                          ),
                        ],
                      ),
                    );
                  },
                ),
                const SizedBox(height: 12),
                OutlineCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Progress Materi',
                        style: TextStyle(fontWeight: FontWeight.w800),
                      ),
                      const SizedBox(height: 8),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [Text('0 dari 5 materi'), Text('0%')],
                      ),
                      const SizedBox(height: 9),
                      const ProgressLine(value: 0),
                    ],
                  ),
                ),
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
                      'Riwayat Aktivitas',
                      Icons.history_outlined,
                      () => onDestinationSelected(RootDestination.history),
                    ),
                  ],
                ),
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
