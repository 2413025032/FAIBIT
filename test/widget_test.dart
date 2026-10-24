import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:faibit/main.dart';
import 'package:faibit/data/user_profile_repository.dart';
import 'package:faibit/models/models.dart';
import 'package:faibit/screens/home_shell.dart';
import 'package:faibit/settings/app_settings.dart';

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
    tester.view.physicalSize = const Size(800, 1000);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    SharedPreferences.setMockInitialValues({});
    final preferences = await SharedPreferences.getInstance();
    UserProfileRepository.configure(UserProfileRepository(preferences));
    final settings = AppSettingsController(preferences: preferences)..load();
    await tester.pumpWidget(
      AppSettingsScope(controller: settings, child: const FaibitApp()),
    );

    expect(find.text('FAIBIT'), findsOneWidget);
    await tester.pump(const Duration(seconds: 3));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Mulai Belajar'));
    await tester.pump();

    expect(find.text('Nama wajib diisi'), findsOneWidget);
    expect(find.text('Kelas wajib diisi'), findsOneWidget);
    expect(find.text('Sekolah wajib diisi'), findsOneWidget);

    await tester.enterText(find.byType(TextFormField).at(0), 'Alya');
    await tester.pump();
    await tester.enterText(find.byType(TextFormField).at(1), 'X TJKT 1');
    await tester.pump();
    await tester.enterText(
      find.byType(TextFormField).at(2),
      'SMK Negeri 1 Bandar Lampung',
    );
    await tester.pump();
    await tester.tap(find.byType(FilledButton).last);
    await tester.pumpAndSettle();

    expect(find.text('Hai,'), findsOneWidget);
    expect(find.text('Alya!'), findsOneWidget);
    final restored = await UserProfileRepository(preferences).load();
    expect(restored?.name, 'Alya');
    expect(restored?.schoolClass, 'X TJKT 1');
    expect(restored?.school, 'SMK Negeri 1 Bandar Lampung');
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
    expect(
      find.text('Kelas X TJKT 1 • SMK Negeri 1 Bandar Lampung'),
      findsOneWidget,
    );
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
