import 'package:flutter/material.dart';

/// Global listener for language changes
class LanguageChangeListener extends ChangeNotifier {
  static final LanguageChangeListener _instance =
      LanguageChangeListener._internal();

  factory LanguageChangeListener() {
    return _instance;
  }

  LanguageChangeListener._internal();

  /// Current language code
  String _currentLanguage = 'en';

  /// Get current language code
  String get currentLanguage => _currentLanguage;

  /// Update language and notify all listeners
  void updateLanguage(String languageCode) {
    if (_currentLanguage != languageCode) {
      _currentLanguage = languageCode;
      notifyListeners();
    }
  }

  /// Get singleton instance
  static LanguageChangeListener get instance => _instance;
}
