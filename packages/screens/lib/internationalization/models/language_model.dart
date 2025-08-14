/// Model representing a language option
class LanguageModel {
  final String code;
  final String name;
  final String nativeName;
  final bool isRTL;
  final String flag;

  const LanguageModel({
    required this.code,
    required this.name,
    required this.nativeName,
    required this.isRTL,
    required this.flag,
  });

  /// Get all supported languages
  static List<LanguageModel> get supportedLanguages => [
    const LanguageModel(
      code: 'en',
      name: 'English',
      nativeName: 'English',
      isRTL: false,
      flag: '🇺🇸',
    ),
    const LanguageModel(
      code: 'es',
      name: 'Spanish',
      nativeName: 'Español',
      isRTL: false,
      flag: '🇪🇸',
    ),
    const LanguageModel(
      code: 'fr',
      name: 'French',
      nativeName: 'Français',
      isRTL: false,
      flag: '🇫🇷',
    ),
    const LanguageModel(
      code: 'de',
      name: 'German',
      nativeName: 'Deutsch',
      isRTL: false,
      flag: '🇩🇪',
    ),
    const LanguageModel(
      code: 'ar',
      name: 'Arabic',
      nativeName: 'العربية',
      isRTL: true,
      flag: '🇸🇦',
    ),
    const LanguageModel(
      code: 'ja',
      name: 'Japanese',
      nativeName: '日本語',
      isRTL: false,
      flag: '🇯🇵',
    ),
  ];

  /// Get language by code
  static LanguageModel? getByCode(String code) {
    try {
      return supportedLanguages.firstWhere((lang) => lang.code == code);
    } catch (e) {
      return null;
    }
  }
}
