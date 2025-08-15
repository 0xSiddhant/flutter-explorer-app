import 'package:core/core.dart';
import 'package:flutter/material.dart';
import '../models/settings_section_model.dart';

/// Data class for managing settings configuration
class SettingsData {
  /// Get all settings sections based on current configuration
  static List<SettingsSection> getSettingsSections({
    required Map<String, dynamic> config,
    required String selectedLanguage,
    required Map<String, dynamic>? appInfo,
    required Function(String, dynamic) onConfigUpdate,
    required Function(String) onLanguageChange,
    required VoidCallback onReloadConfig,
    required VoidCallback onResetConfig,
    required VoidCallback onViewConfig,
  }) {
    return [
      _buildLanguageSection(selectedLanguage, onLanguageChange),
      _buildAppearanceSection(config, onConfigUpdate),
      _buildAccessibilitySection(config, onConfigUpdate),
      _buildConfigurationSection(onReloadConfig, onResetConfig, onViewConfig),
      _buildAboutSection(appInfo),
    ];
  }

  /// Build language and region section
  static SettingsSection _buildLanguageSection(
    String selectedLanguage,
    Function(String) onLanguageChange,
  ) {
    return SettingsSection(
      title: 'Language & Region',
      icon: 'language',
      items: [
        SettingsItem(
          title: 'App Language',
          subtitle: 'Select your preferred language',
          icon: 'language',
          type: SettingsItemType.dropdown,
          value: selectedLanguage,
          onChanged: (value) => onLanguageChange(value.toString()),
          configKey: 'internationalization.defaultLanguage',
        ),
      ],
    );
  }

  /// Build appearance section
  static SettingsSection _buildAppearanceSection(
    Map<String, dynamic> config,
    Function(String, dynamic) onConfigUpdate,
  ) {
    return SettingsSection(
      title: 'Appearance',
      icon: 'palette',
      items: [
        SettingsItem(
          title: AppLocalizations.getString('dark_mode'),
          subtitle: AppLocalizations.getString(
            'switch_between_light_and_dark_themes',
          ),
          icon: config['theme']?['isDarkMode'] == true
              ? 'dark_mode'
              : 'light_mode',
          type: SettingsItemType.switch_,
          value: config['theme']?['isDarkMode'] ?? false,
          onChanged: (value) => onConfigUpdate('theme.isDarkMode', value),
          configKey: 'theme.isDarkMode',
        ),
        SettingsItem(
          title: AppLocalizations.getString('high_contrast'),
          subtitle: AppLocalizations.getString(
            'increase_contrast_for_better_visibility',
          ),
          icon: 'contrast',
          type: SettingsItemType.switch_,
          value: config['theme']?['isHighContrast'] ?? false,
          onChanged: (value) => onConfigUpdate('theme.isHighContrast', value),
          configKey: 'theme.isHighContrast',
        ),
        SettingsItem(
          title: AppLocalizations.getString('text_scale'),
          subtitle:
              '${AppLocalizations.getString('current_scale')} ${(config['theme']?['textScaleFactor'] ?? 1.0).toStringAsFixed(1)}x',
          icon: 'text_fields',
          type: SettingsItemType.slider,
          value: config['theme']?['textScaleFactor'] ?? 1.0,
          onChanged: (value) => onConfigUpdate('theme.textScaleFactor', value),
          configKey: 'theme.textScaleFactor',
        ),
      ],
    );
  }

  /// Build accessibility section
  static SettingsSection _buildAccessibilitySection(
    Map<String, dynamic> config,
    Function(String, dynamic) onConfigUpdate,
  ) {
    return SettingsSection(
      title: 'Accessibility',
      icon: 'accessibility',
      items: [
        SettingsItem(
          title: AppLocalizations.getString('screen_reader'),
          subtitle: AppLocalizations.getString('enable_voice_feedback'),
          type: SettingsItemType.switch_,
          value: config['accessibility']?['enableScreenReader'] ?? false,
          onChanged: (value) =>
              onConfigUpdate('accessibility.enableScreenReader', value),
          configKey: 'accessibility.enableScreenReader',
        ),
        SettingsItem(
          title: AppLocalizations.getString('high_contrast'),
          subtitle: AppLocalizations.getString(
            'increase_contrast_for_better_visibility',
          ),
          type: SettingsItemType.switch_,
          value: config['accessibility']?['enableHighContrast'] ?? false,
          onChanged: (value) =>
              onConfigUpdate('accessibility.enableHighContrast', value),
          configKey: 'accessibility.enableHighContrast',
        ),
        SettingsItem(
          title: AppLocalizations.getString('large_text'),
          subtitle: AppLocalizations.getString('increase_text_size'),
          type: SettingsItemType.switch_,
          value: config['accessibility']?['enableLargeText'] ?? false,
          onChanged: (value) =>
              onConfigUpdate('accessibility.enableLargeText', value),
          configKey: 'accessibility.enableLargeText',
        ),
        SettingsItem(
          title: AppLocalizations.getString('reduced_motion'),
          subtitle: AppLocalizations.getString('reduce_animations'),
          type: SettingsItemType.switch_,
          value: config['accessibility']?['enableReducedMotion'] ?? false,
          onChanged: (value) =>
              onConfigUpdate('accessibility.enableReducedMotion', value),
          configKey: 'accessibility.enableReducedMotion',
        ),
      ],
    );
  }

  /// Build configuration section
  static SettingsSection _buildConfigurationSection(
    VoidCallback onReloadConfig,
    VoidCallback onResetConfig,
    VoidCallback onViewConfig,
  ) {
    return SettingsSection(
      title: 'Configuration',
      icon: 'settings',
      items: [
        SettingsItem(
          title: 'Configuration Viewer',
          subtitle: 'View raw JSON configuration file',
          icon: 'code',
          type: SettingsItemType.button,
          onChanged: (_) => onViewConfig(),
        ),
        SettingsItem(
          title: 'Reload Configuration',
          subtitle: 'Refresh configuration from file',
          icon: 'refresh',
          type: SettingsItemType.button,
          onChanged: (_) => onReloadConfig(),
        ),
        SettingsItem(
          title: 'Reset to Default',
          subtitle: 'Reset all settings to default values',
          icon: 'restore',
          type: SettingsItemType.button,
          onChanged: (_) => onResetConfig(),
        ),
      ],
    );
  }

  /// Build about section
  static SettingsSection _buildAboutSection(Map<String, dynamic>? appInfo) {
    final items = <SettingsItem>[];

    if (appInfo != null) {
      items.addAll([
        SettingsItem(
          title: 'Name',
          type: SettingsItemType.info,
          value: appInfo['name'] ?? 'Unknown',
        ),
        SettingsItem(
          title: 'Version',
          type: SettingsItemType.info,
          value: appInfo['version'] ?? 'Unknown',
        ),
        SettingsItem(
          title: 'Build Number',
          type: SettingsItemType.info,
          value: appInfo['buildNumber'] ?? 'Unknown',
        ),
        SettingsItem(
          title: 'Environment',
          type: SettingsItemType.info,
          value: appInfo['environment'] ?? 'Unknown',
        ),
      ]);
    } else {
      items.addAll([
        SettingsItem(
          title: 'Name',
          type: SettingsItemType.info,
          value: 'Flutter Explorer',
        ),
        SettingsItem(
          title: 'Version',
          type: SettingsItemType.info,
          value: '1.0.0',
        ),
        SettingsItem(
          title: 'Build Number',
          type: SettingsItemType.info,
          value: '1',
        ),
        SettingsItem(
          title: 'Environment',
          type: SettingsItemType.info,
          value: 'development',
        ),
      ]);
    }

    return SettingsSection(title: 'About', icon: 'info', items: items);
  }
}
