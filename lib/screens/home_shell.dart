import 'package:flutter/material.dart';

import '../widgets/ui.dart';
import 'material_screens.dart';
import 'quiz_screens.dart';
import 'history_profile.dart';

class HomeShell extends StatefulWidget {
  const HomeShell({
    super.key,
    required this.name,
    required this.schoolClass,
    this.initialTab = 0,
  });
  final String name, schoolClass;
  final int initialTab;
  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  late int tab;
  @override
  void initState() {
    super.initState();
    tab = widget.initialTab;
  }

  void go(int index) {
    if (index == tab) return;
    setState(() => tab = index);
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      HomePage(name: widget.name, schoolClass: widget.schoolClass, go: go),
      MaterialListPage(name: widget.name, schoolClass: widget.schoolClass),
      QuizPage(name: widget.name, schoolClass: widget.schoolClass),
      ChallengePage(name: widget.name, schoolClass: widget.schoolClass),
      HistoryPage(name: widget.name, schoolClass: widget.schoolClass),
    ];
    return Scaffold(
      body: SafeArea(child: pages[tab]),
      bottomNavigationBar: NavigationBar(
        selectedIndex: tab,
        onDestinationSelected: go,
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
            icon: Icon(Icons.edit_note_outlined),
            selectedIcon: Icon(Icons.edit_note),
            label: 'Latihan',
          ),
          NavigationDestination(
            icon: Icon(Icons.bolt_outlined),
            selectedIcon: Icon(Icons.bolt),
            label: 'Challenge',
          ),
          NavigationDestination(
            icon: Icon(Icons.history_outlined),
            selectedIcon: Icon(Icons.history),
            label: 'Riwayat',
          ),
        ],
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
    required this.name,
    required this.schoolClass,
    required this.go,
  });
  final String name, schoolClass;
  final ValueChanged<int> go;
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.fromLTRB(20, 12, 20, 8),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            const Text(
              'FAIBIT',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
            ),
            const Spacer(),
            IconButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      ProfilePage(name: name, schoolClass: schoolClass),
                ),
              ),
              icon: const Icon(Icons.settings_outlined),
            ),
          ],
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
                              'Hai, $name!',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            Text('Kelas $schoolClass'),
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
                    _menu('Materi', Icons.menu_book_outlined, () => go(1)),
                    _menu(
                      'Latihan Santai',
                      Icons.edit_note_outlined,
                      () => go(2),
                    ),
                    _menu(
                      'Challenge',
                      Icons.emoji_events_outlined,
                      () => go(3),
                    ),
                    _menu(
                      'Riwayat Aktivitas',
                      Icons.history_outlined,
                      () => go(4),
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
