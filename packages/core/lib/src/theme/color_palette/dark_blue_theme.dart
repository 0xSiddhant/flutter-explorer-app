import 'package:flutter/material.dart';

/// Dark blue theme with professional, modern colors
class DarkBlueTheme {
  static const String themeId = 'dark_blue';
  static const String themeName = 'Dark Blue';

  /// Light mode theme
  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      useMaterial3: true,
      colorScheme: const ColorScheme.light(
        primary: Color(0xFF1E3A8A), // Dark blue
        onPrimary: Color(0xFFFFFFFF), // White text on primary
        secondary: Color(0xFF3B82F6), // Blue
        onSecondary: Color(0xFFFFFFFF), // White text on secondary
        tertiary: Color(0xFF1D4ED8), // Darker blue
        onTertiary: Color(0xFFFFFFFF), // White text on tertiary
        surface: Color(0xFFF8FAFC), // Very light blue tint
        onSurface: Color(0xFF1E293B), // Dark text on surface
        error: Color(0xFFDC2626), // Red error
        onError: Color(0xFFFFFFFF), // White text on error
        outline: Color(0xFF64748B), // Gray outline
        outlineVariant: Color(0xFFCBD5E1), // Light gray outline variant
        shadow: Color(0xFF000000), // Black shadow
        scrim: Color(0xFF000000), // Black scrim
        inverseSurface: Color(0xFF1E293B), // Dark inverse surface
        onInverseSurface: Color(0xFFF1F5F9), // Light text on inverse surface
        inversePrimary: Color(0xFF60A5FA), // Light blue inverse primary
        surfaceTint: Color(0xFF1E3A8A), // Surface tint
        onSurfaceVariant: Color(0xFF475569), // Dark text on surface variant
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF1E3A8A),
        foregroundColor: Color(0xFFFFFFFF),
        elevation: 2,
        centerTitle: true,
      ),
      cardTheme: const CardThemeData(
        color: Color(0xFFF8FAFC),
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF1E3A8A),
          foregroundColor: const Color(0xFFFFFFFF),
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: const Color(0xFF1E3A8A),
          side: const BorderSide(color: Color(0xFF1E3A8A)),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(foregroundColor: const Color(0xFF1E3A8A)),
      ),
      switchTheme: SwitchThemeData(
        thumbColor: MaterialStateProperty.all(const Color(0xFF1E3A8A)),
        trackColor: MaterialStateProperty.all(
          const Color(0xFF1E3A8A).withOpacity(0.3),
        ),
      ),
      sliderTheme: SliderThemeData(
        activeTrackColor: const Color(0xFF1E3A8A),
        inactiveTrackColor: const Color(0xFF1E3A8A).withOpacity(0.3),
        thumbColor: const Color(0xFF1E3A8A),
        overlayColor: const Color(0xFF1E3A8A).withOpacity(0.2),
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: Color(0xFF1E3A8A),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Color(0xFF1E3A8A),
        foregroundColor: Color(0xFFFFFFFF),
      ),
    );
  }

  /// Dark mode theme
  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      useMaterial3: true,
      colorScheme: const ColorScheme.dark(
        primary: Color(0xFF60A5FA), // Light blue
        onPrimary: Color(0xFF0F172A), // Dark text on primary
        secondary: Color(0xFF3B82F6), // Blue
        onSecondary: Color(0xFF0F172A), // Dark text on secondary
        tertiary: Color(0xFF1D4ED8), // Darker blue
        onTertiary: Color(0xFF0F172A), // Dark text on tertiary
        surface: Color(0xFF0F172A), // Dark surface
        onSurface: Color(0xFFF1F5F9), // Light text on surface
        error: Color(0xFFEF4444), // Red error
        onError: Color(0xFF0F172A), // Dark text on error
        outline: Color(0xFF475569), // Gray outline
        outlineVariant: Color(0xFF334155), // Dark gray outline variant
        shadow: Color(0xFF000000), // Black shadow
        scrim: Color(0xFF000000), // Black scrim
        inverseSurface: Color(0xFFF1F5F9), // Light inverse surface
        onInverseSurface: Color(0xFF0F172A), // Dark text on inverse surface
        inversePrimary: Color(0xFF1E3A8A), // Dark blue inverse primary
        surfaceTint: Color(0xFF60A5FA), // Surface tint
        onSurfaceVariant: Color(0xFFCBD5E1), // Light text on surface variant
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF0F172A),
        foregroundColor: Color(0xFF60A5FA),
        elevation: 2,
        centerTitle: true,
      ),
      cardTheme: const CardThemeData(
        color: Color(0xFF0F172A),
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF60A5FA),
          foregroundColor: const Color(0xFF0F172A),
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: const Color(0xFF60A5FA),
          side: const BorderSide(color: Color(0xFF60A5FA)),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(foregroundColor: const Color(0xFF60A5FA)),
      ),
      switchTheme: SwitchThemeData(
        thumbColor: MaterialStateProperty.all(const Color(0xFF60A5FA)),
        trackColor: MaterialStateProperty.all(
          const Color(0xFF60A5FA).withOpacity(0.3),
        ),
      ),
      sliderTheme: SliderThemeData(
        activeTrackColor: const Color(0xFF60A5FA),
        inactiveTrackColor: const Color(0xFF60A5FA).withValues(alpha: 0.3),
        thumbColor: const Color(0xFF60A5FA),
        overlayColor: const Color(0xFF60A5FA).withValues(alpha: 0.2),
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: Color(0xFF60A5FA),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Color(0xFF60A5FA),
        foregroundColor: Color(0xFF0F172A),
      ),
    );
  }
}
