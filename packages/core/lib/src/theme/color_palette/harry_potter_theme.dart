import 'package:flutter/material.dart';

/// Harry Potter Magical theme with authentic Gryffindor (light) and Slytherin (dark) colors
class HarryPotterTheme {
  static const String themeId = 'harry_potter';
  static const String themeName = 'Harry Potter Magical';

  /// Light theme with authentic Gryffindor colors (Scarlet and Gold)
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: const ColorScheme.light(
        primary: Color(0xFFD4AF37), // Rich Gryffindor Gold
        onPrimary: Color(0xFF000000),
        secondary: Color(0xFF8B0000), // Deep Gryffindor Scarlet
        onSecondary: Color(0xFFFFFFFF),
        tertiary: Color(0xFFB8860B), // Dark Goldenrod
        onTertiary: Color(0xFFFFFFFF),
        surface: Color(0xFFFFFBF0), // Warm parchment-like surface
        onSurface: Color(0xFF2C1810), // Rich brown text
        surfaceVariant: Color(0xFFFFF8DC), // Cornsilk variant
        onSurfaceVariant: Color(0xFF4A3728), // Darker brown for variants
        background: Color(0xFFFFFBF0), // Parchment background
        onBackground: Color(0xFF2C1810), // Rich brown text
        error: Color(0xFFBA1A1A),
        onError: Color(0xFFFFFFFF),
        outline: Color(0xFFD4AF37), // Gryffindor Gold outline
        outlineVariant: Color(0xFFB8860B), // Darker gold variant
        inversePrimary: Color(0xFF8B0000), // Scarlet for inverse
        inverseSurface: Color(0xFF2C1810),
        onInverseSurface: Color(0xFFFFFBF0),
        shadow: Color(0xFF000000),
        scrim: Color(0xFF000000),
      ),
      cardTheme: const CardThemeData(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        color: Color(0xFFFFF8DC), // Cornsilk card background
        shadowColor: Color(0xFFD4AF37),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFD4AF37),
          foregroundColor: const Color(0xFF000000),
          elevation: 3,
          shadowColor: const Color(0xFF8B0000),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: const Color(0xFF8B0000),
          side: const BorderSide(color: Color(0xFF8B0000), width: 2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: const Color(0xFF8B0000),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Color(0xFFD4AF37),
        foregroundColor: Color(0xFF000000),
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF8B0000), // Deep Gryffindor Scarlet
        foregroundColor: Color(0xFFD4AF37), // Gold text/icons
        elevation: 4,
        shadowColor: Color(0xFF000000),
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: Color(0xFFD4AF37),
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Color(0xFF8B0000), // Deep Gryffindor Scarlet
        selectedItemColor: Color(0xFFD4AF37), // Gold for selected
        unselectedItemColor: Color(0xFFCD853F), // Peru for unselected
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),
      switchTheme: SwitchThemeData(
        thumbColor: MaterialStateProperty.all(const Color(0xFFD4AF37)),
        trackColor: MaterialStateProperty.all(
          const Color(0xFF8B0000).withOpacity(0.4),
        ),
        trackOutlineColor: MaterialStateProperty.all(const Color(0xFF8B0000)),
      ),
      checkboxTheme: CheckboxThemeData(
        fillColor: MaterialStateProperty.all(const Color(0xFFD4AF37)),
        checkColor: MaterialStateProperty.all(const Color(0xFF000000)),
        side: const BorderSide(color: Color(0xFF8B0000), width: 2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      ),
      radioTheme: RadioThemeData(
        fillColor: MaterialStateProperty.all(const Color(0xFFD4AF37)),
        overlayColor: MaterialStateProperty.all(
          const Color(0xFF8B0000).withOpacity(0.2),
        ),
      ),
      sliderTheme: SliderThemeData(
        thumbColor: const Color(0xFFD4AF37),
        activeTrackColor: const Color(0xFF8B0000),
        inactiveTrackColor: const Color(0xFF8B0000).withOpacity(0.3),
        overlayColor: const Color(0xFFD4AF37).withOpacity(0.2),
        trackHeight: 4,
        thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8),
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: Color(0xFFD4AF37),
        linearTrackColor: Color(0xFF8B0000),
      ),
      dividerTheme: const DividerThemeData(
        color: Color(0xFFD4AF37),
        thickness: 1,
        space: 1,
      ),
      chipTheme: ChipThemeData(
        backgroundColor: const Color(0xFFFFF8DC),
        selectedColor: const Color(0xFFD4AF37),
        disabledColor: const Color(0xFFCD853F).withOpacity(0.3),
        labelStyle: const TextStyle(color: Color(0xFF2C1810)),
        secondaryLabelStyle: const TextStyle(color: Color(0xFF000000)),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
    );
  }

  /// Dark theme with authentic Slytherin colors (Emerald and Silver)
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: const ColorScheme.dark(
        primary: Color(0xFF1B4D3E), // Deep Slytherin Emerald
        onPrimary: Color(0xFFE8F5E8), // Light green text
        secondary: Color(0xFFC0C0C0), // Slytherin Silver
        onSecondary: Color(0xFF000000),
        tertiary: Color(0xFF2E8B57), // Sea Green
        onTertiary: Color(0xFFFFFFFF),
        surface: Color(0xFF0A1A0A), // Very dark green-tinted surface
        onSurface: Color(0xFFFFFFFF), // Pure white text (solid contrast)
        surfaceVariant: Color(0xFF1A2A1A), // Dark green variant
        onSurfaceVariant: Color(
          0xFFE0E0E0,
        ), // Light gray variant text (solid contrast)
        background: Color(0xFF0A1A0A), // Very dark green background
        onBackground: Color(0xFFFFFFFF), // Pure white text (solid contrast)
        error: Color(0xFFBA1A1A),
        onError: Color(0xFFFFFFFF),
        outline: Color(0xFF2E8B57), // Sea Green outline
        outlineVariant: Color(0xFF1B4D3E), // Darker emerald variant
        inversePrimary: Color(0xFFC0C0C0), // Silver for inverse
        inverseSurface: Color(0xFFE8F5E8),
        onInverseSurface: Color(0xFF0A1A0A),
        shadow: Color(0xFF000000),
        scrim: Color(0xFF000000),
      ),
      cardTheme: const CardThemeData(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        color: Color(0xFF1A2A1A), // Dark green card background
        shadowColor: Color(0xFF1B4D3E),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF1B4D3E),
          foregroundColor: const Color(0xFFE8F5E8),
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
          foregroundColor: const Color(0xFFC0C0C0),
          side: const BorderSide(color: Color(0xFFC0C0C0), width: 2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: const Color(0xFFC0C0C0),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Color(0xFF1B4D3E),
        foregroundColor: Color(0xFFE8F5E8),
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF0A1A0A), // Very dark green
        foregroundColor: Color(
          0xFFFFFFFF,
        ), // Pure white text/icons (solid contrast)
        elevation: 4,
        shadowColor: Color(0xFF000000),
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: Color(0xFFFFFFFF), // Pure white title (solid contrast)
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Color(0xFF0A1A0A), // Very dark green
        selectedItemColor: Color(
          0xFFFFFFFF,
        ), // Pure white for selected (solid contrast)
        unselectedItemColor: Color(
          0xFFB0B0B0,
        ), // Light gray for unselected (solid contrast)
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),
      switchTheme: SwitchThemeData(
        thumbColor: MaterialStateProperty.all(const Color(0xFFC0C0C0)),
        trackColor: MaterialStateProperty.all(
          const Color(0xFF1B4D3E).withOpacity(0.4),
        ),
        trackOutlineColor: MaterialStateProperty.all(const Color(0xFF1B4D3E)),
      ),
      checkboxTheme: CheckboxThemeData(
        fillColor: MaterialStateProperty.all(const Color(0xFF1B4D3E)),
        checkColor: MaterialStateProperty.all(const Color(0xFFE8F5E8)),
        side: const BorderSide(color: Color(0xFFC0C0C0), width: 2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      ),
      radioTheme: RadioThemeData(
        fillColor: MaterialStateProperty.all(const Color(0xFF1B4D3E)),
        overlayColor: MaterialStateProperty.all(
          const Color(0xFFC0C0C0).withOpacity(0.2),
        ),
      ),
      sliderTheme: SliderThemeData(
        thumbColor: const Color(0xFFC0C0C0),
        activeTrackColor: const Color(0xFF1B4D3E),
        inactiveTrackColor: const Color(0xFF1B4D3E).withOpacity(0.3),
        overlayColor: const Color(0xFFC0C0C0).withOpacity(0.2),
        trackHeight: 4,
        thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8),
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: Color(0xFFC0C0C0),
        linearTrackColor: Color(0xFF1B4D3E),
      ),
      dividerTheme: const DividerThemeData(
        color: Color(0xFF2E8B57),
        thickness: 1,
        space: 1,
      ),
      chipTheme: ChipThemeData(
        backgroundColor: const Color(0xFF1A2A1A),
        selectedColor: const Color(0xFF1B4D3E),
        disabledColor: const Color(0xFF2E8B57).withOpacity(0.3),
        labelStyle: const TextStyle(color: Color(0xFFE8F5E8)),
        secondaryLabelStyle: const TextStyle(color: Color(0xFFE8F5E8)),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
    );
  }
}
