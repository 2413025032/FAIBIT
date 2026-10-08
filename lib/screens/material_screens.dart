import 'package:flutter/material.dart';

import '../data/mock_data.dart';
import '../models/models.dart';
import '../theme/app_theme.dart';
import 'quiz_screens.dart';
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
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            OutlineCard(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const EmptySlot(width: 62, height: 74),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Fai siap menemanimu!',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'Pelajari ${material.title} dengan tenang, '
                          'selangkah demi selangkah.',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            const Text(
              'Yang akan kamu pelajari',
              style: TextStyle(fontSize: 19, fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 8),
            Text(material.description),
            const SizedBox(height: 16),
            OutlineCard(
              child: Column(
                children: [
                  _MaterialOverviewInfo(
                    icon: Icons.menu_book_outlined,
                    label: 'Jumlah Bagian',
                    value: '${material.sections.length} bagian',
                  ),
                  const SizedBox(height: 14),
                  _MaterialOverviewInfo(
                    icon: Icons.schedule_outlined,
                    label: 'Estimasi Waktu',
                    value:
                        '${_estimatedMinutes(material.sections.length)} menit',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Topik materi',
              style: TextStyle(fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 8),
            if (material.sections.isEmpty)
              const Text('Topik materi belum tersedia.')
            else
              ...material.sections.map(
                (section) => Padding(
                  padding: const EdgeInsets.only(bottom: 7),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 5),
                        child: Icon(Icons.circle, size: 7),
                      ),
                      const SizedBox(width: 9),
                      Expanded(child: Text(section.title)),
                    ],
                  ),
                ),
              ),
            const SizedBox(height: 20),
            FilledButton(
              onPressed: material.sections.isEmpty
                  ? null
                  : () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => MaterialReaderPage(material: material),
                      ),
                    ),
              child: const Text('Mulai Baca'),
            ),
          ],
        ),
      ),
    ),
  );
}

int _estimatedMinutes(int sectionCount) =>
    sectionCount == 0 ? 0 : (sectionCount * 2).clamp(2, 30);

class _MaterialOverviewInfo extends StatelessWidget {
  const _MaterialOverviewInfo({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) => Row(
    children: [
      Icon(icon),
      const SizedBox(width: 12),
      Expanded(child: Text(label)),
      Text(value, style: const TextStyle(fontWeight: FontWeight.w700)),
    ],
  );
}

class MaterialReaderPage extends StatefulWidget {
  const MaterialReaderPage({super.key, required this.material});

  final LearningMaterial material;

  @override
  State<MaterialReaderPage> createState() => _MaterialReaderPageState();
}

class _MaterialReaderPageState extends State<MaterialReaderPage> {
  final PageController pageController = PageController();
  int currentPage = 0;
  bool showSwipeTutorial = true;

  int get sectionCount => widget.material.sections.length;

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  void changePage(int page) {
    if (page < 0 || page >= sectionCount) return;
    pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 260),
      curve: Curves.easeOut,
    );
  }

  void completeMaterial() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => MaterialCompletedPage(material: widget.material),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final hasSections = sectionCount > 0;

    return Scaffold(
      appBar: PageTitle(title: widget.material.title),
      body: SafeArea(
        child: Stack(
          children: [
            if (!hasSections)
              const Center(child: Text('Belum ada bagian materi.'))
            else
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 4),
                    child: Text(
                      'Bagian ${currentPage + 1} dari $sectionCount',
                      style: const TextStyle(fontWeight: FontWeight.w700),
                    ),
                  ),
                  Expanded(
                    child: PageView.builder(
                      controller: pageController,
                      itemCount: sectionCount,
                      onPageChanged: (page) {
                        setState(() => currentPage = page);
                      },
                      itemBuilder: (_, index) => _MaterialReaderItem(
                        index: index,
                        controller: pageController,
                        section: widget.material.sections[index],
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      sectionCount,
                      (index) => AnimatedContainer(
                        duration: const Duration(milliseconds: 180),
                        margin: const EdgeInsets.symmetric(horizontal: 3),
                        width: index == currentPage ? 18 : 7,
                        height: 7,
                        decoration: BoxDecoration(
                          color: index == currentPage
                              ? Theme.of(context).colorScheme.primary
                              : Theme.of(context).colorScheme.primary
                                    .withValues(alpha: 0.24),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 14),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _ReaderNavigationButton(
                          icon: Icons.arrow_back_ios_new,
                          enabled: currentPage > 0,
                          onPressed: () => changePage(currentPage - 1),
                        ),
                        _ReaderNavigationButton(
                          icon: Icons.arrow_forward_ios,
                          enabled: currentPage < sectionCount - 1,
                          onPressed: () => changePage(currentPage + 1),
                        ),
                      ],
                    ),
                  ),
                  if (currentPage == sectionCount - 1)
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 14),
                      child: FilledButton(
                        onPressed: completeMaterial,
                        child: const Text('Tandai Materi Selesai'),
                      ),
                    ),
                ],
              ),
            if (showSwipeTutorial && hasSections)
              _SwipeTutorial(
                onDismiss: () {
                  setState(() => showSwipeTutorial = false);
                },
              ),
          ],
        ),
      ),
    );
  }
}

class _MaterialReaderItem extends StatelessWidget {
  const _MaterialReaderItem({
    required this.index,
    required this.controller,
    required this.section,
  });

  final int index;
  final PageController controller;
  final MaterialSection section;

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
    animation: controller,
    child: _MaterialSectionPage(section: section),
    builder: (context, child) {
      final page = controller.hasClients && controller.page != null
          ? controller.page!
          : index.toDouble();
      final distance = (index - page).clamp(-1.0, 1.0);
      final rotation = distance * 0.075;
      final scale = 1 - distance.abs() * 0.035;
      final translateY = distance.abs() * 5;

      return Transform(
        alignment: distance >= 0 ? Alignment.centerLeft : Alignment.centerRight,
        transform: Matrix4.identity()
          ..setEntry(3, 2, 0.0012)
          ..translateByDouble(0.0, translateY, 0.0, 1.0)
          ..rotateY(rotation)
          ..scaleByDouble(scale, scale, scale, 1.0),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 9, vertical: 8),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(AppTheme.radius),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(
                  alpha: 0.11 * (1 - distance.abs()),
                ),
                blurRadius: 16,
                offset: Offset(0, 7 + distance.abs() * 3),
              ),
            ],
          ),
          clipBehavior: Clip.antiAlias,
          child: child,
        ),
      );
    },
  );
}

class _MaterialSectionPage extends StatelessWidget {
  const _MaterialSectionPage({required this.section});

  final MaterialSection section;

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
    padding: const EdgeInsets.fromLTRB(20, 18, 20, 24),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          section.title,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 14),
        Text(section.content),
        if (section.example != null) ...[
          const SizedBox(height: 18),
          OutlineCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Contoh',
                  style: TextStyle(fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 8),
                Text(section.example!),
              ],
            ),
          ),
        ],
      ],
    ),
  );
}

class _ReaderNavigationButton extends StatelessWidget {
  const _ReaderNavigationButton({
    required this.icon,
    required this.enabled,
    required this.onPressed,
  });

  final IconData icon;
  final bool enabled;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) => Material(
    color: Theme.of(context).colorScheme.primary
        .withValues(alpha: enabled ? 0.12 : 0.05),
    shape: const CircleBorder(),
    child: IconButton(
      onPressed: enabled ? onPressed : null,
      icon: Icon(icon, size: 18),
      color: Theme.of(context).colorScheme.primary,
      disabledColor: Theme.of(context).colorScheme.primary
          .withValues(alpha: 0.28),
      constraints: const BoxConstraints.tightFor(width: 42, height: 42),
      padding: EdgeInsets.zero,
      tooltip: enabled ? 'Pindah bagian' : null,
    ),
  );
}

class _SwipeTutorial extends StatelessWidget {
  const _SwipeTutorial({required this.onDismiss});

  final VoidCallback onDismiss;

  @override
  Widget build(BuildContext context) => Positioned.fill(
    child: ColoredBox(
      color: Colors.black.withValues(alpha: 0.34),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: OutlineCard(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.swipe_outlined,
                  size: 58,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(height: 12),
                const Text(
                  'Cara Membaca Materi',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Geser layar ke kiri atau kanan untuk berpindah bagian materi.',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 18),
                FilledButton(
                  onPressed: onDismiss,
                  child: const Text('Mengerti'),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

class MaterialCompletedPage extends StatelessWidget {
  const MaterialCompletedPage({super.key, required this.material});

  final LearningMaterial material;

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: PageTitle(title: 'Materi Selesai'),
    body: SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            OutlineCard(
              child: Column(
                children: [
                  const EmptySlot(width: 82, height: 100),
                  const SizedBox(height: 10),
                  Text(
                    'Materi ${material.title} Selesai!',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Semua bagian materi telah selesai dibaca. '
                    'Fai bangga dengan langkah belajarmu hari ini!',
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      PracticePreparationPage(materialTitle: material.title),
                ),
              ),
              child: const Text('Latihan Materi Ini'),
            ),
            const SizedBox(height: 10),
            OutlinedButton(
              onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'Challenge materi ini dapat dimulai dari menu Challenge.',
                  ),
                ),
              ),
              child: const Text('Challenge Materi Ini'),
            ),
            const SizedBox(height: 18),
            TextButton(
              onPressed: () =>
                  Navigator.popUntil(context, (route) => route.isFirst),
              child: const Text('Kembali ke Materi'),
            ),
            TextButton(
              onPressed: () =>
                  Navigator.popUntil(context, (route) => route.isFirst),
              child: const Text('Kembali ke Beranda'),
            ),
          ],
        ),
      ),
    ),
  );
}
