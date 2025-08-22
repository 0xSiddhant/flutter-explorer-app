import 'package:flutter/material.dart';

/// Studio Ghibli theme with nature-inspired colors (light) and twinkling sky colors (dark)
class StudioGhibliTheme {
  static const String themeId = 'studio_ghibli';
  static const String themeName = 'Studio Ghibli';

  /// Light theme with nature-inspired colors (forest greens, warm earth tones, soft sky blues)
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: const ColorScheme.light(
        primary: Color(0xFF4A7C59), // Forest green
        onPrimary: Color(0xFFFFFFFF),
        secondary: Color(0xFF8B7355), // Warm earth brown
        onSecondary: Color(0xFFFFFFFF),
        tertiary: Color(0xFF87CEEB), // Sky blue
        onTertiary: Color(0xFF000000),
        surface: Color(0xFFF5F5DC), // Beige surface
        onSurface: Color(0xFF2F4F2F), // Dark green text
        surfaceVariant: Color(0xFFE8E8D0), // Light beige variant
        onSurfaceVariant: Color(0xFF556B2F), // Dark olive variant text
        background: Color(0xFFF0F8FF), // Alice blue background
        onBackground: Color(0xFF2F4F2F), // Dark green text
        error: Color(0xFFBA1A1A),
        onError: Color(0xFFFFFFFF),
        outline: Color(0xFF4A7C59), // Forest green outline
        outlineVariant: Color(0xFF6B8E23), // Olive drab variant
        inversePrimary: Color(0xFF8B7355), // Earth brown for inverse
        inverseSurface: Color(0xFF2F4F2F),
        onInverseSurface: Color(0xFFF5F5DC),
        shadow: Color(0xFF000000),
        scrim: Color(0xFF000000),
      ),
      cardTheme: const CardThemeData(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        color: Color(0xFFE8E8D0), // Light beige card background
        shadowColor: Color(0xFF4A7C59),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF4A7C59),
          foregroundColor: const Color(0xFFFFFFFF),
          elevation: 3,
          shadowColor: const Color(0xFF2F4F2F),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: const Color(0xFF4A7C59),
          side: const BorderSide(color: Color(0xFF4A7C59), width: 2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: const Color(0xFF4A7C59),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Color(0xFF4A7C59),
        foregroundColor: Color(0xFFFFFFFF),
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF4A7C59), // Forest green
        foregroundColor: Color(0xFFFFFFFF), // White text/icons
        elevation: 4,
        shadowColor: Color(0xFF000000),
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: Color(0xFFFFFFFF),
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Color(0xFF4A7C59), // Forest green
        selectedItemColor: Color(0xFFFFFFFF), // White for selected
        unselectedItemColor: Color(0xFFC0C0C0), // Light gray for unselected
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),
      switchTheme: SwitchThemeData(
        thumbColor: MaterialStateProperty.all(const Color(0xFF4A7C59)),
        trackColor: MaterialStateProperty.all(
          const Color(0xFF4A7C59).withValues(alpha: 0.4),
        ),
      ),
      checkboxTheme: CheckboxThemeData(
        fillColor: MaterialStateProperty.all(const Color(0xFF4A7C59)),
        checkColor: MaterialStateProperty.all(const Color(0xFFFFFFFF)),
        side: const BorderSide(color: Color(0xFF4A7C59), width: 2),
      ),
      radioTheme: RadioThemeData(
        fillColor: MaterialStateProperty.all(const Color(0xFF4A7C59)),
      ),
      sliderTheme: const SliderThemeData(
        activeTrackColor: Color(0xFF4A7C59),
        inactiveTrackColor: Color(0xFFC0C0C0),
        thumbColor: Color(0xFF4A7C59),
        overlayColor: Color(0x1A4A7C59),
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: Color(0xFF4A7C59),
        linearTrackColor: Color(0xFFE0E0E0),
        circularTrackColor: Color(0xFFE0E0E0),
      ),
      chipTheme: const ChipThemeData(
        backgroundColor: Color(0xFFE8E8D0),
        selectedColor: Color(0xFF4A7C59),
        disabledColor: Color(0xFFE0E0E0),
        labelStyle: TextStyle(color: Color(0xFF2F4F2F)),
        secondaryLabelStyle: TextStyle(color: Color(0xFFFFFFFF)),
        brightness: Brightness.light,
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
      ),
      dividerTheme: const DividerThemeData(
        color: Color(0xFF4A7C59),
        thickness: 1,
        space: 1,
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF4A7C59)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF4A7C59)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF4A7C59), width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFBA1A1A)),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFBA1A1A), width: 2),
        ),
        filled: true,
        fillColor: const Color(0xFFF5F5DC),
        labelStyle: const TextStyle(color: Color(0xFF556B2F)),
        hintStyle: const TextStyle(color: Color(0xFF808080)),
      ),
    );
  }

  /// Dark theme with twinkling sky colors (deep blues, purples, and star-like accents)
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: const ColorScheme.dark(
        primary: Color(0xFF1E3A8A), // Deep night blue
        onPrimary: Color(0xFFE0E7FF), // Soft blue-white text
        secondary: Color(0xFF7C3AED), // Purple for stars
        onSecondary: Color(0xFFFFFFFF),
        tertiary: Color(0xFFF59E0B), // Golden star color
        onTertiary: Color(0xFF000000),
        surface: Color(0xFF0F172A), // Deep space surface
        onSurface: Color(0xFFE0E7FF), // Soft blue-white text
        surfaceVariant: Color(0xFF1E293B), // Darker space variant
        onSurfaceVariant: Color(0xFFCBD5E1), // Light gray variant text
        background: Color(0xFF020617), // Deepest space background
        onBackground: Color(0xFFE0E7FF), // Soft blue-white text
        error: Color(0xFFBA1A1A),
        onError: Color(0xFFFFFFFF),
        outline: Color(0xFF7C3AED), // Purple outline
        outlineVariant: Color(0xFF1E3A8A), // Darker blue variant
        inversePrimary: Color(0xFF7C3AED), // Purple for inverse
        inverseSurface: Color(0xFFE0E7FF),
        onInverseSurface: Color(0xFF0F172A),
        shadow: Color(0xFF000000),
        scrim: Color(0xFF000000),
      ),
      cardTheme: const CardThemeData(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        color: Color(0xFF1E293B), // Darker space card background
        shadowColor: Color(0xFF1E3A8A),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF1E3A8A),
          foregroundColor: const Color(0xFFE0E7FF),
          elevation: 3,
          shadowColor: const Color(0xFF000000),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: const Color(0xFF7C3AED),
          side: const BorderSide(color: Color(0xFF7C3AED), width: 2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: const Color(0xFF7C3AED),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Color(0xFF1E3A8A),
        foregroundColor: Color(0xFFE0E7FF),
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF0F172A), // Deep space
        foregroundColor: Color(0xFFE0E7FF), // Soft blue-white text/icons
        elevation: 4,
        shadowColor: Color(0xFF000000),
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: Color(0xFFE0E7FF), // Soft blue-white title
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Color(0xFF0F172A), // Deep space
        selectedItemColor: Color(0xFFF59E0B), // Golden for selected
        unselectedItemColor: Color(0xFFCBD5E1), // Light gray for unselected
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),
      switchTheme: SwitchThemeData(
        thumbColor: MaterialStateProperty.all(const Color(0xFF7C3AED)),
        trackColor: MaterialStateProperty.all(
          const Color(0xFF1E3A8A).withValues(alpha: 0.4),
        ),
      ),
      checkboxTheme: CheckboxThemeData(
        fillColor: MaterialStateProperty.all(const Color(0xFF7C3AED)),
        checkColor: MaterialStateProperty.all(const Color(0xFFFFFFFF)),
        side: const BorderSide(color: Color(0xFF7C3AED), width: 2),
      ),
      radioTheme: RadioThemeData(
        fillColor: MaterialStateProperty.all(const Color(0xFF7C3AED)),
      ),
      sliderTheme: const SliderThemeData(
        activeTrackColor: Color(0xFF7C3AED),
        inactiveTrackColor: Color(0xFF475569),
        thumbColor: Color(0xFF7C3AED),
        overlayColor: Color(0x1A7C3AED),
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: Color(0xFF7C3AED),
        linearTrackColor: Color(0xFF475569),
        circularTrackColor: Color(0xFF475569),
      ),
      chipTheme: const ChipThemeData(
        backgroundColor: Color(0xFF1E293B),
        selectedColor: Color(0xFF7C3AED),
        disabledColor: Color(0xFF475569),
        labelStyle: TextStyle(color: Color(0xFFE0E7FF)),
        secondaryLabelStyle: TextStyle(color: Color(0xFFFFFFFF)),
        brightness: Brightness.dark,
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
      ),
      dividerTheme: const DividerThemeData(
        color: Color(0xFF7C3AED),
        thickness: 1,
        space: 1,
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF7C3AED)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF7C3AED)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF7C3AED), width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFBA1A1A)),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFBA1A1A), width: 2),
        ),
        filled: true,
        fillColor: const Color(0xFF1E293B),
        labelStyle: const TextStyle(color: Color(0xFFCBD5E1)),
        hintStyle: const TextStyle(color: Color(0xFF94A3B8)),
      ),
    );
  }
}
