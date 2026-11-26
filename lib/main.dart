import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'screens/identity_splash.dart';
import 'data/user_profile_repository.dart';
import 'models/models.dart';
import 'data/sqlite_quiz_history_provider.dart';
import 'data/quiz_history_repository.dart';
import 'settings/app_settings.dart';
import 'services/sound_manager.dart';
import 'theme/app_theme.dart';


const String _pendingProfilePhotoKey = 'faibit_pending_profile_photo_path_v1';

Future<void> _recoverLostProfilePhoto(SharedPreferences preferences) async {
  try {
    final response = await ImagePicker().retrieveLostData();
    final files = response.files;
    if (files != null && files.isNotEmpty) {
      await preferences.setString(_pendingProfilePhotoKey, files.first.path);
      debugPrint('FAIBIT: foto dari galeri berhasil dipulihkan.');
    } else if (response.exception != null) {
      debugPrint('FAIBIT: pemulihan foto galeri gagal: ${response.exception}');
    }
  } catch (error) {
    // Proses pemulihan bersifat tambahan; tidak boleh menghalangi startup.
    debugPrint('FAIBIT: pemeriksaan foto tertunda gagal: $error');
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await SoundManager.instance.initialize();
  } catch (error) {
    // Audio is non-critical: the app must still open if SFX initialization fails.
    debugPrint('FAIBIT audio initialization failed: $error');
  }
  final preferences = await SharedPreferences.getInstance();
  await _recoverLostProfilePhoto(preferences);
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
      routes: {
        '/identity': (_) => const IdentityPage(),
      },
      theme: settings.appThemeMode == AppThemeMode.pink
          ? AppTheme.pink
          : AppTheme.light,
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
