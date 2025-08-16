import 'package:core/core.dart';
import 'package:flutter/material.dart';
import '../models/formatting_example_model.dart';

/// Data provider for internationalization screen
class InternationalizationData {
  static String _currentLanguage = 'en';
  static bool _isRTLEnabled = false;

  /// Get current language code
  static String get currentLanguage => _currentLanguage;

  /// Get current language model
  static LanguageModel? get currentLanguageModel =>
      AppLocalizations.getLanguageByCode(_currentLanguage);

  /// Get RTL status
  static bool get isRTLEnabled => _isRTLEnabled;

  /// Set current language
  static void setLanguage(String languageCode) {
    _currentLanguage = languageCode;
    final language = AppLocalizations.getLanguageByCode(languageCode);
    if (language != null) {
      _isRTLEnabled = language.textDirection == TextDirection.rtl;
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
      AppLocalizations.supportedLanguages;

  /// Get formatting data for current language
  static FormattingDataModel getFormattingData() {
    return FormattingDataModel.forLanguage(_currentLanguage);
  }

  /// Get welcome message for current language
  static String getWelcomeMessage() {
    return AppLocalizations.getString('app_title');
  }

  /// Get description for current language
  static String getDescription() {
    return AppLocalizations.getString('internationalization_description');
  }

  /// Get feature list for current language
  static List<Map<String, dynamic>> getFeatureList() {
    return [
      {
        'title': AppLocalizations.getString('navigation'),
        'icon': Icons.navigation,
        'route': '/navigation',
      },
      {
        'title': AppLocalizations.getString('theming'),
        'icon': Icons.palette,
        'route': '/theming',
      },
      {
        'title': AppLocalizations.getString('native_communication'),
        'icon': Icons.phone_android,
        'route': '/native-communication',
      },
      {
        'title': AppLocalizations.getString('background_tasks'),
        'icon': Icons.sync,
        'route': '/background-tasks',
      },
      {
        'title': AppLocalizations.getString('accessibility'),
        'icon': Icons.accessibility,
        'route': '/accessibility',
      },
      {
        'title': AppLocalizations.getString('file_management'),
        'icon': Icons.folder,
        'route': '/file-management',
      },
    ];
  }
}
