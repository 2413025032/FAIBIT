import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum AppThemeMode { light, dark, pink }

enum ReadingSize {
  small('Kecil', 0.88),
  normal('Normal', 1.0),
  large('Besar', 1.15),
  extraLarge('Sangat Besar', 1.3);

  const ReadingSize(this.label, this.scale);

  final String label;
  final double scale;
}

class AppSettingsController extends ChangeNotifier {
  AppSettingsController({required this.preferences});

  static const _themeKey = 'theme_mode';
  static const _readingSizeKey = 'reading_size';

  final SharedPreferences preferences;
  AppThemeMode _appThemeMode = AppThemeMode.light;
  ReadingSize _readingSize = ReadingSize.normal;

  AppThemeMode get appThemeMode => _appThemeMode;
  ThemeMode get themeMode =>
      _appThemeMode == AppThemeMode.dark ? ThemeMode.dark : ThemeMode.light;
  ReadingSize get readingSize => _readingSize;
  double get textScale => _readingSize.scale;

  void setAppThemeMode(AppThemeMode mode) {
    if (_appThemeMode == mode) return;
    _appThemeMode = mode;
    preferences.setString(_themeKey, mode.name);
    notifyListeners();
  }

  /// Backwards-compatible method for any older screen still using ThemeMode.
  void setThemeMode(ThemeMode mode) {
    setAppThemeMode(
      mode == ThemeMode.dark ? AppThemeMode.dark : AppThemeMode.light,
    );
  }

  void setReadingSize(ReadingSize size) {
    if (_readingSize == size) return;
    _readingSize = size;
    preferences.setString(_readingSizeKey, size.name);
    notifyListeners();
  }

  Future<void> reset() async {
    for (final key in [_themeKey, _readingSizeKey]) {
      if (preferences.containsKey(key)) {
        final removed = await preferences.remove(key);
        if (!removed) {
          throw StateError('Pengaturan lokal tidak dapat direset: $key.');
        }
      }
    }
    _appThemeMode = AppThemeMode.light;
    _readingSize = ReadingSize.normal;
    notifyListeners();
  }

  void load() {
    final savedTheme = preferences.getString(_themeKey);
    _appThemeMode = AppThemeMode.values.firstWhere(
      (mode) => mode.name == savedTheme,
      orElse: () => savedTheme == 'dark'
          ? AppThemeMode.dark
          : AppThemeMode.light,
    );
    final savedSize = preferences.getString(_readingSizeKey);
    _readingSize = ReadingSize.values.firstWhere(
      (size) => size.name == savedSize,
      orElse: () => ReadingSize.normal,
    );
  }
}

class AppSettingsScope extends InheritedNotifier<AppSettingsController> {
  const AppSettingsScope({
    super.key,
    required AppSettingsController controller,
    required super.child,
  }) : super(notifier: controller);

  static AppSettingsController of(BuildContext context) {
    final scope =
        context.dependOnInheritedWidgetOfExactType<AppSettingsScope>();
    assert(scope != null, 'AppSettingsScope is missing above this context.');
    return scope!.notifier!;
  }
}
