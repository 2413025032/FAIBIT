import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../theme/app_theme.dart';
import '../widgets/ui.dart';

/// Interactive number-system converter for non-negative integers up to 32 bits.
/// The screen is fully offline and does not require a database or API.
class InteractiveNumberSystemPage extends StatefulWidget {
  const InteractiveNumberSystemPage({super.key});

  @override
  State<InteractiveNumberSystemPage> createState() =>
      _InteractiveNumberSystemPageState();
}

class _InteractiveNumberSystemPageState
    extends State<InteractiveNumberSystemPage> {
  static final BigInt _maxValue = (BigInt.one << 32) - BigInt.one;

  final TextEditingController _numberController = TextEditingController();

  int _selectedRadix = 10;
  int _visualizationRadix = 2;

  String get _radixLabel => switch (_selectedRadix) {
    2 => 'Biner',
    8 => 'Oktal',
    10 => 'Desimal',
    16 => 'Heksadesimal',
    _ => 'Bilangan',
  };

  String get _radixHint => switch (_selectedRadix) {
    2 => 'Gunakan angka 0 dan 1',
    8 => 'Gunakan angka 0 sampai 7',
    10 => 'Gunakan angka 0 sampai 9',
    16 => 'Gunakan angka 0 sampai 9 dan A sampai F',
    _ => '',
  };

  BigInt? get _parsedValue {
    final input = _numberController.text.trim().toUpperCase();
    if (input.isEmpty) return null;

    final parsed = BigInt.tryParse(input, radix: _selectedRadix);
    if (parsed == null || parsed.isNegative || parsed > _maxValue) {
      return null;
    }
    return parsed;
  }

  String? get _validationMessage {
    final input = _numberController.text.trim().toUpperCase();
    if (input.isEmpty) return null;

    final parsed = BigInt.tryParse(input, radix: _selectedRadix);
    if (parsed == null || parsed.isNegative) {
      return 'Angka tidak sesuai dengan sistem bilangan $_radixLabel.';
    }
    if (parsed > _maxValue) {
      return 'Nilai terlalu besar. Gunakan bilangan maksimal 32 bit.';
    }
    return null;
  }

  @override
  void dispose() {
    _numberController.dispose();
    super.dispose();
  }

  void _selectRadix(int radix) {
    if (_selectedRadix == radix) return;
    setState(() => _selectedRadix = radix);
  }

  void _resetInput() {
    setState(() => _numberController.clear());
  }

  Future<void> _copyValue(String value, String label) async {
    await Clipboard.setData(ClipboardData(text: value));
    if (!mounted) return;
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text('Hasil $label berhasil disalin.'),
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 2),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    final value = _parsedValue;
    final error = _validationMessage;

    return Scaffold(
      appBar: const PageTitle(title: 'Konversi Bilangan'),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _introCard(context),
              const SizedBox(height: 18),
              Text(
                '1. Pilih sistem bilangan',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 9),
              _radixSelector(context),
              const SizedBox(height: 18),
              Text(
                '2. Masukkan angka',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 9),
              OutlineCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      controller: _numberController,
                      onChanged: (_) => setState(() {}),
                      textCapitalization: TextCapitalization.characters,
                      keyboardType: TextInputType.text,
                      autocorrect: false,
                      enableSuggestions: false,
                      decoration: InputDecoration(
                        labelText: 'Bilangan $_radixLabel',
                        hintText: _selectedRadix == 10 ? 'Contoh: 13' : _hintExample,
                        helperText: _radixHint,
                        suffixIcon: IconButton(
                          tooltip: 'Hapus angka',
                          onPressed: _resetInput,
                          icon: const Icon(Icons.close_rounded),
                        ),
                      ),
                    ),
                    if (error != null) ...[
                      const SizedBox(height: 9),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.error_outline_rounded,
                            color: Colors.red,
                            size: 18,
                          ),
                          const SizedBox(width: 7),
                          Expanded(
                            child: Text(
                              error,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(color: Colors.red),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(height: 18),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      '3. Hasil konversi',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  if (value != null)
                    Text(
                      'Diperbarui otomatis',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                ],
              ),
              const SizedBox(height: 9),
              if (value == null)
                _emptyResult(context, error != null)
              else ...[
                _conversionResults(context, value),
                const SizedBox(height: 18),
                _radixVisualization(context, value),
                const SizedBox(height: 14),
                _placeValueExplanation(context, value),
              ],
            ],
          ),
        ),
      ),
    );
  }

  String get _hintExample => switch (_selectedRadix) {
    2 => 'Contoh: 1101',
    8 => 'Contoh: 15',
    16 => 'Contoh: D',
    _ => 'Masukkan angka',
  };

  Widget _introCard(BuildContext context) {
    return OutlineCard(
      padding: const EdgeInsets.fromLTRB(15, 13, 12, 13),
      child: Row(
        children: [
          const FaiMascot(
            assetName: 'faibit_thinking.png',
            fallbackAssetName: 'faibit_reading.png',
            width: 88,
            height: 104,
            semanticLabel: 'Fai sedang berpikir',
          ),
          const SizedBox(width: 9),
          Expanded(
            child: SpeechBubble(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Ayo bereksperimen!',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Ubah basis bilangan dan amati hasil konversinya secara langsung.',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _radixSelector(BuildContext context) {
    const choices = <({int radix, String label})>[
      (radix: 2, label: 'BIN'),
      (radix: 8, label: 'OCT'),
      (radix: 10, label: 'DEC'),
      (radix: 16, label: 'HEX'),
    ];

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: choices.map((choice) {
        final selected = _selectedRadix == choice.radix;
        return ChoiceChip(
          label: Text(choice.label),
          selected: selected,
          onSelected: (_) => _selectRadix(choice.radix),
          labelStyle: TextStyle(
            color: selected
                ? Theme.of(context).colorScheme.onPrimary
                : Theme.of(context).colorScheme.onSurface,
            fontWeight: FontWeight.w700,
          ),
          selectedColor: Theme.of(context).colorScheme.primary,
          backgroundColor: Theme.of(context).colorScheme.surface,
          side: BorderSide(
            color: selected
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.outline,
          ),
          showCheckmark: false,
          padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 8),
        );
      }).toList(),
    );
  }

  Widget _emptyResult(BuildContext context, bool hasError) {
    return OutlineCard(
      child: Row(
        children: [
          Icon(
            hasError ? Icons.edit_note_rounded : Icons.swap_horiz_rounded,
            size: 34,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              hasError
                  ? 'Periksa kembali angka yang kamu masukkan.'
                  : 'Masukkan angka untuk melihat hasil konversi.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }

  Widget _conversionResults(BuildContext context, BigInt value) {
    final results = <({String label, String radix, int base, String result})>[
      (
        label: 'BINER',
        radix: 'Basis 2',
        base: 2,
        result: value.toRadixString(2),
      ),
      (
        label: 'OKTAL',
        radix: 'Basis 8',
        base: 8,
        result: value.toRadixString(8),
      ),
      (
        label: 'DESIMAL',
        radix: 'Basis 10',
        base: 10,
        result: value.toRadixString(10),
      ),
      (
        label: 'HEKSADESIMAL',
        radix: 'Basis 16',
        base: 16,
        result: value.toRadixString(16).toUpperCase(),
      ),
    ];

    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 9,
      mainAxisSpacing: 9,
      childAspectRatio: 1.45,
      children: results.map((item) {
        final isSelected = item.base == _visualizationRadix;
        return OutlineCard(
          onTap: () => setState(() => _visualizationRadix = item.base),
          padding: const EdgeInsets.fromLTRB(11, 10, 7, 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      item.label,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            fontWeight: FontWeight.w800,
                            letterSpacing: 0.4,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                    ),
                  ),
                  IconButton(
                    visualDensity: VisualDensity.compact,
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints.tightFor(
                      width: 30,
                      height: 30,
                    ),
                    tooltip: 'Salin hasil ${item.label}',
                    onPressed: () => _copyValue(
                      item.result,
                      item.label.toLowerCase(),
                    ),
                    icon: const Icon(Icons.copy_rounded, size: 16),
                  ),
                ],
              ),
              const Spacer(),
              FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerLeft,
                child: Text(
                  item.result,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w800,
                        color: isSelected
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).colorScheme.onSurface,
                      ),
                ),
              ),
              Text(
                item.radix,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  String _radixName(int radix) => switch (radix) {
    2 => 'biner',
    8 => 'oktal',
    10 => 'desimal',
    16 => 'heksadesimal',
    _ => 'bilangan',
  };

  String _radixSubscript(int radix) => switch (radix) {
    2 => '₂',
    8 => '₈',
    10 => '₁₀',
    16 => '₁₆',
    _ => '',
  };

  int _digitValue(String digit) {
    final code = digit.toUpperCase().codeUnitAt(0);
    if (code >= 48 && code <= 57) return code - 48;
    if (code >= 65 && code <= 70) return code - 55;
    return 0;
  }

  Widget _radixVisualization(BuildContext context, BigInt value) {
    final radix = _visualizationRadix;
    final number = value.toRadixString(radix).toUpperCase();
    final digits = number.split('');
    final colorScheme = Theme.of(context).colorScheme;

    return OutlineCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Visualisasi ${_radixName(radix)}',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 4),
          Text(
            'Setiap kotak menunjukkan satu digit dan nilai posisinya.',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: 13),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(digits.length, (index) {
                final digit = digits[index];
                final digitValue = _digitValue(digit);
                final power = digits.length - index - 1;
                final isNonZero = digitValue != 0;
                final activeColor = colorScheme.primary;
                final inactiveColor = colorScheme.surfaceContainerHighest;

                return SizedBox(
                  width: 43,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 4),
                    child: Column(
                      children: [
                        Container(
                          height: 43,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: isNonZero ? activeColor : inactiveColor,
                            borderRadius: BorderRadius.circular(9),
                          ),
                          child: Text(
                            digit,
                            style: TextStyle(
                              color: isNonZero
                                  ? colorScheme.onPrimary
                                  : colorScheme.onSurface,
                              fontSize: 19,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          '$radix^$power',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 13,
            runSpacing: 7,
            children: [
              _legend(context, colorScheme.primary, 'Digit bukan 0'),
              _legend(
                context,
                colorScheme.surfaceContainerHighest,
                'Digit 0',
                border: true,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _legend(
    BuildContext context,
    Color color,
    String label, {
    bool border = false,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(3),
            border: border
                ? Border.all(color: Theme.of(context).colorScheme.outline)
                : null,
          ),
        ),
        const SizedBox(width: 5),
        Text(label, style: Theme.of(context).textTheme.bodySmall),
      ],
    );
  }

  Widget _placeValueExplanation(BuildContext context, BigInt value) {
    final radix = _visualizationRadix;
    final number = value.toRadixString(radix).toUpperCase();
    final digits = number.split('');
    final terms = <String>[];
    final contributions = <String>[];

    for (var index = 0; index < digits.length; index++) {
      final digit = digits[index];
      final digitValue = _digitValue(digit);
      final power = digits.length - index - 1;
      if (digitValue == 0) continue;

      final contribution = BigInt.from(digitValue) * BigInt.from(radix).pow(power);
      terms.add('$digit × $radix^$power');
      contributions.add(contribution.toString());
    }

    final expression = terms.isEmpty ? '0' : terms.join(' + ');
    final expandedValues = contributions.isEmpty
        ? '0'
        : contributions.join(' + ');

    return OutlineCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Mengapa hasilnya ${value.toString()}?',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 7),
          Text(
            'Pada sistem ${_radixName(radix)}, setiap posisi memiliki nilai pangkat $radix. '
            'Nilai setiap digit dikalikan dengan bobot posisinya, kemudian seluruh hasilnya dijumlahkan.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(AppTheme.radius - 4),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${number}${_radixSubscript(radix)} = $expression',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  '= $expandedValues = ${value.toString()}₁₀',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.w800,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
