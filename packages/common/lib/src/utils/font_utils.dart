import 'package:flutter/material.dart';
import '../localization/app_localizations.dart';

/// Utility class for managing fonts across the application
/// Provides language-specific font families for better internationalization support
class FontUtils {
  FontUtils._();

  /// Default font family for the application
  static const String defaultFontFamily = 'NotoSans';

  /// Get the appropriate font family based on language code
  /// Returns language-specific fonts for better rendering
  /// @deprecated Use AppLocalizations.getFontFamilyForLanguage() instead
  static String getFontFamilyForLanguage(String languageCode) {
    return AppLocalizations.getFontFamilyForLanguage(languageCode);
  }

  /// Get text style with language-appropriate font family
  static TextStyle getTextStyleForLanguage(
    String languageCode, {
    double? fontSize,
    FontWeight? fontWeight,
    FontStyle? fontStyle,
    Color? color,
    double? height,
    TextDecoration? decoration,
  }) {
    return TextStyle(
      fontFamily: getFontFamilyForLanguage(languageCode),
      fontSize: fontSize,
      fontWeight: fontWeight,
      fontStyle: fontStyle,
      color: color,
      height: height,
      decoration: decoration,
    );
  }

  /// Get theme text style with language-appropriate font family
  static TextStyle getThemeTextStyleForLanguage(
    String languageCode,
    TextStyle baseStyle,
  ) {
    return baseStyle.copyWith(
      fontFamily: getFontFamilyForLanguage(languageCode),
    );
  }

  /// Create a theme with language-appropriate fonts
  static ThemeData createThemeWithLanguageFonts(
    ThemeData baseTheme,
    String languageCode,
  ) {
    final fontFamily = getFontFamilyForLanguage(languageCode);

    return baseTheme.copyWith(
      textTheme: baseTheme.textTheme.apply(fontFamily: fontFamily),
      primaryTextTheme: baseTheme.primaryTextTheme.apply(
        fontFamily: fontFamily,
      ),
    );
  }

  /// Get font weight constants for consistent usage
  static const FontWeight light = FontWeight.w300;
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;
  static const FontWeight extraBold = FontWeight.w800;

  /// Get font size constants for consistent usage
  static const double xs = 10.0;
  static const double sm = 12.0;
  static const double base = 14.0;
  static const double lg = 16.0;
  static const double xl = 18.0;
  static const double xxl = 20.0;
  static const double xxxl = 24.0;
  static const double display = 32.0;

  /// Predefined text styles for common use cases
  static TextStyle get heading1 => const TextStyle(
    fontSize: xxxl,
    fontWeight: bold,
    fontFamily: defaultFontFamily,
  );

  static TextStyle get heading2 => const TextStyle(
    fontSize: xxl,
    fontWeight: semiBold,
    fontFamily: defaultFontFamily,
  );

  static TextStyle get heading3 => const TextStyle(
    fontSize: xl,
    fontWeight: semiBold,
    fontFamily: defaultFontFamily,
  );

  static TextStyle get body1 => const TextStyle(
    fontSize: base,
    fontWeight: regular,
    fontFamily: defaultFontFamily,
  );

  static TextStyle get body2 => const TextStyle(
    fontSize: sm,
    fontWeight: regular,
    fontFamily: defaultFontFamily,
  );

  static TextStyle get caption => const TextStyle(
    fontSize: xs,
    fontWeight: regular,
    fontFamily: defaultFontFamily,
  );

  /// Get language-specific text styles
  static TextStyle getHeading1ForLanguage(String languageCode) =>
      getTextStyleForLanguage(languageCode, fontSize: xxxl, fontWeight: bold);

  static TextStyle getHeading2ForLanguage(String languageCode) =>
      getTextStyleForLanguage(
        languageCode,
        fontSize: xxl,
        fontWeight: semiBold,
      );

  static TextStyle getHeading3ForLanguage(String languageCode) =>
      getTextStyleForLanguage(languageCode, fontSize: xl, fontWeight: semiBold);

  static TextStyle getBody1ForLanguage(String languageCode) =>
      getTextStyleForLanguage(
        languageCode,
        fontSize: base,
        fontWeight: regular,
      );

  static TextStyle getBody2ForLanguage(String languageCode) =>
      getTextStyleForLanguage(languageCode, fontSize: sm, fontWeight: regular);

  static TextStyle getCaptionForLanguage(String languageCode) =>
      getTextStyleForLanguage(languageCode, fontSize: xs, fontWeight: regular);
}
