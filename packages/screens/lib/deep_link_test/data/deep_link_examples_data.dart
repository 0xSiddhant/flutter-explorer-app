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
      // Basic Navigation Examples
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

      // Internationalization Examples
      DeepLinkExampleModel(
        url: 'frouter://i10n?locale=ja',
        description: 'Open with Japanese locale',
        icon: Icons.language,
        color: Colors.red,
        onTap: () => onExampleTap('frouter://i10n?locale=ja'),
      ),
      DeepLinkExampleModel(
        url: 'frouter://i10n?locale=es',
        description: 'Open with Spanish locale',
        icon: Icons.public,
        color: Colors.orange,
        onTap: () => onExampleTap('frouter://i10n?locale=es'),
      ),

      // Theme Examples
      DeepLinkExampleModel(
        url: 'frouter://theme_preview?theme=0&mode=dark',
        description: 'Dark theme preview',
        icon: Icons.dark_mode,
        color: Colors.purple,
        onTap: () => onExampleTap('frouter://theme_preview?theme=0&mode=dark'),
      ),
      DeepLinkExampleModel(
        url: 'frouter://theme_preview?theme=2&mode=light',
        description: 'Light theme with 3rd theme',
        icon: Icons.light_mode,
        color: Colors.amber,
        onTap: () => onExampleTap('frouter://theme_preview?theme=2&mode=light'),
      ),
      DeepLinkExampleModel(
        url: 'frouter://theming?dark=true&high_contrast=true',
        description: 'High contrast dark mode',
        icon: Icons.contrast,
        color: Colors.indigo,
        onTap: () =>
            onExampleTap('frouter://theming?dark=true&high_contrast=true'),
      ),

      // Accessibility Examples
      DeepLinkExampleModel(
        url: 'frouter://accessibility?screen_reader=true&large_text=true',
        description: 'Accessibility with screen reader',
        icon: Icons.accessibility_new,
        color: Colors.teal,
        onTap: () => onExampleTap(
          'frouter://accessibility?screen_reader=true&large_text=true',
        ),
      ),
      DeepLinkExampleModel(
        url: 'frouter://accessibility?high_contrast=true&tab=1',
        description: 'High contrast mode, tab 1',
        icon: Icons.visibility,
        color: Colors.cyan,
        onTap: () =>
            onExampleTap('frouter://accessibility?high_contrast=true&tab=1'),
      ),

      // Feature Showcase Examples
      DeepLinkExampleModel(
        url: 'frouter://config',
        description: AppLocalizations.getString('open_config_viewer'),
        icon: Icons.settings_applications,
        color: Colors.deepOrange,
        onTap: () => onExampleTap('frouter://config'),
      ),
      DeepLinkExampleModel(
        url: 'frouter://file_management',
        description: AppLocalizations.getString('open_file_management'),
        icon: Icons.folder_open,
        color: Colors.green,
        onTap: () => onExampleTap('frouter://file_management'),
      ),
      DeepLinkExampleModel(
        url: 'frouter://native_communication',
        description: 'Native platform features',
        icon: Icons.phone_android,
        color: Colors.lime,
        onTap: () => onExampleTap('frouter://native_communication'),
      ),
      DeepLinkExampleModel(
        url: 'frouter://typography_showcase',
        description: 'Typography & text showcase',
        icon: Icons.text_fields,
        color: Colors.pink,
        onTap: () => onExampleTap('frouter://typography_showcase'),
      ),
    ];
  }
}
