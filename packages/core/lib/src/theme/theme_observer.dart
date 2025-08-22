import 'package:flutter/material.dart';
import 'theme_manager.dart';

/// Theme observer that implements ChangeNotifier for theme changes
/// This class only handles theme change subscriptions and delegates all other
/// functionality to ThemeManager
class ThemeObserver extends ChangeNotifier {
  static final ThemeObserver _instance = ThemeObserver._internal();
  factory ThemeObserver() => _instance;
  ThemeObserver._internal();

  static ThemeObserver get instance => _instance;

  /// Get current theme manager
  ThemeManager get themeManager => ThemeManager.instance;

  /// Dispose theme observer
  @override
  void dispose() {
    super.dispose();
  }

  /// Handle theme changes from ThemeManager
  void onThemeChanged() {
    debugPrint('ThemeObserver: Theme changed, notifying listeners');
    notifyListeners();
  }
}
