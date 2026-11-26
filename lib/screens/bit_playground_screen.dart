import 'package:flutter/material.dart';

import '../widgets/ui.dart';

/// Interactive 8-bit playground for learning binary place values.
/// Each tile toggles one bit and updates the decimal value immediately.
class BitPlaygroundPage extends StatefulWidget {
  const BitPlaygroundPage({super.key});

  @override
  State<BitPlaygroundPage> createState() => _BitPlaygroundPageState();
}

class _BitPlaygroundPageState extends State<BitPlaygroundPage> {
  // Index 0 represents bit 7 (128); index 7 represents bit 0 (1).
  final List<bool> _bits = List<bool>.filled(8, false);

  int get _decimalValue {
    var value = 0;
    for (var index = 0; index < _bits.length; index++) {
      if (_bits[index]) value += 1 << (7 - index);
    }
    return value;
  }

  List<int> get _activeValues => [
        for (var index = 0; index < _bits.length; index++)
          if (_bits[index]) 1 << (7 - index),
      ];

  void _toggleBit(int index) {
    setState(() => _bits[index] = !_bits[index]);
  }

  void _resetBits() {
    setState(() {
      for (var index = 0; index < _bits.length; index++) {
        _bits[index] = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final activeValues = _activeValues;
    final expression = activeValues.isEmpty
        ? '0'
        : activeValues.join(' + ');

    return Scaffold(
      appBar: const PageTitle(title: 'Bit Playground'),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              OutlineCard(
                padding: const EdgeInsets.fromLTRB(15, 13, 15, 13),
                child: Row(
                  children: [
                    const FaiMascot(
                      assetName: 'faibit_thinking.png',
                      fallbackAssetName: 'faibit_reading.png',
                      width: 78,
                      height: 92,
                      semanticLabel: 'Fai sedang berpikir',
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Ayo mainkan bit!',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(color: colorScheme.primary),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            'Tekan setiap kotak untuk mengubah bit dari 0 menjadi 1, atau sebaliknya. Amati perubahan nilainya!',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Atur 8-bit',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  TextButton.icon(
                    onPressed: _resetBits,
                    icon: const Icon(Icons.refresh_rounded, size: 18),
                    label: const Text('Reset'),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 8,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 9,
                  mainAxisSpacing: 9,
                  childAspectRatio: 0.9,
                ),
                itemBuilder: (context, index) {
                  final bitNumber = 7 - index;
                  final bitValue = 1 << bitNumber;
                  final isOn = _bits[index];
                  final background = isOn
                      ? colorScheme.primary
                      : colorScheme.surfaceContainerHighest;
                  final foreground = isOn
                      ? colorScheme.onPrimary
                      : colorScheme.onSurface;

                  return Semantics(
                    button: true,
                    label: 'Bit $bitNumber, nilai $bitValue, ${isOn ? 'ON' : 'OFF'}',
                    child: Material(
                      color: background,
                      borderRadius: BorderRadius.circular(14),
                      child: InkWell(
                        onTap: () => _toggleBit(index),
                        borderRadius: BorderRadius.circular(14),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                              color: isOn
                                  ? colorScheme.primary
                                  : colorScheme.outline.withValues(alpha: 0.45),
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 3,
                            vertical: 5,
                          ),
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  isOn ? '1' : '0',
                                  style: TextStyle(
                                    color: foreground,
                                    fontSize: 25,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                                const SizedBox(height: 1),
                                Text(
                                  'BIT $bitNumber',
                                  style: TextStyle(
                                    color: foreground,
                                    fontSize: 9,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Text(
                                  'Nilai $bitValue',
                                  style: TextStyle(
                                    color: foreground.withValues(alpha: 0.82),
                                    fontSize: 9,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
              OutlineCard(
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hasil nilai desimal',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 180),
                      child: Text(
                        '$_decimalValue',
                        key: ValueKey(_decimalValue),
                        style: Theme.of(context).textTheme.displaySmall?.copyWith(
                              color: colorScheme.primary,
                              fontWeight: FontWeight.w800,
                            ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Nilai desimal berubah otomatis setiap kali bit ditekan.',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),
              OutlineCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Bagaimana nilai ini diperoleh?',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Hanya bit yang bernilai 1 (ON) yang dijumlahkan. Setiap bit memiliki nilai posisi masing-masing.',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 12),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(13),
                      decoration: BoxDecoration(
                        color: colorScheme.primaryContainer,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        '$expression = $_decimalValue',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              color: colorScheme.onPrimaryContainer,
                              fontWeight: FontWeight.w800,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
