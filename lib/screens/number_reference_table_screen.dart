import 'package:flutter/material.dart';

import '../widgets/ui.dart';

class NumberReferenceTablePage extends StatelessWidget {
  const NumberReferenceTablePage({super.key});

  static const _teal = Color(0xFF128A70);
  static const _deepTeal = Color(0xFF0B6557);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final rows = List<Widget>.generate(51, (index) {
      final binary = index.toRadixString(2).padLeft(6, '0');
      final octal = index.toRadixString(8);
      final hexadecimal = index.toRadixString(16).toUpperCase();
      final isEven = index.isEven;

      return Container(
        color: isEven
            ? colorScheme.surface
            : colorScheme.primary.withValues(alpha: 0.045),
        constraints: const BoxConstraints(minHeight: 46),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Row(
          children: [
            _tableCell('$index', flex: 1),
            _tableCell(
              binary,
              flex: 2,
              color: _deepTeal,
              bold: true,
              monospace: true,
            ),
            _tableCell(octal, flex: 1),
            _tableCell(
              hexadecimal,
              flex: 1,
              color: _deepTeal,
              bold: true,
            ),
          ],
        ),
      );
    });

    return Scaffold(
      appBar: const PageTitle(title: 'Tabel Referensi Bilangan'),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(18, 8, 18, 24),
          children: [
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [_teal, _deepTeal],
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x24107A62),
                    blurRadius: 14,
                    offset: Offset(0, 6),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.16),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Icon(
                      Icons.table_chart_rounded,
                      color: Colors.white,
                      size: 27,
                    ),
                  ),
                  const SizedBox(width: 13),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Referensi Cepat',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Bandingkan empat sistem bilangan dalam satu tabel.',
                          style: TextStyle(
                            color: Color(0xFFE5F7F1),
                            fontSize: 12,
                            height: 1.35,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),
            Row(
              children: [
                _infoPill(
                  context,
                  icon: Icons.format_list_numbered_rounded,
                  label: '51 nilai',
                ),
                const SizedBox(width: 8),
                _infoPill(
                  context,
                  icon: Icons.memory_rounded,
                  label: 'Biner 6-bit',
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              'Tabel Konversi 0–50',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
            ),
            const SizedBox(height: 4),
            Text(
              'Setiap baris menunjukkan nilai yang sama dalam basis berbeda.',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 12),
            Container(
              decoration: BoxDecoration(
                color: colorScheme.surface,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color: colorScheme.outlineVariant.withValues(alpha: 0.7),
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x0D102A24),
                    blurRadius: 12,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              clipBehavior: Clip.antiAlias,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 13,
                    ),
                    color: _deepTeal,
                    child: const Row(
                      children: [
                        _TableHeading('Desimal', flex: 1),
                        _TableHeading('Biner', flex: 2),
                        _TableHeading('Oktal', flex: 1),
                        _TableHeading('Heksa', flex: 1),
                      ],
                    ),
                  ),
                  ...rows,
                ],
              ),
            ),
            const SizedBox(height: 18),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: colorScheme.primaryContainer.withValues(alpha: 0.55),
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color: colorScheme.primary.withValues(alpha: 0.12),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.lightbulb_outline_rounded,
                          color: colorScheme.primary),
                      const SizedBox(width: 8),
                      Text(
                        'Ingat simbol heksadesimal',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w800,
                            ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 7),
                  Text(
                    'Setelah angka 9, heksadesimal menggunakan huruf A sampai F.',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 7,
                    runSpacing: 7,
                    children: const [
                      _HexSymbolChip(decimal: '10', hex: 'A'),
                      _HexSymbolChip(decimal: '11', hex: 'B'),
                      _HexSymbolChip(decimal: '12', hex: 'C'),
                      _HexSymbolChip(decimal: '13', hex: 'D'),
                      _HexSymbolChip(decimal: '14', hex: 'E'),
                      _HexSymbolChip(decimal: '15', hex: 'F'),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Catatan: bilangan biner ditulis dalam 6 bit agar seluruh nilai 0–50 memiliki format yang seragam.',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget _tableCell(
    String value, {
    required int flex,
    Color? color,
    bool bold = false,
    bool monospace = false,
  }) => Expanded(
    flex: flex,
    child: Center(
      child: Text(
        value,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: color,
          fontSize: 13,
          fontWeight: bold ? FontWeight.w800 : FontWeight.w500,
          fontFamily: monospace ? 'monospace' : null,
          letterSpacing: monospace ? 0.15 : null,
        ),
      ),
    ),
  );

  static Widget _infoPill(
    BuildContext context, {
    required IconData icon,
    required String label,
  }) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 8),
    decoration: BoxDecoration(
      color: Theme.of(context).colorScheme.primaryContainer.withValues(alpha: 0.6),
      borderRadius: BorderRadius.circular(30),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 15, color: Theme.of(context).colorScheme.primary),
        const SizedBox(width: 6),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
      ],
    ),
  );
}

class _TableHeading extends StatelessWidget {
  const _TableHeading(this.label, {required this.flex});

  final String label;
  final int flex;

  @override
  Widget build(BuildContext context) => Expanded(
    flex: flex,
    child: Text(
      label,
      textAlign: TextAlign.center,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 12,
        fontWeight: FontWeight.w800,
      ),
    ),
  );
}

class _HexSymbolChip extends StatelessWidget {
  const _HexSymbolChip({required this.decimal, required this.hex});

  final String decimal;
  final String hex;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 8),
    decoration: BoxDecoration(
      color: Theme.of(context).colorScheme.surface,
      borderRadius: BorderRadius.circular(11),
      border: Border.all(
        color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.18),
      ),
    ),
    child: Text(
      '$decimal = $hex',
      style: TextStyle(
        color: Theme.of(context).colorScheme.primary,
        fontWeight: FontWeight.w800,
        fontSize: 12,
      ),
    ),
  );
}
