import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:faibit/main.dart';
import 'package:faibit/models/models.dart';
import 'package:faibit/screens/home_shell.dart';

void main() {
  test('UserProfile carries name, school class, and school', () {
    const profile = UserProfile(
      name: 'Alya',
      schoolClass: 'X TJKT 1',
      school: 'SMK Negeri 1 Bandar Lampung',
    );

    expect(profile.name, 'Alya');
    expect(profile.schoolClass, 'X TJKT 1');
    expect(profile.school, 'SMK Negeri 1 Bandar Lampung');
  });

  testWidgets('validates identity and opens the four-destination home shell', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const FaibitApp());

    expect(find.text('FAIBIT'), findsOneWidget);
    await tester.pump(const Duration(seconds: 3));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Mulai Belajar'));
    await tester.pump();

    expect(find.text('Nama wajib diisi'), findsOneWidget);
    expect(find.text('Kelas wajib diisi'), findsOneWidget);
    expect(find.text('Sekolah wajib diisi'), findsOneWidget);

    await tester.enterText(find.byType(TextFormField).at(0), 'Alya');
    await tester.enterText(find.byType(TextFormField).at(1), 'X TJKT 1');
    await tester.enterText(
      find.byType(TextFormField).at(2),
      'SMK Negeri 1 Bandar Lampung',
    );
    await tester.tap(find.text('Mulai Belajar'));
    await tester.pumpAndSettle();

    expect(find.text('Hai, Alya!'), findsOneWidget);
    expect(find.byType(NavigationDestination), findsNWidgets(4));
    expect(
      find.descendant(
        of: find.byType(NavigationBar),
        matching: find.text('Latihan'),
      ),
      findsNothing,
    );
    expect(
      find.descendant(
        of: find.byType(NavigationBar),
        matching: find.text('Challenge'),
      ),
      findsNothing,
    );

    await tester.tap(find.byType(NavigationDestination).at(3));
    await tester.pumpAndSettle();

    expect(find.text('Alya'), findsOneWidget);
    expect(find.text('Kelas X TJKT 1'), findsOneWidget);
    expect(find.text('SMK Negeri 1 Bandar Lampung'), findsOneWidget);
    expect(find.byType(NavigationBar), findsOneWidget);
  });

  testWidgets('HomeShell exposes Profile as a root destination', (
    WidgetTester tester,
  ) async {
    const profile = UserProfile(
      name: 'Bima',
      schoolClass: 'X TJKT 2',
      school: 'SMK Negeri 2',
    );

    await tester.pumpWidget(
      const MaterialApp(home: HomeShell(profile: profile)),
    );
    await tester.tap(find.byType(NavigationDestination).at(3));
    await tester.pumpAndSettle();

    expect(find.text('Bima'), findsOneWidget);
    expect(find.text('SMK Negeri 2'), findsOneWidget);
  });
}
