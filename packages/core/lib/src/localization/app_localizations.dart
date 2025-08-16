import 'package:flutter/material.dart';
import 'models/language_model.dart';
import 'localization_service.dart';

/// Central localization class for the application
/// This class contains all localization logic and delegates to LocalizationService
class AppLocalizations {
  // Language models - moved to core package
  static const List<LanguageModel> supportedLanguages = [
    LanguageModel(
      code: 'en',
      name: 'English',
      nativeName: 'English',
      textDirection: TextDirection.ltr,
      fontFamily: 'NotoSans',
    ),
    LanguageModel(
      code: 'es',
      name: 'Spanish',
      nativeName: 'Español',
      textDirection: TextDirection.ltr,
      fontFamily: 'NotoSans',
    ),
    LanguageModel(
      code: 'fr',
      name: 'French',
      nativeName: 'Français',
      textDirection: TextDirection.ltr,
      fontFamily: 'NotoSans',
    ),
    LanguageModel(
      code: 'de',
      name: 'German',
      nativeName: 'Deutsch',
      textDirection: TextDirection.ltr,
      fontFamily: 'NotoSans',
    ),
    LanguageModel(
      code: 'ar',
      name: 'Arabic',
      nativeName: 'العربية',
      textDirection: TextDirection.rtl,
      fontFamily: 'NotoSansArabic',
    ),
    LanguageModel(
      code: 'ja',
      name: 'Japanese',
      nativeName: '日本語',
      textDirection: TextDirection.ltr,
      fontFamily: 'NotoSansJapanese',
    ),
  ];

  // Delegate business logic to LocalizationService
  static final LocalizationService _service = LocalizationService();

  /// Get a localized string by key
  static String getString(String key, [Map<String, dynamic>? args]) {
    return _service.getString(key, args);
  }

  /// Get current language model
  static LanguageModel? get currentLanguageModel {
    return getLanguageByCode(currentLanguageCode);
  }

  /// Get language by code
  static LanguageModel? getLanguageByCode(String code) {
    try {
      return supportedLanguages.firstWhere((lang) => lang.code == code);
    } catch (e) {
      return null;
    }
  }

  /// Get text direction for current locale
  static TextDirection get textDirection {
    final language =
        getLanguageByCode(currentLanguageCode) ?? supportedLanguages.first;
    return language.textDirection;
  }

  /// Get text direction for a specific locale
  static TextDirection getTextDirectionForLocale(Locale locale) {
    final language =
        getLanguageByCode(locale.languageCode) ?? supportedLanguages.first;
    return language.textDirection;
  }

  /// Get current language code
  static String get currentLanguageCode {
    return _service.currentLanguageCode;
  }

  /// Get current language name
  static String get currentLanguageName {
    final model = currentLanguageModel;
    return model?.name ?? currentLanguageCode;
  }

  /// Get current language native name
  static String get currentLanguageNativeName {
    final model = currentLanguageModel;
    return model?.nativeName ?? currentLanguageCode;
  }

  /// Check if a language is active
  static bool isLanguageActive(String languageCode) {
    return currentLanguageCode == languageCode;
  }

  /// Initialize the localization system
  static Future<void> initialize() async {
    await _service.initialize();
  }

  /// Initialize with a specific language
  static Future<void> initializeWithLanguage(String languageCode) async {
    await _service.initializeWithLanguage(languageCode);
  }

  /// Initialize from configuration
  static Future<void> initializeFromConfig() async {
    await _service.initializeFromConfig();
  }

  /// Change language by language code
  static Future<void> changeLanguage(String languageCode) async {
    await _service.changeLanguage(languageCode);
  }

  /// Change language by language model
  static Future<void> changeLanguageByModel(LanguageModel language) async {
    await _service.changeLanguageByModel(language);
  }

  /// Set current locale and reload translations
  static Future<void> setLocale(Locale locale) async {
    await _service.setLocale(locale);
  }

  /// Get current locale
  static Locale get currentLocale {
    return _service.currentLocale;
  }

  /// Get current translations
  static Map<String, String> get currentTranslations {
    return _service.currentTranslations;
  }

  /// Check if initialized
  static bool get isInitialized {
    return _service.isInitialized;
  }

  // Additional methods for backward compatibility
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

  /// Get font family for a specific language
  static String getFontFamilyForLanguage(String languageCode) {
    return LanguageModel.getFontFamilyForLanguage(languageCode);
  }

  /// Get available font families for a specific language
  static List<String> getAvailableFontFamiliesForLanguage(String languageCode) {
    // Simplified implementation - return the primary font family
    return [getFontFamilyForLanguage(languageCode)];
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
    return LanguageModel.getTextStyleForLanguage(
      languageCode,
      fontSize: fontSize,
      fontWeight: fontWeight,
      fontStyle: fontStyle,
      color: color,
      height: height,
      decoration: decoration,
      customFontFamily: customFontFamily,
    );
  }

  /// Get text style with current language's font
  static TextStyle getTextStyleForCurrentLanguage({
    double? fontSize,
    FontWeight? fontWeight,
    FontStyle? fontStyle,
    Color? color,
    double? height,
    TextDecoration? decoration,
    String? customFontFamily,
  }) {
    return getTextStyleForLanguage(
      currentLanguageCode,
      fontSize: fontSize,
      fontWeight: fontWeight,
      fontStyle: fontStyle,
      color: color,
      height: height,
      decoration: decoration,
      customFontFamily: customFontFamily,
    );
  }
}
