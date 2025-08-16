import 'package:flutter/material.dart';

/// Model class representing a supported language
class LanguageModel {
  /// Language code (e.g., 'en', 'es', 'fr')
  final String code;

  /// Language name in English (e.g., 'English', 'Spanish', 'French')
  final String name;

  /// Native language name (e.g., 'English', 'Español', 'Français')
  final String nativeName;

  /// Text direction for the language
  final TextDirection textDirection;

  /// Primary font family for the language
  final String primaryFontFamily;

  /// Secondary font family for the language (alternative option)
  final String secondaryFontFamily;

  /// Available font families for this language
  final List<String> availableFontFamilies;

  const LanguageModel({
    required this.code,
    required this.name,
    required this.nativeName,
    required this.textDirection,
    required this.primaryFontFamily,
    required this.secondaryFontFamily,
    required this.availableFontFamilies,
  });

  /// Get the appropriate font family based on language code
  static String getFontFamilyForLanguage(String languageCode) {
    switch (languageCode.toLowerCase()) {
      case 'ar':
        return 'NotoSansArabic';
      case 'ja':
      case 'jp':
        return 'NotoSansJapanese';
      case 'en':
      case 'es':
      case 'fr':
      case 'de':
      default:
        return 'NotoSans';
    }
  }

  /// Get available font families for a language
  static List<String> getAvailableFontFamilies(String languageCode) {
    switch (languageCode.toLowerCase()) {
      case 'ar':
        return ['NotoSansArabic', 'NotoSans'];
      case 'ja':
      case 'jp':
        return ['NotoSansJapanese', 'NotoSans'];
      case 'en':
      case 'es':
      case 'fr':
      case 'de':
      default:
        return ['NotoSans', 'Roboto', 'Inter'];
    }
  }

  /// Get text style with language-appropriate font
  static TextStyle getTextStyleForLanguage(
    String languageCode, {
    double? fontSize,
    FontWeight? fontWeight,
    FontStyle? fontStyle,
    Color? color,
    double? height,
    TextDecoration? decoration,
    String? customFontFamily,
  }) {
    final fontFamily =
        customFontFamily ?? getFontFamilyForLanguage(languageCode);

    return TextStyle(
      fontFamily: fontFamily,
      fontSize: fontSize,
      fontWeight: fontWeight,
      fontStyle: fontStyle,
      color: color,
      height: height,
      decoration: decoration,
    );
  }

  @override
  String toString() {
    return 'LanguageModel(code: $code, name: $name, nativeName: $nativeName, textDirection: $textDirection, primaryFontFamily: $primaryFontFamily, secondaryFontFamily: $secondaryFontFamily)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is LanguageModel &&
        other.code == code &&
        other.name == name &&
        other.nativeName == nativeName &&
        other.textDirection == textDirection &&
        other.primaryFontFamily == primaryFontFamily &&
        other.secondaryFontFamily == secondaryFontFamily;
  }

  @override
  int get hashCode {
    return code.hashCode ^
        name.hashCode ^
        nativeName.hashCode ^
        textDirection.hashCode ^
        primaryFontFamily.hashCode ^
        secondaryFontFamily.hashCode;
  }
}
