import 'package:flutter/material.dart';

/// Central visual tokens for FAIBIT V2.
/// Font family names safely fall back to the platform font until assets arrive.
class AppTheme {
  static const greenTeal = Color(0xFF0F9D78);
  static const darkGray = Color(0xFF263238);
  static const offWhite = Color(0xFFF8FAF9);
  static const challengeOrange = Color(0xFFF97316);
  static const challengeOrangeDark = Color(0xFFEA580C);
  static const challengeAccentDark = Color(0xFF7C2D12);

  static const muted = Color(0xFF607078);
  static const line = Color(0xFFD7E1DE);
  static const tealSurface = Color(0xFFE3F5F0);
  static const challengeSurface = Color(0xFFFFEEE3);
  static const radius = 16.0;

  static const headingFont = 'Poppins';
  static const bodyFont = 'Inter';

  // Compatibility aliases while screens migrate to V2 tokens.
  static const ink = darkGray;
  static const soft = offWhite;

  static const ColorScheme normalScheme = ColorScheme.light(
    primary: greenTeal,
    onPrimary: Colors.white,
    primaryContainer: tealSurface,
    onPrimaryContainer: darkGray,
    secondary: darkGray,
    onSecondary: Colors.white,
    tertiary: challengeOrange,
    onTertiary: Colors.white,
    surface: Colors.white,
    onSurface: darkGray,
    outline: line,
  );

  /// Tokens reserved for the Challenge visual mode in a later phase.
  static const ChallengeColors challenge = ChallengeColors(
    primary: challengeOrange,
    primaryDark: challengeOrangeDark,
    accentDark: challengeAccentDark,
    surface: challengeSurface,
  );

  static const TextTheme _textTheme = TextTheme(
    displaySmall: TextStyle(
      fontFamily: headingFont,
      fontSize: 32,
      fontWeight: FontWeight.w700,
      color: darkGray,
    ),
    headlineSmall: TextStyle(
      fontFamily: headingFont,
      fontSize: 24,
      fontWeight: FontWeight.w700,
      color: darkGray,
    ),
    titleLarge: TextStyle(
      fontFamily: headingFont,
      fontSize: 20,
      fontWeight: FontWeight.w700,
      color: darkGray,
    ),
    titleMedium: TextStyle(
      fontFamily: headingFont,
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: darkGray,
    ),
    labelLarge: TextStyle(
      fontFamily: headingFont,
      fontSize: 18,
      fontWeight: FontWeight.w700,
    ),
    bodyLarge: TextStyle(
      fontFamily: bodyFont,
      fontSize: 16,
      height: 1.5,
      color: darkGray,
    ),
    bodyMedium: TextStyle(
      fontFamily: bodyFont,
      fontSize: 14,
      height: 1.45,
      color: darkGray,
    ),
    bodySmall: TextStyle(
      fontFamily: bodyFont,
      fontSize: 12,
      height: 1.4,
      color: muted,
    ),
  );

  static ThemeData get light => ThemeData(
    useMaterial3: true,
    fontFamily: bodyFont,
    colorScheme: normalScheme,
    scaffoldBackgroundColor: offWhite,
    textTheme: _textTheme,
    appBarTheme: const AppBarTheme(
      backgroundColor: offWhite,
      foregroundColor: darkGray,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontFamily: headingFont,
        color: darkGray,
        fontSize: 20,
        fontWeight: FontWeight.w700,
      ),
    ),
    iconTheme: const IconThemeData(color: darkGray),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: greenTeal,
        foregroundColor: Colors.white,
        minimumSize: const Size.fromHeight(52),
        textStyle: const TextStyle(
          fontFamily: headingFont,
          fontSize: 18,
          fontWeight: FontWeight.w700,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: darkGray,
        minimumSize: const Size.fromHeight(48),
        textStyle: const TextStyle(
          fontFamily: headingFont,
          fontWeight: FontWeight.w600,
        ),
        side: const BorderSide(color: line),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      hintStyle: const TextStyle(fontFamily: bodyFont, color: muted),
      labelStyle: const TextStyle(fontFamily: bodyFont, color: darkGray),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radius),
        borderSide: const BorderSide(color: line),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radius),
        borderSide: const BorderSide(color: line),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radius),
        borderSide: const BorderSide(color: greenTeal, width: 2),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: Colors.white,
      indicatorColor: tealSurface,
      height: 72,
      labelTextStyle: const WidgetStatePropertyAll(
        TextStyle(
          fontFamily: headingFont,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
      iconTheme: WidgetStateProperty.resolveWith(
        (states) => IconThemeData(
          color: states.contains(WidgetState.selected) ? greenTeal : muted,
        ),
      ),
    ),
    chipTheme: ChipThemeData(
      backgroundColor: Colors.white,
      selectedColor: tealSurface,
      secondarySelectedColor: tealSurface,
      side: const BorderSide(color: line),
      labelStyle: const TextStyle(fontFamily: bodyFont, color: darkGray),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    ),
  );
}

class ChallengeColors {
  const ChallengeColors({
    required this.primary,
    required this.primaryDark,
    required this.accentDark,
    required this.surface,
  });
  final Color primary;
  final Color primaryDark;
  final Color accentDark;
  final Color surface;
}
