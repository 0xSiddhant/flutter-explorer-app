import 'package:core/core.dart';
import 'package:flutter/material.dart';
import '../models/deep_link_example_model.dart';

/// Data provider for deep link examples
class DeepLinkExamplesData {
  static List<DeepLinkExampleModel> getDeepLinkExamples(
    BuildContext context,
    Function(String) onExampleTap,
  ) {
    return [
      DeepLinkExampleModel(
        url: 'frouter://home',
        description: AppLocalizations.getString('open_home_tab'),
        icon: Icons.home,
        color: Colors.blue,
        onTap: () => onExampleTap('frouter://home'),
      ),
      DeepLinkExampleModel(
        url: 'frouter://setting',
        description: AppLocalizations.getString('open_settings_tab'),
        icon: Icons.settings,
        color: Colors.grey,
        onTap: () => onExampleTap('frouter://setting'),
      ),
      DeepLinkExampleModel(
        url: 'frouter://config',
        description: AppLocalizations.getString('open_config_viewer'),
        icon: Icons.settings_applications,
        color: Colors.orange,
        onTap: () => onExampleTap('frouter://config'),
      ),
      DeepLinkExampleModel(
        url: 'frouter://i10n?locale=jp',
        description: AppLocalizations.getString(
          'open_internationalization_with_japanese',
        ),
        icon: Icons.language,
        color: Colors.red,
        onTap: () => onExampleTap('frouter://i10n?locale=jp'),
      ),
      DeepLinkExampleModel(
        url: 'frouter://theme_preview?theme=2',
        description: AppLocalizations.getString(
          'open_theme_preview_with_2nd_theme',
        ),
        icon: Icons.palette,
        color: Colors.purple,
        onTap: () => onExampleTap('frouter://theme_preview?theme=2'),
      ),
      DeepLinkExampleModel(
        url: 'frouter://accessibility',
        description: AppLocalizations.getString('open_accessibility_screen'),
        icon: Icons.accessibility,
        color: Colors.teal,
        onTap: () => onExampleTap('frouter://accessibility'),
      ),
      DeepLinkExampleModel(
        url: 'frouter://file_management',
        description: AppLocalizations.getString('open_file_management'),
        icon: Icons.folder,
        color: Colors.indigo,
        onTap: () => onExampleTap('frouter://file_management'),
      ),
      DeepLinkExampleModel(
        url: 'frouter://background_tasks',
        description: AppLocalizations.getString('open_background_tasks'),
        icon: Icons.sync,
        color: Colors.orange,
        onTap: () => onExampleTap('frouter://background_tasks'),
      ),
      DeepLinkExampleModel(
        url: 'frouter://native_communication',
        description: AppLocalizations.getString('open_native_communication'),
        icon: Icons.phone_android,
        color: Colors.green,
        onTap: () => onExampleTap('frouter://native_communication'),
      ),
      DeepLinkExampleModel(
        url: 'frouter://navigation_analytics',
        description: AppLocalizations.getString('open_navigation_analytics'),
        icon: Icons.analytics,
        color: Colors.cyan,
        onTap: () => onExampleTap('frouter://navigation_analytics'),
      ),
      DeepLinkExampleModel(
        url: 'frouter://lifecycle_management',
        description: AppLocalizations.getString('open_lifecycle_management'),
        icon: Icons.auto_awesome,
        color: Colors.amber,
        onTap: () => onExampleTap('frouter://lifecycle_management'),
      ),
      DeepLinkExampleModel(
        url: 'frouter://advanced_processing',
        description: AppLocalizations.getString('open_advanced_processing'),
        icon: Icons.science,
        color: Colors.deepOrange,
        onTap: () => onExampleTap('frouter://advanced_processing'),
      ),
      DeepLinkExampleModel(
        url: 'frouter://typography_showcase',
        description: AppLocalizations.getString('open_typography_showcase'),
        icon: Icons.text_fields,
        color: Colors.pink,
        onTap: () => onExampleTap('frouter://typography_showcase'),
      ),
    ];
  }
}
