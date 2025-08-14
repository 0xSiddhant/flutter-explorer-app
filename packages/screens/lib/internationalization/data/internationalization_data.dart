import 'package:flutter/material.dart';
import 'package:common/common.dart';
import '../models/language_model.dart';
import '../models/formatting_example_model.dart';

/// Data provider for internationalization screen
class InternationalizationData {
  static String _currentLanguage = 'en';
  static bool _isRTLEnabled = false;

  /// Get current language code
  static String get currentLanguage => _currentLanguage;

  /// Get current language model
  static LanguageModel? get currentLanguageModel =>
      LanguageModel.getByCode(_currentLanguage);

  /// Get RTL status
  static bool get isRTLEnabled => _isRTLEnabled;

  /// Set current language
  static void setLanguage(String languageCode) {
    _currentLanguage = languageCode;
    final language = LanguageModel.getByCode(languageCode);
    if (language != null) {
      _isRTLEnabled = language.isRTL;
    }
  }

  /// Toggle RTL mode
  static void toggleRTL() {
    _isRTLEnabled = !_isRTLEnabled;
  }

  /// Set RTL mode
  static void setRTL(bool enabled) {
    _isRTLEnabled = enabled;
  }

  /// Get all supported languages
  static List<LanguageModel> get supportedLanguages =>
      LanguageModel.supportedLanguages;

  /// Get formatting data for current language
  static FormattingDataModel getFormattingData() {
    return FormattingDataModel.forLanguage(_currentLanguage);
  }

  /// Get welcome message for current language
  static String getWelcomeMessage() {
    return AppLocalizations.getString('app_title', _currentLanguage);
  }

  /// Get description for current language
  static String getDescription() {
    return AppLocalizations.getString(
      'internationalization_description',
      _currentLanguage,
    );
  }

  /// Get feature list for current language
  static List<Map<String, dynamic>> getFeatureList() {
    return [
      {
        'title': AppLocalizations.getString('navigation', _currentLanguage),
        'icon': Icons.navigation,
        'route': '/navigation',
      },
      {
        'title': AppLocalizations.getString('theming', _currentLanguage),
        'icon': Icons.palette,
        'route': '/theming',
      },
      {
        'title': AppLocalizations.getString(
          'native_communication',
          _currentLanguage,
        ),
        'icon': Icons.phone_android,
        'route': '/native-communication',
      },
      {
        'title': AppLocalizations.getString(
          'background_tasks',
          _currentLanguage,
        ),
        'icon': Icons.sync,
        'route': '/background-tasks',
      },
      {
        'title': AppLocalizations.getString('accessibility', _currentLanguage),
        'icon': Icons.accessibility,
        'route': '/accessibility',
      },
      {
        'title': AppLocalizations.getString(
          'file_management',
          _currentLanguage,
        ),
        'icon': Icons.folder,
        'route': '/file-management',
      },
    ];
  }
}
