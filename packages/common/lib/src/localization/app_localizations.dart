import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'language_model.dart';

/// Central localization class for the application
class AppLocalizations {
  static const Locale _defaultLocale = Locale('en');

  /// Current locale
  static Locale _currentLocale = _defaultLocale;

  /// Current translations dictionary - loaded from JSON file
  static Map<String, String> _currentTranslations = {};

  /// Flag to track if translations are loaded
  static bool _isInitialized = false;

  /// List of supported languages using the new model
  static const List<LanguageModel> supportedLanguages = [
    LanguageModel(
      code: 'en',
      name: 'English',
      nativeName: 'English',
      textDirection: TextDirection.ltr,
    ),
    LanguageModel(
      code: 'es',
      name: 'Spanish',
      nativeName: 'Español',
      textDirection: TextDirection.ltr,
    ),
    LanguageModel(
      code: 'fr',
      name: 'French',
      nativeName: 'Français',
      textDirection: TextDirection.ltr,
    ),
    LanguageModel(
      code: 'de',
      name: 'German',
      nativeName: 'Deutsch',
      textDirection: TextDirection.ltr,
    ),
    LanguageModel(
      code: 'ar',
      name: 'Arabic',
      nativeName: 'العربية',
      textDirection: TextDirection.rtl,
    ),
    LanguageModel(
      code: 'ja',
      name: 'Japanese',
      nativeName: '日本語',
      textDirection: TextDirection.ltr,
    ),
  ];

  /// Get supported language codes
  static List<String> get supportedLanguageCodes {
    return supportedLanguages.map((lang) => lang.code).toList();
  }

  /// Get supported language names
  static List<String> get supportedLanguageNames {
    return supportedLanguages.map((lang) => lang.name).toList();
  }

  /// Get supported language native names
  static List<String> get supportedLanguageNativeNames {
    return supportedLanguages.map((lang) => lang.nativeName).toList();
  }

  /// Get current locale
  static Locale get currentLocale => _currentLocale;

  /// Get current language code
  static String get currentLanguageCode => _currentLocale.languageCode;

  /// Get current language model
  static LanguageModel? get currentLanguageModel =>
      getLanguageByCode(_currentLocale.languageCode);

  /// Get current language name
  static String get currentLanguageName {
    final model = currentLanguageModel;
    return model?.name ?? _currentLocale.languageCode;
  }

  /// Get current language native name
  static String get currentLanguageNativeName {
    final model = currentLanguageModel;
    return model?.nativeName ?? _currentLocale.languageCode;
  }

  /// Set current locale and reload translations
  static Future<void> setLocale(Locale locale) async {
    _currentLocale = locale;
    // Reload translations for the new locale
    await loadTranslations(locale);
  }

  /// Change language by language code
  static Future<void> changeLanguage(String languageCode) async {
    final locale = Locale(languageCode);
    await setLocale(locale);
  }

  /// Change language by language model
  static Future<void> changeLanguageByModel(LanguageModel language) async {
    final locale = Locale(language.code);
    await setLocale(locale);
  }

  /// Initialize the localization system
  static Future<void> initialize() async {
    // Load translations for the current locale
    await loadTranslations(_currentLocale);
  }

  /// Initialize the localization system with a specific default language
  static Future<void> initializeWithLanguage(String languageCode) async {
    _currentLocale = Locale(languageCode);
    await loadTranslations(_currentLocale);
  }

  /// Get text direction for current locale
  static TextDirection get textDirection {
    final language = supportedLanguages.firstWhere(
      (lang) => lang.code == _currentLocale.languageCode,
      orElse: () => supportedLanguages.first,
    );
    return language.textDirection;
  }

  /// Get text direction for a specific locale
  static TextDirection getTextDirectionForLocale(Locale locale) {
    final language = supportedLanguages.firstWhere(
      (lang) => lang.code == locale.languageCode,
      orElse: () => supportedLanguages.first,
    );
    return language.textDirection;
  }

  /// Load translations for a specific locale into the current translations dictionary
  static Future<void> loadTranslations(Locale locale) async {
    final languageCode = locale.languageCode;

    try {
      // Try different asset paths for different scenarios
      String jsonString;
      try {
        // When used as a package dependency
        jsonString = await rootBundle.loadString(
          'packages/common/assets/l10n/$languageCode.json',
        );
      } catch (e) {
        // When used directly in the project
        jsonString = await rootBundle.loadString(
          'assets/l10n/$languageCode.json',
        );
      }

      final Map<String, dynamic> translations = json.decode(jsonString);

      // Convert to string-only map for better performance
      _currentTranslations = translations.map(
        (key, value) => MapEntry(key, value.toString()),
      );
      _isInitialized = true;
    } catch (e) {
      // Fallback to English if the requested language file is not found
      if (languageCode != 'en') {
        await loadTranslations(const Locale('en'));
      } else {
        // If even English fails, create a minimal fallback
        _currentTranslations = {
          'app_title': 'Flutter Core Features Demo',
          'settings': 'Settings',
          'ok': 'OK',
          'cancel': 'Cancel',
        };
        _isInitialized = true;
        debugPrint(
          'Warning: Failed to load translations for $languageCode: $e',
        );
      }
    }
  }

  /// Get a localized string by key
  static String getString(String key, [Map<String, dynamic>? args]) {
    // If not initialized, try to load translations
    if (!_isInitialized) {
      loadTranslations(_currentLocale);
      // If still not initialized, return key as fallback
      if (!_isInitialized) {
        return key;
      }
    }

    // Get the translation from the current dictionary
    String value = _currentTranslations[key] ?? key;

    // Handle arguments if provided
    if (args != null) {
      args.forEach((argKey, argValue) {
        value = value.replaceAll('{$argKey}', argValue.toString());
      });
    }

    return value;
  }

  /// Get a localized string by key (backward compatibility)
  /// @deprecated Use getString(String key, [Map<String, dynamic>? args]) instead
  static String getStringWithLocale(String key, String locale) {
    return getString(key);
  }

  /// Format date according to current locale
  static String formatDate(DateTime date) {
    // This is a simplified implementation
    // In a real app, you might want to use intl package for proper formatting
    return '${date.day}/${date.month}/${date.year}';
  }

  /// Format time according to current locale
  static String formatTime(TimeOfDay time) {
    // This is a simplified implementation
    // In a real app, you might want to use intl package for proper formatting
    return '${time.hour}:${time.minute.toString().padLeft(2, '0')}';
  }

  /// Format number according to current locale
  static String formatNumber(num number) {
    // This is a simplified implementation
    // In a real app, you might want to use intl package for proper formatting
    return number.toString();
  }

  /// Format currency according to current locale
  static String formatCurrency(num amount, {String? currencyCode}) {
    // This is a simplified implementation
    // In a real app, you might want to use intl package for proper formatting
    final code = currencyCode ?? 'USD';
    return '$code ${amount.toStringAsFixed(2)}';
  }

  /// Get language model by code
  static LanguageModel? getLanguageByCode(String code) {
    try {
      return supportedLanguages.firstWhere((lang) => lang.code == code);
    } catch (e) {
      return null;
    }
  }

  /// Get language model by name
  static LanguageModel? getLanguageByName(String name) {
    try {
      return supportedLanguages.firstWhere((lang) => lang.name == name);
    } catch (e) {
      return null;
    }
  }

  /// Check if a language is RTL
  static bool isRTL(String languageCode) {
    final language = getLanguageByCode(languageCode);
    return language?.textDirection == TextDirection.rtl;
  }

  /// Check if current locale is RTL
  static bool get isCurrentLocaleRTL {
    return isRTL(_currentLocale.languageCode);
  }

  /// Check if a specific language is currently active
  static bool isLanguageActive(String languageCode) {
    return _currentLocale.languageCode == languageCode;
  }

  /// Get current translations dictionary (for debugging)
  static Map<String, String> get currentTranslations => _currentTranslations;

  /// Check if translations are initialized
  static bool get isInitialized => _isInitialized;
}
