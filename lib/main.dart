import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'screens/identity_splash.dart';
import 'data/sqlite_quiz_history_provider.dart';
import 'data/quiz_history_repository.dart';
import 'settings/app_settings.dart';
import 'theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final preferences = await SharedPreferences.getInstance();
  final historyProvider = await SqliteQuizHistoryProvider.initialize(
    preferences: preferences,
  );
  QuizHistoryRepository.configureStore(historyProvider.repository);
  final settings = AppSettingsController(preferences: preferences)..load();
  runApp(AppSettingsScope(controller: settings, child: const FaibitApp()));
}

class FaibitApp extends StatelessWidget {
  const FaibitApp({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = AppSettingsScope.of(context);
    return MaterialApp(
      title: 'FAIBIT',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: settings.themeMode,
      builder: (context, child) => MediaQuery(
        data: MediaQuery.of(context)
            .copyWith(textScaler: TextScaler.linear(settings.textScale)),
        child: child!,
      ),
      home: const SplashScreen(),
    );
  }
}
