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

      // Large Data Examples
      DeepLinkExampleModel(
        url: _createLargeDataExample('user_preferences'),
        description: 'User preferences with large data',
        icon: Icons.person,
        color: Colors.deepPurple,
        onTap: () => onExampleTap(_createLargeDataExample('user_preferences')),
      ),
      DeepLinkExampleModel(
        url: _createLargeDataExample('app_config'),
        description: 'App configuration with complex data',
        icon: Icons.settings_suggest,
        color: Colors.brown,
        onTap: () => onExampleTap(_createLargeDataExample('app_config')),
      ),
      DeepLinkExampleModel(
        url: _createLargeDataExample('theme_palette'),
        description: 'Complete theme palette data',
        icon: Icons.palette_outlined,
        color: Colors.indigo,
        onTap: () => onExampleTap(_createLargeDataExample('theme_palette')),
      ),
    ];
  }

  /// Create example deep links with large data parameters
  static String _createLargeDataExample(String type) {
    switch (type) {
      case 'user_preferences':
        final userData = {
          'name': 'John Doe',
          'email': 'john.doe@example.com',
          'preferences': {
            'theme': 'dark',
            'language': 'en',
            'notifications': {'push': true, 'email': false, 'sms': true},
            'accessibility': {
              'screenReader': false,
              'highContrast': true,
              'largeText': false,
              'textScale': 1.2,
            },
            'privacy': {
              'analytics': true,
              'crashReports': false,
              'personalizedAds': false,
            },
          },
          'recentSearches': [
            'Flutter deep linking',
            'Material Design 3',
            'State management',
            'Navigation patterns',
            'Accessibility guidelines',
          ],
          'favoriteFeatures': [
            'theme_preview',
            'accessibility',
            'internationalization',
            'file_management',
          ],
        };
        return LargeDataHandler.createDeepLinkWithData('frouter://theming', {
          'user_preferences': userData,
        });

      case 'app_config':
        final configData = {
          'version': '1.0.0',
          'buildNumber': 42,
          'features': {
            'deepLinking': true,
            'stateRestoration': true,
            'accessibility': true,
            'internationalization': true,
            'theming': true,
            'analytics': false,
          },
          'api': {
            'baseUrl': 'https://api.example.com',
            'timeout': 30000,
            'retryAttempts': 3,
            'endpoints': {
              'users': '/api/v1/users',
              'themes': '/api/v1/themes',
              'settings': '/api/v1/settings',
            },
          },
          'ui': {
            'defaultTheme': 'material_3',
            'animations': {
              'enabled': true,
              'duration': 300,
              'curve': 'easeInOut',
            },
            'layout': {'maxWidth': 1200, 'padding': 16, 'spacing': 8},
          },
          'debug': {
            'enabled': false,
            'logLevel': 'info',
            'showPerformanceOverlay': false,
          },
        };
        return LargeDataHandler.createDeepLinkWithData('frouter://config', {
          'app_config': configData,
        });

      case 'theme_palette':
        final paletteData = {
          'primary': {
            '50': '#E3F2FD',
            '100': '#BBDEFB',
            '200': '#90CAF9',
            '300': '#64B5F6',
            '400': '#42A5F5',
            '500': '#2196F3',
            '600': '#1E88E5',
            '700': '#1976D2',
            '800': '#1565C0',
            '900': '#0D47A1',
          },
          'secondary': {
            '50': '#F3E5F5',
            '100': '#E1BEE7',
            '200': '#CE93D8',
            '300': '#BA68C8',
            '400': '#AB47BC',
            '500': '#9C27B0',
            '600': '#8E24AA',
            '700': '#7B1FA2',
            '800': '#6A1B9A',
            '900': '#4A148C',
          },
          'neutral': {
            '50': '#FAFAFA',
            '100': '#F5F5F5',
            '200': '#EEEEEE',
            '300': '#E0E0E0',
            '400': '#BDBDBD',
            '500': '#9E9E9E',
            '600': '#757575',
            '700': '#616161',
            '800': '#424242',
            '900': '#212121',
          },
          'semantic': {
            'success': '#4CAF50',
            'warning': '#FF9800',
            'error': '#F44336',
            'info': '#2196F3',
          },
          'custom': {
            'brand': '#FF6B35',
            'accent': '#F7931E',
            'highlight': '#FFD23F',
          },
        };
        return LargeDataHandler.createDeepLinkWithData(
          'frouter://theme_preview',
          {'theme_palette': paletteData, 'theme': 0, 'mode': 'light'},
        );

      default:
        return 'frouter://home';
    }
  }
}
