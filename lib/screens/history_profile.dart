import 'package:flutter/material.dart';

import '../data/mock_data.dart';
import '../theme/app_theme.dart';
import '../widgets/ui.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key, required this.name, required this.schoolClass});
  final String name, schoolClass;
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
        const PageTitle(title: 'Riwayat'),
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

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key, required this.name, required this.schoolClass});
  final String name, schoolClass;
  void dialog(BuildContext c, String title) => showDialog(
    context: c,
    builder: (_) => AlertDialog(
      title: Text(title),
      content: Text(
        title == 'Hapus Data Semua'
            ? 'Data prototype belum disimpan permanen.'
            : 'Fitur ini akan tersedia saat data pengguna sudah tersimpan.',
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(c),
          child: const Text('Tutup'),
        ),
      ],
    ),
  );
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: const PageTitle(title: 'Profil'),
    body: Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 30,
                backgroundColor: AppTheme.soft,
                child: Icon(
                  Icons.person_outline,
                  size: 34,
                  color: AppTheme.ink,
                ),
              ),
              const SizedBox(width: 14),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text('Kelas $schoolClass'),
                ],
              ),
            ],
          ),
          const SizedBox(height: 24),
          ...[
            'Ubah Nama',
            'Ubah Kelas',
            'Tentang Aplikasi',
            'Hapus Data Semua',
          ].map(
            (x) => Padding(
              padding: const EdgeInsets.only(bottom: 9),
              child: OutlineCard(
                onTap: () => dialog(context, x),
                child: Row(
                  children: [
                    const Icon(Icons.edit_outlined),
                    const SizedBox(width: 14),
                    Expanded(child: Text(x)),
                    const Icon(Icons.chevron_right),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
