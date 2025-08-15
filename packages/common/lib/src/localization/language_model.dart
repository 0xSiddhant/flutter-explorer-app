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

  const LanguageModel({
    required this.code,
    required this.name,
    required this.nativeName,
    required this.textDirection,
  });

  @override
  String toString() {
    return 'LanguageModel(code: $code, name: $name, nativeName: $nativeName, textDirection: $textDirection)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is LanguageModel &&
        other.code == code &&
        other.name == name &&
        other.nativeName == nativeName &&
        other.textDirection == textDirection;
  }

  @override
  int get hashCode {
    return code.hashCode ^
        name.hashCode ^
        nativeName.hashCode ^
        textDirection.hashCode;
  }
}
