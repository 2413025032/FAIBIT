import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'screens/identity_splash.dart';
import 'data/user_profile_repository.dart';
import 'models/models.dart';
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
  final profileRepository = UserProfileRepository(preferences);
  final profile = await profileRepository.load();
  final settings = AppSettingsController(preferences: preferences)..load();
  UserProfileRepository.configure(profileRepository);
  runApp(
    AppSettingsScope(
      controller: settings,
      child: FaibitApp(initialProfile: profile),
    ),
  );
}

class FaibitApp extends StatelessWidget {
  const FaibitApp({super.key, this.initialProfile});

  final UserProfile? initialProfile;

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
      home: SplashScreen(initialProfile: initialProfile),
    );
  }
}
