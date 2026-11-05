import 'package:flutter/material.dart';
import 'package:real_page_flip/real_page_flip.dart';

import '../data/mock_data.dart';
import '../models/models.dart';
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
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            LayoutBuilder(
              builder: (context, constraints) {
                final wide = constraints.maxWidth >= 380;
                final copy = SpeechBubble(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Teman belajarmu',
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Siap belajar ${material.title}?',
                        style: Theme.of(context).textTheme.headlineSmall
                            ?.copyWith(fontWeight: FontWeight.w800),
                      ),
                      const SizedBox(height: 7),
                      const Text(
                        'Pelajari konsepnya dengan tenang, '
                        'selangkah demi selangkah bersama Fai.',
                      ),
                    ],
                  ),
                );
                return OutlineCard(
                  padding: const EdgeInsets.fromLTRB(18, 16, 14, 16),
                  child: Flex(
                    direction: wide ? Axis.horizontal : Axis.vertical,
                    crossAxisAlignment: wide
                        ? CrossAxisAlignment.center
                        : CrossAxisAlignment.start,
                    children: [
                      FaiMascot(
                        assetName: 'faibit_reading.png',
                        width: wide ? 142 : 118,
                        height: wide ? 174 : 142,
                        semanticLabel: 'Fai sedang membaca',
                      ),
                      SizedBox(width: wide ? 18 : 0, height: wide ? 0 : 12),
                      if (wide) Expanded(child: copy) else copy,
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: 18),
            Text(
              'Yang akan kamu pelajari',
              style: Theme.of(context).textTheme.titleLarge,
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
            Text(
              'Topik materi',
              style: Theme.of(context).textTheme.titleMedium,
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
  final PageFlipController pageController = PageFlipController();
  int currentPage = 0;
  bool showSwipeTutorial = true;

  int get sectionCount => widget.material.sections.length;

  @override
  void dispose() {
    super.dispose();
  }

  void changePage(int page) {
    if (page < 0 || page >= sectionCount || page == currentPage) return;
    if (page > currentPage) {
      pageController.nextPage();
    } else {
      pageController.previousPage();
    }
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
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        return PageFlipWidget(
                          controller: pageController,
                          itemCount: sectionCount,
                          isDoubleSpread: false,
                          onPageChanged: (page) {
                            setState(() => currentPage = page);
                          },
                          itemBuilder: (context, index) => _MaterialSectionPage(
                            section: widget.material.sections[index],
                          ),
                        );
                      },
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

class _MaterialSectionPage extends StatelessWidget {
  const _MaterialSectionPage({required this.section});

  final MaterialSection section;

  @override
  Widget build(BuildContext context) {
    final examples = section.additionalExamples;

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            section.title,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 14),
          Text(
            section.content,
            style: const TextStyle(fontSize: 16, height: 1.55),
          ),
          if (section.visualKind != MaterialVisualKind.none) ...[
            const SizedBox(height: 18),
            _MaterialConceptVisual(kind: section.visualKind),
          ],
          if (section.example != null) ...[
            const SizedBox(height: 18),
            _MaterialExampleCard(
              title: 'Contoh utama',
              content: section.example!,
            ),
          ],
          for (var index = 0; index < examples.length; index++) ...[
            const SizedBox(height: 12),
            _MaterialExampleCard(
              title: 'Contoh tambahan ${index + 1}',
              content: examples[index],
            ),
          ],
        ],
      ),
    );
  }
}

class _MaterialExampleCard extends StatelessWidget {
  const _MaterialExampleCard({
    required this.title,
    required this.content,
  });

  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.surfaceContainerHighest.withValues(alpha: 0.55),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colors.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.lightbulb_outline, size: 19, color: colors.primary),
              const SizedBox(width: 8),
              Text(
                title,
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          SelectableText(
            content.trim(),
            style: theme.textTheme.bodyMedium?.copyWith(height: 1.6),
          ),
        ],
      ),
    );
  }
}

class _MaterialConceptVisual extends StatelessWidget {
  const _MaterialConceptVisual({required this.kind});

  final MaterialVisualKind kind;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    final visual = switch (kind) {
      MaterialVisualKind.decimalPlaceValue => _decimalPlaceValue(context),
      MaterialVisualKind.binaryPlaceValue => _binaryPlaceValue(context),
      MaterialVisualKind.octalPlaceValue => _octalPlaceValue(context),
      MaterialVisualKind.hexadecimalSymbols => _hexadecimalSymbols(context),
      MaterialVisualKind.groupingThreeBits => _groupingThreeBits(context),
      MaterialVisualKind.groupingFourBits => _groupingFourBits(context),
      MaterialVisualKind.divisionByTwo => _divisionSteps(
        context,
        title: 'Konversi 25₁₀ ke biner',
        rows: const [
          ['25', '2', '12', '1'],
          ['12', '2', '6', '0'],
          ['6', '2', '3', '0'],
          ['3', '2', '1', '1'],
          ['1', '2', '0', '1'],
        ],
        result: '11001₂',
      ),
      MaterialVisualKind.divisionByEight => _divisionSteps(
        context,
        title: 'Konversi 58₁₀ ke oktal',
        rows: const [
          ['58', '8', '7', '2'],
          ['7', '8', '0', '7'],
        ],
        result: '72₈',
      ),
      MaterialVisualKind.divisionBySixteen => _divisionSteps(
        context,
        title: 'Konversi 125₁₀ ke heksadesimal',
        rows: const [
          ['125', '16', '7', '13 (D)'],
          ['7', '16', '0', '7'],
        ],
        result: '7D₁₆',
      ),
      MaterialVisualKind.none => const SizedBox.shrink(),
    };

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colors.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.account_tree_outlined, color: colors.primary),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Visualisasi Konsep',
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          visual,
        ],
      ),
    );
  }

  Widget _decimalPlaceValue(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          'Contoh bilangan 347₁₀',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 10),
        Row(
          children: const [
            _PlaceValueCell(label: 'Ratusan', digit: '3', weight: '10²', value: '300'),
            _PlaceValueCell(label: 'Puluhan', digit: '4', weight: '10¹', value: '40'),
            _PlaceValueCell(label: 'Satuan', digit: '7', weight: '10⁰', value: '7'),
          ],
        ),
        const SizedBox(height: 10),
        const Text(
          '300 + 40 + 7 = 347',
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
      ],
    );
  }

  Widget _binaryPlaceValue(BuildContext context) {
    const bits = ['1', '0', '1', '1', '0', '1', '1', '0'];
    const weights = ['128', '64', '32', '16', '8', '4', '2', '1'];
    const values = ['128', '0', '32', '16', '0', '4', '2', '0'];
    final colors = Theme.of(context).colorScheme;

    Widget cells(List<String> values, {bool highlighted = false}) => Row(
      children: [
        for (final value in values)
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 1.5),
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 1),
              decoration: BoxDecoration(
                color: highlighted ? colors.primaryContainer : null,
                borderRadius: BorderRadius.circular(7),
              ),
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  value,
                  style: TextStyle(
                    fontSize: highlighted ? 14 : 10,
                    fontWeight: highlighted ? FontWeight.w800 : FontWeight.w500,
                    color: highlighted ? colors.onPrimaryContainer : null,
                  ),
                ),
              ),
            ),
          ),
      ],
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          'Contoh bilangan 10110110₂',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 8),
        const Text('Nilai tempat', style: TextStyle(fontSize: 11)),
        cells(weights),
        const SizedBox(height: 4),
        const Text('Bit', style: TextStyle(fontSize: 11)),
        cells(bits, highlighted: true),
        const SizedBox(height: 4),
        const Text('Nilai yang dijumlahkan', style: TextStyle(fontSize: 11)),
        cells(values),
        const SizedBox(height: 10),
        const Text(
          '128 + 32 + 16 + 4 + 2 = 182₁₀',
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
      ],
    );
  }

  Widget _octalPlaceValue(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          'Contoh bilangan 426₈',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 10),
        Row(
          children: const [
            _PlaceValueCell(label: 'Posisi kiri', digit: '4', weight: '8²', value: '256'),
            _PlaceValueCell(label: 'Posisi tengah', digit: '2', weight: '8¹', value: '16'),
            _PlaceValueCell(label: 'Posisi kanan', digit: '6', weight: '8⁰', value: '6'),
          ],
        ),
        const SizedBox(height: 10),
        const Text(
          '256 + 16 + 6 = 278₁₀',
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
      ],
    );
  }

  Widget _hexadecimalSymbols(BuildContext context) {
    const symbols = [
      ['A', '10'], ['B', '11'], ['C', '12'],
      ['D', '13'], ['E', '14'], ['F', '15'],
    ];
    final colors = Theme.of(context).colorScheme;

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        for (final pair in symbols)
          Container(
            width: 76,
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: colors.secondaryContainer,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                Text(
                  pair[0],
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: colors.onSecondaryContainer,
                  ),
                ),
                Text(
                  pair[1],
                  style: TextStyle(color: colors.onSecondaryContainer),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _groupingThreeBits(BuildContext context) => _BitGroupingDiagram(
    title: 'Kelompokkan dari kanan menjadi 3 bit',
    groups: const [
      ['101', '5'],
      ['110', '6'],
    ],
    result: '101 110₂ = 56₈',
  );

  Widget _groupingFourBits(BuildContext context) => _BitGroupingDiagram(
    title: 'Kelompokkan dari kanan menjadi 4 bit',
    groups: const [
      ['1010', 'A'],
      ['1111', 'F'],
    ],
    result: '1010 1111₂ = AF₁₆',
  );

  Widget _divisionSteps(
    BuildContext context, {
    required String title,
    required List<List<String>> rows,
    required String result,
  }) {
    final colors = Theme.of(context).colorScheme;
    final border = TableBorder.all(color: colors.outlineVariant);

    Widget cell(String text, {bool header = false}) => Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 12,
          fontWeight: header ? FontWeight.w800 : FontWeight.w500,
        ),
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.w700)),
        const SizedBox(height: 10),
        Table(
          border: border,
          columnWidths: const {
            0: FlexColumnWidth(1.5),
            1: FlexColumnWidth(0.8),
            2: FlexColumnWidth(1.1),
            3: FlexColumnWidth(1.1),
          },
          children: [
            TableRow(
              decoration: BoxDecoration(color: colors.surfaceContainerHighest),
              children: [
                cell('Bilangan', header: true),
                cell('Bagi', header: true),
                cell('Hasil', header: true),
                cell('Sisa', header: true),
              ],
            ),
            for (final row in rows)
              TableRow(children: [for (final value in row) cell(value)]),
          ],
        ),
        const SizedBox(height: 8),
        const Text(
          'Baca sisa pembagian dari bawah ke atas.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 12),
        ),
        const SizedBox(height: 6),
        Text(
          'Hasil: $result',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.w800,
            color: colors.primary,
          ),
        ),
      ],
    );
  }
}

class _PlaceValueCell extends StatelessWidget {
  const _PlaceValueCell({
    required this.label,
    required this.digit,
    required this.weight,
    required this.value,
  });

  final String label;
  final String digit;
  final String weight;
  final String value;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 2),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 3),
        decoration: BoxDecoration(
          color: colors.primaryContainer,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 10),
            ),
            const SizedBox(height: 5),
            Text(
              digit,
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.w800,
                color: colors.onPrimaryContainer,
              ),
            ),
            Text(weight, style: const TextStyle(fontSize: 11)),
            Text(
              value,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ),
    );
  }
}

class _BitGroupingDiagram extends StatelessWidget {
  const _BitGroupingDiagram({
    required this.title,
    required this.groups,
    required this.result,
  });

  final String title;
  final List<List<String>> groups;
  final String result;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.w700)),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (var index = 0; index < groups.length; index++) ...[
              if (index > 0)
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: Text('|', style: TextStyle(fontWeight: FontWeight.w800)),
                ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: colors.primaryContainer,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Text(
                      groups[index][0],
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w800,
                        color: colors.onPrimaryContainer,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text('= ${groups[index][1]}'),
                  ],
                ),
              ),
            ],
          ],
        ),
        const SizedBox(height: 12),
        Text(
          result,
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.w800, color: colors.primary),
        ),
      ],
    );
  }
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
    body: SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            OutlineCard(
              child: Column(
                children: [
                  const FaiMascot(
                    assetName: 'faibit_celebrate.png',
                    width: 150,
                    height: 176,
                    semanticLabel: 'Fai merayakan',
                  ),
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
              child: const Text('Mulai Latihan'),
            ),
            const SizedBox(height: 10),
            Center(
              child: TextButton(
                onPressed: () =>
                    Navigator.popUntil(context, (route) => route.isFirst),
                child: const Text('Kembali ke Beranda'),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
