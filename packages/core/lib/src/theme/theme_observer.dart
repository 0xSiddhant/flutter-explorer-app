import 'package:flutter/material.dart';
import 'theme_manager.dart';
import 'models/theme_info.dart';

/// Theme observer that implements ChangeNotifier for theme changes
class ThemeObserver extends ChangeNotifier {
  static final ThemeObserver _instance = ThemeObserver._internal();
  factory ThemeObserver() => _instance;
  ThemeObserver._internal();

  static ThemeObserver get instance => _instance;

  /// Get current theme manager
  ThemeManager get themeManager => ThemeManager.instance;

  /// Get current theme data
  ThemeData get currentTheme => themeManager.currentTheme;

  /// Get current selected theme ID
  String get selectedThemeId => themeManager.selectedThemeId;

  /// Get current selected theme info
  ThemeInfo? get selectedThemeInfo => themeManager.selectedThemeInfo;

  /// Get current dark mode state
  bool get isDarkMode => themeManager.isDarkMode;

  /// Get current text scale factor
  double get textScaleFactor => themeManager.textScaleFactor;

  /// Get available themes for UI components
  List<ThemeInfo> get availableThemes => themeManager.getAvailableThemesForUI();

  /// Get available themes for dropdowns
  List<MapEntry<String, String>> get availableThemesForDropdown =>
      themeManager.getAvailableThemesForDropdown();

  /// Initialize theme observer
  void initialize() {
    // Listen to theme manager changes
    themeManager.addListener(_onThemeChanged);
    debugPrint('ThemeObserver: Initialized');
  }

  /// Dispose theme observer
  @override
  void dispose() {
    themeManager.removeListener(_onThemeChanged);
    super.dispose();
  }

  /// Handle theme changes
  void _onThemeChanged() {
    debugPrint(
      'ThemeObserver: Theme changed - Theme: $selectedThemeId, Dark mode: $isDarkMode',
    );
    notifyListeners();
  }

  /// Set selected theme
  Future<void> setSelectedTheme(String themeId) async {
    await themeManager.setSelectedTheme(themeId);
  }

  /// Toggle dark mode
  void toggleDarkMode() {
    themeManager.toggleDarkMode();
  }

  /// Set dark mode
  Future<void> setDarkMode(bool value) async {
    await themeManager.setDarkMode(value);
  }

  /// Set text scale factor
  Future<void> setTextScaleFactor(double value) async {
    await themeManager.setTextScaleFactor(value);
  }

  /// Reset text scale factor
  Future<void> resetTextScaleFactor() async {
    await themeManager.resetTextScaleFactor();
  }

  /// Load theme settings from configuration
  Future<void> loadFromConfig() async {
    await themeManager.loadFromConfig();
  }

  /// Get theme data for preview
  ThemeData getThemeForPreview(String themeId, bool isDarkMode) {
    return themeManager.getThemeForPreview(themeId, isDarkMode);
  }

  /// Validate if a theme ID is valid
  bool isValidThemeId(String? themeId) {
    return themeManager.isValidThemeId(themeId);
  }

  /// Get a valid theme ID, defaulting to default if invalid
  String getValidThemeId(String? themeId) {
    return themeManager.getValidThemeId(themeId);
  }
}
