import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  ThemeMode _themeMode = ThemeMode.light;
  ReadingSize _readingSize = ReadingSize.normal;

  ThemeMode get themeMode => _themeMode;
  ReadingSize get readingSize => _readingSize;
  double get textScale => _readingSize.scale;

  void setThemeMode(ThemeMode mode) {
    final selectedMode = mode == ThemeMode.dark
        ? ThemeMode.dark
        : ThemeMode.light;
    if (_themeMode == selectedMode) return;
    _themeMode = selectedMode;
    preferences.setString(
      _themeKey,
      selectedMode == ThemeMode.dark ? 'dark' : 'light',
    );
    notifyListeners();
  }

  void setReadingSize(ReadingSize size) {
    if (_readingSize == size) return;
    _readingSize = size;
    preferences.setString(_readingSizeKey, size.name);
    notifyListeners();
  }

  void load() {
    _themeMode = preferences.getString(_themeKey) == 'dark'
        ? ThemeMode.dark
        : ThemeMode.light;
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
    final scope = context
        .dependOnInheritedWidgetOfExactType<AppSettingsScope>();
    assert(scope != null, 'AppSettingsScope is missing above this context.');
    return scope!.notifier!;
  }
}
