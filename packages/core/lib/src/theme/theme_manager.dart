import 'package:flutter/material.dart';
import '../config/app_config_service.dart';
import '../config/config_change_listener.dart';
import 'color_palette/harry_potter_theme.dart';
import 'color_palette/dark_blue_theme.dart';

/// Theme manager responsible for selecting and managing themes
class ThemeManager extends ChangeNotifier {
  static final ThemeManager _instance = ThemeManager._internal();
  factory ThemeManager() => _instance;
  ThemeManager._internal();

  static ThemeManager get instance => _instance;

  String _selectedThemeId = defaultThemeId;
  bool _isDarkMode = false;
  double _textScaleFactor = 1.0;

  /// Available themes
  static const Map<String, String> availableThemes = {
    'harry_potter': 'Harry Potter Magical',
    'dark_blue': 'Dark Blue',
  };

  /// Get theme ID constants
  static const String harryPotterThemeId = 'harry_potter';
  static const String darkBlueThemeId = 'dark_blue';
  static const String defaultThemeId = harryPotterThemeId;

  /// Get theme name constants
  static const String harryPotterThemeName = 'Harry Potter Magical';
  static const String darkBlueThemeName = 'Dark Blue';

  /// Current selected theme ID
  String get selectedThemeId => _selectedThemeId;

  /// Current selected theme name
  String get selectedThemeName =>
      availableThemes[_selectedThemeId] ?? 'Harry Potter Magical';

  /// Current dark mode state
  bool get isDarkMode => _isDarkMode;

  /// Current text scale factor
  double get textScaleFactor => _textScaleFactor;

  /// Get current theme data based on selected theme and mode
  ThemeData get currentTheme {
    final theme = _getThemeData(_selectedThemeId, _isDarkMode);
    debugPrint(
      'ThemeManager: Current theme - Theme: $_selectedThemeId, Dark mode: $_isDarkMode, Brightness: ${theme.brightness}',
    );
    return theme;
  }

  /// Get theme data for a specific theme and mode
  ThemeData _getThemeData(String themeId, bool isDarkMode) {
    switch (themeId) {
      case harryPotterThemeId:
        return isDarkMode
            ? HarryPotterTheme.darkTheme
            : HarryPotterTheme.lightTheme;
      case darkBlueThemeId:
        return isDarkMode ? DarkBlueTheme.darkTheme : DarkBlueTheme.lightTheme;
      default:
        return isDarkMode
            ? HarryPotterTheme.darkTheme
            : HarryPotterTheme.lightTheme;
    }
  }

  /// Get theme data for preview (without changing current theme)
  ThemeData getThemeForPreview(String themeId, bool isDarkMode) {
    return _getThemeData(themeId, isDarkMode);
  }

  /// Set selected theme
  Future<void> setSelectedTheme(String themeId) async {
    if (!availableThemes.containsKey(themeId)) {
      debugPrint('ThemeManager: Invalid theme ID: $themeId');
      return;
    }

    debugPrint('ThemeManager: Setting theme to $themeId');
    _selectedThemeId = themeId;
    _notifyThemeChanged();

    // Update configuration service
    try {
      await AppConfigService.instance.setValue(
        'theme.selectedThemeId',
        themeId,
      );
      debugPrint('ThemeManager: Theme config updated successfully');
    } catch (e) {
      debugPrint('ThemeManager: Error updating theme config: $e');
    }
  }

  /// Toggle dark mode
  void toggleDarkMode() {
    setDarkMode(!_isDarkMode);
  }

  /// Set dark mode
  Future<void> setDarkMode(bool value) async {
    debugPrint('ThemeManager: Setting dark mode to $value');
    _isDarkMode = value;
    _notifyThemeChanged();

    // Update configuration service
    try {
      await AppConfigService.instance.setValue('theme.isDarkMode', value);
      debugPrint('ThemeManager: Dark mode config updated successfully');
    } catch (e) {
      debugPrint('ThemeManager: Error updating dark mode config: $e');
    }
  }

  /// Set text scale factor
  Future<void> setTextScaleFactor(double value) async {
    _textScaleFactor = value;
    _notifyThemeChanged();

    // Update configuration service
    try {
      await AppConfigService.instance.setValue('theme.textScaleFactor', value);
    } catch (e) {
      debugPrint('ThemeManager: Error updating text scale config: $e');
    }
  }

  /// Reset text scale factor to default (1.0)
  Future<void> resetTextScaleFactor() async {
    await setTextScaleFactor(1.0);
  }

  /// Load theme settings from configuration
  Future<void> loadFromConfig() async {
    try {
      final config = AppConfigService.instance.getAllConfig();

      // Load selected theme
      final themeId =
          config['theme']?['selectedThemeId'] as String? ?? 'harry_potter';
      if (availableThemes.containsKey(themeId)) {
        _selectedThemeId = themeId;
      }

      // Load dark mode
      _isDarkMode = config['theme']?['isDarkMode'] as bool? ?? false;

      // Load text scale factor
      _textScaleFactor =
          (config['theme']?['textScaleFactor'] as num?)?.toDouble() ?? 1.0;

      debugPrint(
        'ThemeManager: Loaded from config - Theme: $_selectedThemeId, Dark mode: $_isDarkMode, Text scale: $_textScaleFactor',
      );
      _notifyThemeChanged();
    } catch (e) {
      debugPrint('ThemeManager: Error loading from config: $e');
    }
  }

  /// Notify listeners of theme changes
  void _notifyThemeChanged() {
    notifyListeners();
    // Also notify config change listeners for UI updates
    ConfigChangeListener.instance.notifyConfigChanged();
  }

  /// Get all available themes as a list
  static List<MapEntry<String, String>> getAvailableThemes() {
    return availableThemes.entries.toList();
  }
}
