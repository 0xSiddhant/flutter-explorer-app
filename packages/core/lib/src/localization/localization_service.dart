import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'models/language_model.dart';
import 'language_change_listener.dart';
import '../config/app_config_service.dart';

/// Service for managing app localization
class LocalizationService {
  static final LocalizationService _instance = LocalizationService._internal();
  factory LocalizationService() => _instance;
  LocalizationService._internal();

  // Current state
  Locale _currentLocale = const Locale('en');
  Map<String, String> _currentTranslations = {};
  bool _isInitialized = false;

  // Getters
  Locale get currentLocale => _currentLocale;
  Map<String, String> get currentTranslations => _currentTranslations;
  bool get isInitialized => _isInitialized;

  /// Initialize the localization system
  Future<void> initialize() async {
    await loadTranslations(_currentLocale);
  }

  /// Initialize with a specific language
  Future<void> initializeWithLanguage(String languageCode) async {
    await setLocale(Locale(languageCode));
  }

  /// Initialize from configuration
  Future<void> initializeFromConfig() async {
    try {
      final config = AppConfigService.instance.getAllConfig();
      if (config.isNotEmpty) {
        final languageCode =
            config['internationalization']?['defaultLanguage'] ?? 'en';
        debugPrint(
          'Initializing localization with language from config: $languageCode',
        );
        await initializeWithLanguage(languageCode);
      } else {
        debugPrint('Config not provided, using default initialization');
        await initialize();
      }
    } catch (e) {
      debugPrint('Error loading language from config, using default: $e');
      try {
        await initialize();
      } catch (fallbackError) {
        debugPrint(
          'Critical error: Default initialization also failed: $fallbackError',
        );
        rethrow;
      }
    }
  }

  /// Set current locale and reload translations
  Future<void> setLocale(Locale locale) async {
    _currentLocale = locale;
    await loadTranslations(locale);

    // Notify global listener about language change
    LanguageChangeListener.instance.updateLanguage(locale.languageCode);
  }

  /// Change language by language code
  Future<void> changeLanguage(String languageCode) async {
    final locale = Locale(languageCode);
    await setLocale(locale);
  }

  /// Change language by language model
  Future<void> changeLanguageByModel(LanguageModel language) async {
    final locale = Locale(language.code);
    await setLocale(locale);
  }

  /// Load translations for a specific locale
  Future<void> loadTranslations(Locale locale) async {
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
          // Initialization error handler strings
          'initialization_failed': 'Initialization Failed',
          'failed_to_initialize_service': 'Failed to initialize {serviceName}.',
          'error_label': 'Error: {error}',
          'initialization_error_message':
              'The app cannot start without this service. Please restart the app or contact support if the problem persists.',
        };
        _isInitialized = true;
        debugPrint(
          'Warning: Failed to load translations for $languageCode: $e',
        );
      }
    }
  }

  /// Get a localized string by key
  String getString(String key, [Map<String, dynamic>? args]) {
    // If not initialized, try to load translations
    if (!_isInitialized) {
      loadTranslations(_currentLocale);
      // If still not initialized, return key as fallback
      if (!_isInitialized) {
        return key;
      }
    }

    String translation = _currentTranslations[key] ?? key;

    // Replace placeholders with arguments
    if (args != null) {
      args.forEach((placeholder, value) {
        translation = translation.replaceAll(
          '{$placeholder}',
          value.toString(),
        );
      });
    }

    return translation;
  }

  /// Get current language code
  String get currentLanguageCode => _currentLocale.languageCode;
}
