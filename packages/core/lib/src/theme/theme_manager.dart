import 'package:flutter/material.dart';
import '../config/app_config_service.dart';
import '../config/config_change_listener.dart';
import 'color_palette/color_palette.dart';
import 'models/theme_info.dart';
import 'theme_observer.dart';

/// Theme manager responsible for selecting and managing themes
class ThemeManager {
  static final ThemeManager _instance = ThemeManager._internal();
  factory ThemeManager() => _instance;
  ThemeManager._internal() {
    _registerDefaultThemes();
  }

  static ThemeManager get instance => _instance;

  String _selectedThemeId = 'harry_potter';
  bool _isDarkMode = false;
  double _textScaleFactor = 1.0;

  // Dynamic theme registry
  final Map<String, ThemeInfo> _themeRegistry = {};
  final Map<String, ThemeData Function(bool)> _themeDataProviders = {};

  /// Register a theme with the manager
  void registerTheme(
    ThemeInfo themeInfo,
    ThemeData Function(bool) themeDataProvider,
  ) {
    _themeRegistry[themeInfo.id] = themeInfo;
    _themeDataProviders[themeInfo.id] = themeDataProvider;
  }

  /// Register default themes
  void _registerDefaultThemes() {
    // Harry Potter Theme
    registerTheme(
      const ThemeInfo(
        id: 'harry_potter',
        name: 'Harry Potter Magical',
        localizationKey: 'harry_potter_theme',
        description: 'Magical theme inspired by Harry Potter',
      ),
      (isDarkMode) =>
          isDarkMode ? HarryPotterTheme.darkTheme : HarryPotterTheme.lightTheme,
    );

    // Dark Blue Theme
    registerTheme(
      const ThemeInfo(
        id: 'dark_blue',
        name: 'Dark Blue',
        localizationKey: 'dark_blue_theme',
        description: 'Professional dark blue theme',
      ),
      (isDarkMode) =>
          isDarkMode ? DarkBlueTheme.darkTheme : DarkBlueTheme.lightTheme,
    );

    // One Piece Theme
    registerTheme(
      const ThemeInfo(
        id: 'one_piece',
        name: 'One Piece Adventure',
        localizationKey: 'one_piece_theme',
        description: 'Adventure theme inspired by One Piece',
      ),
      (isDarkMode) =>
          isDarkMode ? OnePieceTheme.darkTheme : OnePieceTheme.lightTheme,
    );

    // Studio Ghibli Theme
    registerTheme(
      const ThemeInfo(
        id: 'studio_ghibli',
        name: 'Studio Ghibli',
        localizationKey: 'studio_ghibli_theme',
        description:
            'Nature-inspired theme with forest greens and twinkling skies',
      ),
      (isDarkMode) => isDarkMode
          ? StudioGhibliTheme.darkTheme
          : StudioGhibliTheme.lightTheme,
    );
  }

  /// Get all available themes
  List<ThemeInfo> get availableThemes => _themeRegistry.values.toList();

  /// Get theme info by ID
  ThemeInfo? getThemeInfo(String themeId) => _themeRegistry[themeId];

  /// Get default theme ID
  String get defaultThemeId => 'harry_potter';

  /// Current selected theme ID
  String get selectedThemeId => _selectedThemeId;

  /// Current selected theme info
  ThemeInfo? get selectedThemeInfo => _themeRegistry[_selectedThemeId];

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
    final provider = _themeDataProviders[themeId];
    if (provider != null) {
      return provider(isDarkMode);
    }

    // Fallback to default theme
    debugPrint(
      'ThemeManager: Theme provider not found for $themeId, using default',
    );
    final defaultProvider = _themeDataProviders[defaultThemeId];
    return defaultProvider?.call(isDarkMode) ?? ThemeData.light();
  }

  /// Get theme data for preview (without changing current theme)
  ThemeData getThemeForPreview(String themeId, bool isDarkMode) {
    return _getThemeData(themeId, isDarkMode);
  }

  /// Set selected theme
  Future<void> setSelectedTheme(String themeId) async {
    final validThemeId = getValidThemeId(themeId);

    if (validThemeId != themeId) {
      debugPrint(
        'ThemeManager: Invalid theme ID: $themeId, using default: $validThemeId',
      );
    }

    debugPrint('ThemeManager: Setting theme to $validThemeId');
    _selectedThemeId = validThemeId;
    _notifyThemeChanged();

    // Update configuration service
    try {
      await AppConfigService.instance.setValue(
        'theme.selectedThemeId',
        validThemeId,
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
      final themeId = config['theme']?['selectedThemeId'] as String?;
      _selectedThemeId = getValidThemeId(themeId);

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
    // Notify theme observer for UI updates
    ThemeObserver.instance.onThemeChanged();
    // Also notify config change listeners for UI updates
    ConfigChangeListener.instance.notifyConfigChanged();
  }

  /// Validate if a theme ID is valid
  bool isValidThemeId(String? themeId) {
    if (themeId == null) return false;
    return _themeRegistry.containsKey(themeId);
  }

  /// Get a valid theme ID, defaulting to default if invalid
  String getValidThemeId(String? themeId) {
    if (isValidThemeId(themeId)) {
      return themeId!;
    }
    return defaultThemeId;
  }

  /// Get all available themes as a list for dropdowns
  List<MapEntry<String, String>> getAvailableThemesForDropdown() {
    return _themeRegistry.entries
        .map((entry) => MapEntry(entry.key, entry.value.name))
        .toList();
  }

  /// Get all available theme info for UI components
  List<ThemeInfo> getAvailableThemesForUI() {
    return _themeRegistry.values.toList();
  }
}
