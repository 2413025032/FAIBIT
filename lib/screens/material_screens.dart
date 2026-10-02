import 'package:flutter/material.dart';

import '../data/mock_data.dart';
import '../models/models.dart';
import '../widgets/ui.dart';

class MaterialListPage extends StatelessWidget {
  const MaterialListPage({super.key});
  @override
  Widget build(BuildContext context) => Column(
    children: [
      const PageTitle(title: 'Materi', showBack: false),
      Expanded(
        child: ListView.separated(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
          itemCount: materials.length,
          separatorBuilder: (_, _) => const SizedBox(height: 10),
          itemBuilder: (_, i) {
            final m = materials[i];
            return OutlineCard(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => MaterialDetailPage(material: m),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xFFD0D0D0)),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Center(
                      child: Text(
                        '${i + 1}',
                        style: const TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                  const SizedBox(width: 13),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          m.title,
                          style: const TextStyle(fontWeight: FontWeight.w800),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          m.description,
                          style: const TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  const Icon(Icons.chevron_right),
                ],
              ),
            );
          },
        ),
      ),
    ],
  );
}

class MaterialDetailPage extends StatelessWidget {
  const MaterialDetailPage({super.key, required this.material});
  final LearningMaterial material;
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: PageTitle(title: material.title),
    body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const OutlineCard(
              padding: EdgeInsets.zero,
              child: EmptySlot(height: 130),
            ),
            const SizedBox(height: 18),
            Text(
              '1. Pengenalan Sistem Bilangan ${material.title}',
              style: const TextStyle(fontSize: 19, fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 10),
            Text(
              '${material.description}. Materi ini membantu kamu memahami konsep dasar dengan langkah yang sederhana.',
            ),
            const SizedBox(height: 16),
            OutlineCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Contoh',
                    style: TextStyle(fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(height: 8),
                  Text(material.example),
                ],
              ),
            ),
            const Spacer(),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.maybePop(context),
                    child: const Text('Sebelumnya'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: FilledButton(
                    onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Bagian berikutnya akan tersedia pada materi final.',
                        ),
                      ),
                    ),
                    child: const Text('Selanjutnya'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
