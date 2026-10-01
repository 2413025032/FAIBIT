import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:faibit/main.dart';

void main() {
  testWidgets('shows splash, validates identity, and opens the learning home', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const FaibitApp());

    expect(find.text('FAIBIT'), findsOneWidget);
    expect(find.text('Halo!'), findsNothing);

    await tester.pump(const Duration(seconds: 3));
    await tester.pumpAndSettle();

    expect(find.text('Halo!'), findsOneWidget);
    await tester.tap(find.text('Mulai Belajar'));
    await tester.pump();

    expect(find.text('Nama wajib diisi'), findsOneWidget);
    expect(find.text('Kelas wajib diisi'), findsOneWidget);

    await tester.enterText(find.byType(TextFormField).at(0), 'Alya');
    await tester.enterText(find.byType(TextFormField).at(1), 'X TJKT 1');
    await tester.tap(find.text('Mulai Belajar'));
    await tester.pumpAndSettle();

    expect(find.text('Hai, Alya!'), findsOneWidget);
    expect(find.text('0 dari 5 materi'), findsOneWidget);
    expect(find.text('0%'), findsOneWidget);
    expect(find.text('Materi'), findsNWidgets(2));
    expect(find.text('Latihan Santai'), findsOneWidget);
    expect(find.text('Challenge'), findsNWidgets(2));
    expect(find.text('Riwayat Aktivitas'), findsOneWidget);
    await tester.tap(find.text('Materi').first);
    await tester.pumpAndSettle();

    expect(find.text('Desimal'), findsOneWidget);
  });
}
