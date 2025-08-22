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

  /// Font family for the language
  final String fontFamily;

  const LanguageModel({
    required this.code,
    required this.name,
    required this.nativeName,
    required this.textDirection,
    required this.fontFamily,
  });

  /// Get the appropriate font family based on language code
  static String getFontFamilyForLanguage(String languageCode) {
    switch (languageCode.toLowerCase()) {
      case 'ar':
      case 'eg':
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
    return 'LanguageModel(code: $code, name: $name, nativeName: $nativeName, textDirection: $textDirection, fontFamily: $fontFamily)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is LanguageModel &&
        other.code == code &&
        other.name == name &&
        other.nativeName == nativeName &&
        other.textDirection == textDirection &&
        other.fontFamily == fontFamily;
  }

  @override
  int get hashCode {
    return code.hashCode ^
        name.hashCode ^
        nativeName.hashCode ^
        textDirection.hashCode ^
        fontFamily.hashCode;
  }
}
