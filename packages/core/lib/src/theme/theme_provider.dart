import 'package:flutter/material.dart';
import 'app_theme.dart';

/// Provider for managing application theme state
class ThemeProvider {
  static final ThemeProvider _instance = ThemeProvider._internal();
  factory ThemeProvider() => _instance;
  ThemeProvider._internal();

  static ThemeProvider get instance => _instance;

  bool _isDarkMode = false;
  bool _isHighContrast = false;
  double _textScaleFactor = 1.0;

  // Callback to notify when theme changes
  VoidCallback? _onThemeChanged;

  /// Current dark mode state
  bool get isDarkMode => _isDarkMode;

  /// Current high contrast state
  bool get isHighContrast => _isHighContrast;

  /// Current text scale factor
  double get textScaleFactor => _textScaleFactor;

  /// Current theme data based on settings
  ThemeData get currentTheme => AppTheme.getTheme(
    isDarkMode: _isDarkMode,
    isHighContrast: _isHighContrast,
  );

  /// Set callback for theme changes
  void setThemeChangedCallback(VoidCallback callback) {
    _onThemeChanged = callback;
  }

  /// Notify listeners of theme changes
  void _notifyThemeChanged() {
    _onThemeChanged?.call();
  }

  /// Toggle dark mode
  void toggleDarkMode() {
    _isDarkMode = !_isDarkMode;
    _notifyThemeChanged();
  }

  /// Set dark mode
  void setDarkMode(bool value) {
    _isDarkMode = value;
    _notifyThemeChanged();
  }

  /// Toggle high contrast
  void toggleHighContrast() {
    _isHighContrast = !_isHighContrast;
    _notifyThemeChanged();
  }

  /// Set high contrast
  void setHighContrast(bool value) {
    _isHighContrast = value;
    _notifyThemeChanged();
  }

  /// Set text scale factor
  void setTextScaleFactor(double value) {
    _textScaleFactor = value;
    _notifyThemeChanged();
  }

  /// Reset all theme settings to default
  void resetToDefault() {
    _isDarkMode = false;
    _isHighContrast = false;
    _textScaleFactor = 1.0;
    _notifyThemeChanged();
  }
}
