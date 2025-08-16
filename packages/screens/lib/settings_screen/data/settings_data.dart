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
      _buildFeatureTogglesSection(config, onConfigUpdate),
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
      title: AppLocalizations.getString('language_and_region'),
      icon: 'language',
      items: [
        SettingsItem(
          title: AppLocalizations.getString('app_language'),
          subtitle: AppLocalizations.getString('select_preferred_language'),
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
      title: AppLocalizations.getString('appearance'),
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
      title: AppLocalizations.getString('accessibility'),
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
        SettingsItem(
          title: AppLocalizations.getString('color_blind_support'),
          subtitle: AppLocalizations.getString('color_blind_friendly_palette'),
          type: SettingsItemType.switch_,
          value: config['accessibility']?['enableColorBlindSupport'] ?? false,
          onChanged: (value) =>
              onConfigUpdate('accessibility.enableColorBlindSupport', value),
          configKey: 'accessibility.enableColorBlindSupport',
        ),
        SettingsItem(
          title: AppLocalizations.getString('large_touch_targets'),
          subtitle: AppLocalizations.getString('increase_touch_area'),
          type: SettingsItemType.switch_,
          value: config['accessibility']?['enableLargeTouchTargets'] ?? false,
          onChanged: (value) =>
              onConfigUpdate('accessibility.enableLargeTouchTargets', value),
          configKey: 'accessibility.enableLargeTouchTargets',
        ),
        SettingsItem(
          title: AppLocalizations.getString('haptic_feedback'),
          subtitle: AppLocalizations.getString('vibration_feedback'),
          type: SettingsItemType.switch_,
          value: config['accessibility']?['enableHapticFeedback'] ?? false,
          onChanged: (value) =>
              onConfigUpdate('accessibility.enableHapticFeedback', value),
          configKey: 'accessibility.enableHapticFeedback',
        ),
        SettingsItem(
          title: AppLocalizations.getString('simplified_ui'),
          subtitle: AppLocalizations.getString('reduce_visual_complexity'),
          type: SettingsItemType.switch_,
          value: config['accessibility']?['enableSimplifiedUI'] ?? false,
          onChanged: (value) =>
              onConfigUpdate('accessibility.enableSimplifiedUI', value),
          configKey: 'accessibility.enableSimplifiedUI',
        ),
        SettingsItem(
          title: AppLocalizations.getString('enhanced_focus'),
          subtitle: AppLocalizations.getString('improved_focus_indicators'),
          type: SettingsItemType.switch_,
          value: config['accessibility']?['enableEnhancedFocus'] ?? false,
          onChanged: (value) =>
              onConfigUpdate('accessibility.enableEnhancedFocus', value),
          configKey: 'accessibility.enableEnhancedFocus',
        ),
      ],
    );
  }

  /// Build feature toggles section
  static SettingsSection _buildFeatureTogglesSection(
    Map<String, dynamic> config,
    Function(String, dynamic) onConfigUpdate,
  ) {
    final features = config['features'] as Map<String, dynamic>? ?? {};

    return SettingsSection(
      title: AppLocalizations.getString('feature_toggles'),
      icon: 'featured_play_list',
      items: [
        SettingsItem(
          title: AppLocalizations.getString('navigation'),
          subtitle: AppLocalizations.getString('route_management'),
          icon: 'navigation',
          type: SettingsItemType.switch_,
          value: features['enableNavigation'] ?? true,
          onChanged: (value) =>
              onConfigUpdate('features.enableNavigation', value),
          configKey: 'features.enableNavigation',
        ),
        SettingsItem(
          title: AppLocalizations.getString('theming'),
          subtitle: AppLocalizations.getString('dynamic_themes'),
          icon: 'palette',
          type: SettingsItemType.switch_,
          value: features['enableTheming'] ?? true,
          onChanged: (value) => onConfigUpdate('features.enableTheming', value),
          configKey: 'features.enableTheming',
        ),
        SettingsItem(
          title: AppLocalizations.getString('native_communication'),
          subtitle: AppLocalizations.getString('platform_integration'),
          icon: 'phone_android',
          type: SettingsItemType.switch_,
          value: features['enableNativeCommunication'] ?? true,
          onChanged: (value) =>
              onConfigUpdate('features.enableNativeCommunication', value),
          configKey: 'features.enableNativeCommunication',
        ),
        SettingsItem(
          title: AppLocalizations.getString('background_tasks'),
          subtitle: AppLocalizations.getString('isolate_processing'),
          icon: 'sync',
          type: SettingsItemType.switch_,
          value: features['enableBackgroundTasks'] ?? true,
          onChanged: (value) =>
              onConfigUpdate('features.enableBackgroundTasks', value),
          configKey: 'features.enableBackgroundTasks',
        ),
        SettingsItem(
          title: AppLocalizations.getString('internationalization'),
          subtitle: AppLocalizations.getString('multi_language_support'),
          icon: 'language',
          type: SettingsItemType.switch_,
          value: features['enableInternationalization'] ?? true,
          onChanged: (value) =>
              onConfigUpdate('features.enableInternationalization', value),
          configKey: 'features.enableInternationalization',
        ),
        SettingsItem(
          title: AppLocalizations.getString('accessibility'),
          subtitle: AppLocalizations.getString('semantic_ui'),
          icon: 'accessibility',
          type: SettingsItemType.switch_,
          value: features['enableAccessibility'] ?? true,
          onChanged: (value) =>
              onConfigUpdate('features.enableAccessibility', value),
          configKey: 'features.enableAccessibility',
        ),
        SettingsItem(
          title: AppLocalizations.getString('file_management'),
          subtitle: AppLocalizations.getString('local_storage'),
          icon: 'folder',
          type: SettingsItemType.switch_,
          value: features['enableFileManagement'] ?? true,
          onChanged: (value) =>
              onConfigUpdate('features.enableFileManagement', value),
          configKey: 'features.enableFileManagement',
        ),
        SettingsItem(
          title: AppLocalizations.getString('advanced_processing'),
          subtitle: AppLocalizations.getString('complex_operations'),
          icon: 'science',
          type: SettingsItemType.switch_,
          value: features['enableAdvancedProcessing'] ?? true,
          onChanged: (value) =>
              onConfigUpdate('features.enableAdvancedProcessing', value),
          configKey: 'features.enableAdvancedProcessing',
        ),
        SettingsItem(
          title: AppLocalizations.getString('navigation_analytics'),
          subtitle: AppLocalizations.getString('route_tracking'),
          icon: 'analytics',
          type: SettingsItemType.switch_,
          value: features['enableNavigationAnalytics'] ?? true,
          onChanged: (value) =>
              onConfigUpdate('features.enableNavigationAnalytics', value),
          configKey: 'features.enableNavigationAnalytics',
        ),
        SettingsItem(
          title: AppLocalizations.getString('lifecycle_management'),
          subtitle: AppLocalizations.getString('widget_states'),
          icon: 'auto_awesome',
          type: SettingsItemType.switch_,
          value: features['enableLifecycleManagement'] ?? true,
          onChanged: (value) =>
              onConfigUpdate('features.enableLifecycleManagement', value),
          configKey: 'features.enableLifecycleManagement',
        ),
        SettingsItem(
          title: AppLocalizations.getString('typography_showcase'),
          subtitle: AppLocalizations.getString('font_rendering'),
          icon: 'text_fields',
          type: SettingsItemType.switch_,
          value: features['enableTypographyShowcase'] ?? true,
          onChanged: (value) =>
              onConfigUpdate('features.enableTypographyShowcase', value),
          configKey: 'features.enableTypographyShowcase',
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
      title: AppLocalizations.getString('configuration'),
      icon: 'settings',
      items: [
        SettingsItem(
          title: AppLocalizations.getString('configuration_viewer'),
          subtitle: AppLocalizations.getString('view_raw_json_config'),
          icon: 'code',
          type: SettingsItemType.button,
          onChanged: (_) => onViewConfig(),
        ),
        SettingsItem(
          title: AppLocalizations.getString('reload_configuration'),
          subtitle: AppLocalizations.getString('refresh_config_from_file'),
          icon: 'refresh',
          type: SettingsItemType.button,
          onChanged: (_) => onReloadConfig(),
        ),
        SettingsItem(
          title: AppLocalizations.getString('reset_to_default'),
          subtitle: AppLocalizations.getString('reset_all_settings'),
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
          title: AppLocalizations.getString('name'),
          type: SettingsItemType.info,
          value: appInfo['name'] ?? 'Unknown',
        ),
        SettingsItem(
          title: AppLocalizations.getString('version'),
          type: SettingsItemType.info,
          value: appInfo['version'] ?? 'Unknown',
        ),
        SettingsItem(
          title: AppLocalizations.getString('build_number'),
          type: SettingsItemType.info,
          value: appInfo['buildNumber'] ?? 'Unknown',
        ),
        SettingsItem(
          title: AppLocalizations.getString('environment'),
          type: SettingsItemType.info,
          value: appInfo['environment'] ?? 'Unknown',
        ),
      ]);
    } else {
      items.addAll([
        SettingsItem(
          title: AppLocalizations.getString('name'),
          type: SettingsItemType.info,
          value: 'Flutter Explorer',
        ),
        SettingsItem(
          title: AppLocalizations.getString('version'),
          type: SettingsItemType.info,
          value: '1.0.0',
        ),
        SettingsItem(
          title: AppLocalizations.getString('build_number'),
          type: SettingsItemType.info,
          value: '1',
        ),
        SettingsItem(
          title: AppLocalizations.getString('environment'),
          type: SettingsItemType.info,
          value: 'development',
        ),
      ]);
    }

    return SettingsSection(
      title: AppLocalizations.getString('about'),
      icon: 'info',
      items: items,
    );
  }
}
