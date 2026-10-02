import 'package:flutter/material.dart';

import '../models/models.dart';
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
          HomePage(
            profile: profile,
            onDestinationSelected: selectDestination,
          ),
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
        const Text(
          'FAIBIT',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                OutlineCard(
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Hai, ${profile.name}!',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            Text('Kelas ${profile.schoolClass}'),
                            const SizedBox(height: 12),
                            const Text(
                              'Semangat belajar hari ini! Konsisten sedikit demi sedikit, hasilnya pasti terasa.',
                            ),
                          ],
                        ),
                      ),
                      const EmptySlot(width: 58, height: 96),
                    ],
                  ),
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
                      'Materi',
                      Icons.menu_book_outlined,
                      () => onDestinationSelected(RootDestination.materials),
                    ),
                    _menu(
                      'Latihan Santai',
                      Icons.edit_note_outlined,
                      () => _openChildPage(context, const QuizPage()),
                    ),
                    _menu(
                      'Challenge',
                      Icons.emoji_events_outlined,
                      () => _openChildPage(
                        context,
                        ChallengePage(profile: profile),
                      ),
                    ),
                    _menu(
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

  Widget _menu(String text, IconData icon, VoidCallback tap) => OutlineCard(
    onTap: tap,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, size: 30),
        const SizedBox(height: 7),
        Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(fontWeight: FontWeight.w700),
        ),
      ],
    ),
  );
}
