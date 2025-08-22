import 'package:core/core.dart';
import 'package:flutter/foundation.dart';
import '../models/theme_control_model.dart';

class ThemeDataService {
  static ThemeControlModel getCurrentTheme() {
    final themeManager = ThemeManager.instance;
    final accessibilityProvider = AccessibilityProvider.instance;

    return ThemeControlModel(
      isDarkMode: themeManager.isDarkMode,
      isHighContrast: accessibilityProvider.isHighContrastEnabled,
      textScaleFactor: themeManager.textScaleFactor,
    );
  }

  static void applyTheme(ThemeControlModel theme) {
    debugPrint('🎨 ThemeData: Applying theme changes permanently');

    // Apply to global theme manager
    ThemeManager.instance.setDarkMode(theme.isDarkMode);
    AccessibilityProvider.instance.setHighContrastEnabled(theme.isHighContrast);
    ThemeManager.instance.setTextScaleFactor(theme.textScaleFactor);

    // Save to configuration
    AppConfigService.instance.setValue('theme.isDarkMode', theme.isDarkMode);
    AppConfigService.instance.setValue(
      'accessibility.enableHighContrast',
      theme.isHighContrast,
    );
    AppConfigService.instance.setValue(
      'theme.textScaleFactor',
      theme.textScaleFactor,
    );

    // Notify config change listeners
    ConfigChangeListener.instance.notifyConfigChanged();
  }
}
