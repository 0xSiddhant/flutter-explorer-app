import 'package:flutter/material.dart';

/// One Piece anime theme with vibrant colors inspired by Straw Hat Pirates
class OnePieceTheme {
  static const String themeId = 'one_piece';
  static const String themeName = 'One Piece Adventure';

  /// Light theme with ultra-vibrant Straw Hat Pirates colors (Red, Orange, Blue)
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: const ColorScheme.light(
        primary: Color(0xFFC62828), // Ultra-vibrant Straw Hat Red
        onPrimary: Color(0xFFFFFFFF),
        secondary: Color(0xFFFF6F00), // Ultra-vibrant Luffy's Orange
        onSecondary: Color(0xFF000000),
        tertiary: Color(0xFF1565C0), // Ultra-vibrant Ocean Blue
        onTertiary: Color(0xFFFFFFFF),
        surface: Color(0xFFFFF8E1), // Warm parchment-like surface
        onSurface: Color(0xFF2C1810), // Rich brown text
        surfaceVariant: Color(0xFFFFF3E0), // Light orange variant
        onSurfaceVariant: Color(0xFF4A3728), // Darker brown for variants
        background: Color(0xFFFFF8E1), // Parchment background
        onBackground: Color(0xFF2C1810), // Rich brown text
        error: Color(0xFFBA1A1A),
        onError: Color(0xFFFFFFFF),
        outline: Color(0xFFC62828), // Ultra-vibrant Straw Hat Red outline
        outlineVariant: Color(
          0xFFFF6F00,
        ), // Ultra-vibrant Luffy's Orange variant
        inversePrimary: Color(
          0xFF1565C0,
        ), // Ultra-vibrant Ocean Blue for inverse
        inverseSurface: Color(0xFF2C1810),
        onInverseSurface: Color(0xFFFFF8E1),
        shadow: Color(0xFF000000),
        scrim: Color(0xFF000000),
      ),
      cardTheme: const CardThemeData(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        color: Color(0xFFFFF3E0), // Light orange card background
        shadowColor: Color(0xFFC62828),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFC62828),
          foregroundColor: const Color(0xFFFFFFFF),
          elevation: 3,
          shadowColor: const Color(0xFFFF6F00),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: const Color(0xFFC62828),
          side: const BorderSide(color: Color(0xFFC62828), width: 2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: const Color(0xFFC62828),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Color(0xFFC62828),
        foregroundColor: Color(0xFFFFFFFF),
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFFC62828), // Ultra-vibrant Straw Hat Red
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
        backgroundColor: Color(0xFFC62828), // Ultra-vibrant Straw Hat Red
        selectedItemColor: Color(0xFFFFFFFF), // White for selected
        unselectedItemColor: Color(0xFFFFB74D), // Light orange for unselected
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),
      switchTheme: SwitchThemeData(
        thumbColor: MaterialStateProperty.all(const Color(0xFFFF6F00)),
        trackColor: MaterialStateProperty.all(
          const Color(0xFFC62828).withOpacity(0.4),
        ),
        trackOutlineColor: MaterialStateProperty.all(const Color(0xFFC62828)),
      ),
      checkboxTheme: CheckboxThemeData(
        fillColor: MaterialStateProperty.all(const Color(0xFFFF6F00)),
        checkColor: MaterialStateProperty.all(const Color(0xFF000000)),
        side: const BorderSide(color: Color(0xFFC62828), width: 2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      ),
      radioTheme: RadioThemeData(
        fillColor: MaterialStateProperty.all(const Color(0xFFFF6F00)),
        overlayColor: MaterialStateProperty.all(
          const Color(0xFFC62828).withOpacity(0.2),
        ),
      ),
      sliderTheme: SliderThemeData(
        thumbColor: const Color(0xFFFF6F00),
        activeTrackColor: const Color(0xFFC62828),
        inactiveTrackColor: const Color(0xFFC62828).withOpacity(0.3),
        overlayColor: const Color(0xFFFF6F00).withOpacity(0.2),
        trackHeight: 4,
        thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8),
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: Color(0xFFFF6F00),
        linearTrackColor: Color(0xFFC62828),
      ),
      dividerTheme: const DividerThemeData(
        color: Color(0xFFFF6F00),
        thickness: 1,
        space: 1,
      ),
      chipTheme: ChipThemeData(
        backgroundColor: const Color(0xFFFFF3E0),
        selectedColor: const Color(0xFFFF6F00),
        disabledColor: const Color(0xFFFFB74D).withOpacity(0.3),
        labelStyle: const TextStyle(color: Color(0xFF2C1810)),
        secondaryLabelStyle: const TextStyle(color: Color(0xFF000000)),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
    );
  }

  /// Dark theme with balanced One Piece night colors (Deep Blue, Gold, Dark Red)
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: const ColorScheme.dark(
        primary: Color(0xFF8B0000), // Deep Straw Hat Red
        onPrimary: Color(0xFFFFFFFF),
        secondary: Color(0xFFFFD700), // Pirate Gold
        onSecondary: Color(0xFF000000),
        tertiary: Color(0xFF1E3A8A), // Deep Ocean Blue
        onTertiary: Color(0xFFFFFFFF),
        surface: Color(0xFF121212), // Dark surface (less harsh than 0A0A0A)
        onSurface: Color(0xFFFFFFFF), // White text
        surfaceVariant: Color(0xFF1E1E1E), // Dark variant (less harsh)
        onSurfaceVariant: Color(0xFFE0E0E0), // Light gray variant text
        background: Color(0xFF121212), // Dark background (less harsh)
        onBackground: Color(0xFFFFFFFF), // White text
        error: Color(0xFFBA1A1A),
        onError: Color(0xFFFFFFFF),
        outline: Color(0xFFFFD700), // Pirate Gold outline
        outlineVariant: Color(0xFF8B0000), // Deep red variant
        inversePrimary: Color(0xFFFFD700), // Gold for inverse
        inverseSurface: Color(0xFFFFFFFF),
        onInverseSurface: Color(0xFF121212),
        shadow: Color(0xFF000000),
        scrim: Color(0xFF000000),
      ),
      cardTheme: const CardThemeData(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        color: Color(0xFF1E1E1E), // Dark card background (less harsh)
        shadowColor: Color(0xFF8B0000),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF8B0000),
          foregroundColor: const Color(0xFFFFFFFF),
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
          foregroundColor: const Color(0xFFFFD700),
          side: const BorderSide(color: Color(0xFFFFD700), width: 2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: const Color(0xFFFFD700),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Color(0xFF8B0000),
        foregroundColor: Color(0xFFFFFFFF),
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(
          0xFF0A0A0A,
        ), // Very dark background for maximum contrast
        foregroundColor: Color(
          0xFFFFFFFF,
        ), // Pure white text/icons for maximum contrast
        elevation: 4,
        shadowColor: Color(0xFF000000),
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: Color(0xFFFFFFFF), // Pure white title for maximum contrast
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Color(
          0xFF0A0A0A,
        ), // Very dark background for maximum contrast
        selectedItemColor: Color(
          0xFFFFFFFF,
        ), // Pure white for selected (maximum contrast)
        unselectedItemColor: Color(
          0xFFCCCCCC,
        ), // Bright gray for unselected (maximum contrast)
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),
      switchTheme: SwitchThemeData(
        thumbColor: MaterialStateProperty.all(const Color(0xFFFFD700)),
        trackColor: MaterialStateProperty.all(
          const Color(0xFF8B0000).withOpacity(0.4),
        ),
        trackOutlineColor: MaterialStateProperty.all(const Color(0xFF8B0000)),
      ),
      checkboxTheme: CheckboxThemeData(
        fillColor: MaterialStateProperty.all(const Color(0xFF8B0000)),
        checkColor: MaterialStateProperty.all(const Color(0xFFFFFFFF)),
        side: const BorderSide(color: Color(0xFFFFD700), width: 2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      ),
      radioTheme: RadioThemeData(
        fillColor: MaterialStateProperty.all(const Color(0xFF8B0000)),
        overlayColor: MaterialStateProperty.all(
          const Color(0xFFFFD700).withOpacity(0.2),
        ),
      ),
      sliderTheme: SliderThemeData(
        thumbColor: const Color(0xFFFFD700),
        activeTrackColor: const Color(0xFF8B0000),
        inactiveTrackColor: const Color(0xFF8B0000).withOpacity(0.3),
        overlayColor: const Color(0xFFFFD700).withOpacity(0.2),
        trackHeight: 4,
        thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8),
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: Color(0xFFFFD700),
        linearTrackColor: Color(0xFF8B0000),
      ),
      dividerTheme: const DividerThemeData(
        color: Color(0xFFFFD700),
        thickness: 1,
        space: 1,
      ),
      chipTheme: ChipThemeData(
        backgroundColor: const Color(0xFF1E1E1E),
        selectedColor: const Color(0xFF8B0000),
        disabledColor: const Color(0xFF8B0000).withOpacity(0.3),
        labelStyle: const TextStyle(color: Color(0xFFFFFFFF)),
        secondaryLabelStyle: const TextStyle(color: Color(0xFFFFFFFF)),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
    );
  }
}
