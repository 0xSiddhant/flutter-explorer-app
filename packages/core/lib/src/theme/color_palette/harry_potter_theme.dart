import 'package:flutter/material.dart';

/// Harry Potter Magical theme with Gryffindor (light) and Slytherin (dark) colors
class HarryPotterTheme {
  static const String themeId = 'harry_potter';
  static const String themeName = 'Harry Potter Magical';

  /// Light theme with Gryffindor colors (Scarlet and Gold)
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: const ColorScheme.light(
        primary: Color(0xFFD3A625), // Gryffindor Gold
        onPrimary: Color(0xFF000000),
        secondary: Color(0xFF740001), // Gryffindor Scarlet
        onSecondary: Color(0xFFFFFFFF),
        tertiary: Color(0xFFF4C430), // Golden Snitch Gold
        onTertiary: Color(0xFF000000),
        surface: Color(0xFFFFF8E1), // Warm cream
        onSurface: Color(0xFF2C1810), // Lighter cream
        onSurfaceVariant: Color(0xFF2C1810),
        error: Color(0xFFBA1A1A),
        onError: Color(0xFFFFFFFF),
        outline: Color(0xFFD3A625), // Gryffindor Gold
        outlineVariant: Color(0xFFD3A625), // Gryffindor Gold variant
      ),
      cardTheme: const CardThemeData(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFD3A625),
          foregroundColor: const Color(0xFF000000),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: const Color(0xFFD3A625),
          side: const BorderSide(color: Color(0xFFD3A625)),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(foregroundColor: const Color(0xFFD3A625)),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Color(0xFFD3A625),
        foregroundColor: Color(0xFF000000),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(
          0xFFF4C430,
        ), // Lighter gold for better visibility
        foregroundColor: Color(0xFF000000),
        elevation: 0,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Color(0xFFFFF8E1),
        selectedItemColor: Color(0xFFD3A625),
        unselectedItemColor: Color(0xFF666666),
      ),
      switchTheme: SwitchThemeData(
        thumbColor: MaterialStateProperty.all(const Color(0xFFD3A625)),
        trackColor: MaterialStateProperty.all(
          const Color(0xFFD3A625).withOpacity(0.3),
        ),
      ),
      checkboxTheme: CheckboxThemeData(
        fillColor: MaterialStateProperty.all(const Color(0xFFD3A625)),
        checkColor: MaterialStateProperty.all(const Color(0xFF000000)),
        side: const BorderSide(color: Color(0xFFD3A625)),
      ),
      radioTheme: RadioThemeData(
        fillColor: MaterialStateProperty.all(const Color(0xFFD3A625)),
      ),
      sliderTheme: SliderThemeData(
        thumbColor: const Color(0xFFD3A625),
        activeTrackColor: const Color(0xFFD3A625),
        inactiveTrackColor: const Color(0xFFD3A625).withValues(alpha: 0.3),
        overlayColor: const Color(0xFFD3A625).withValues(alpha: 0.2),
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: Color(0xFFD3A625),
      ),
    );
  }

  /// Dark theme with Slytherin colors (Emerald and Silver)
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: const ColorScheme.dark(
        primary: Color(0xFF2A623D), // Slytherin Emerald
        onPrimary: Color(0xFFFFFFFF),
        secondary: Color(0xFFC0C0C0), // Slytherin Silver
        onSecondary: Color(0xFF000000),
        tertiary: Color(0xFF1A472A), // Dark Slytherin Green
        onTertiary: Color(0xFFFFFFFF),
        surface: Color(0xFF1A1A1A), // Dark surface
        onSurface: Color(0xFFE0E0E0),
        onSurfaceVariant: Color(0xFFE0E0E0),
        error: Color(0xFFBA1A1A),
        onError: Color(0xFFFFFFFF),
        outline: Color(0xFF2A623D), // Slytherin Emerald
        outlineVariant: Color(0xFF2A623D), // Slytherin Emerald variant
      ),
      cardTheme: const CardThemeData(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF2A623D),
          foregroundColor: const Color(0xFFFFFFFF),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: const Color(0xFF2A623D),
          side: const BorderSide(color: Color(0xFF2A623D)),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(foregroundColor: const Color(0xFF2A623D)),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Color(0xFF2A623D),
        foregroundColor: Color(0xFFFFFFFF),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF2D2D2D),
        foregroundColor: Color(0xFF2A623D),
        elevation: 0,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Color(0xFF2D2D2D),
        selectedItemColor: Color(0xFF2A623D),
        unselectedItemColor: Color(0xFFCCCCCC),
      ),
      switchTheme: SwitchThemeData(
        thumbColor: MaterialStateProperty.all(const Color(0xFF2A623D)),
        trackColor: MaterialStateProperty.all(
          const Color(0xFF2A623D).withOpacity(0.3),
        ),
      ),
      checkboxTheme: CheckboxThemeData(
        fillColor: MaterialStateProperty.all(const Color(0xFF2A623D)),
        checkColor: MaterialStateProperty.all(const Color(0xFFFFFFFF)),
        side: const BorderSide(color: Color(0xFF2A623D)),
      ),
      radioTheme: RadioThemeData(
        fillColor: MaterialStateProperty.all(const Color(0xFF2A623D)),
      ),
      sliderTheme: SliderThemeData(
        thumbColor: const Color(0xFF2A623D),
        activeTrackColor: const Color(0xFF2A623D),
        inactiveTrackColor: const Color(0xFF2A623D).withValues(alpha: 0.3),
        overlayColor: const Color(0xFF2A623D).withValues(alpha: 0.2),
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: Color(0xFF2A623D),
      ),
    );
  }
}
