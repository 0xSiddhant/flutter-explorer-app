import 'package:flutter/material.dart';
import 'package:core/core.dart';
import 'package:common/common.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final ThemeProvider _themeProvider = ThemeProvider.instance;
  bool _isRTLEnabled = false;

  @override
  void initState() {
    super.initState();
    // Set up callback to rebuild screen when theme changes
    _themeProvider.setThemeChangedCallback(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.getString('settings', 'en')),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionHeader('Appearance'),
              _buildThemeSwitch(),
              _buildHighContrastSwitch(),
              _buildTextScaleSlider(),
              const SizedBox(height: 24),
              _buildSectionHeader('Accessibility'),
              _buildRTLToggle(),
              _buildAccessibilitySettings(),
              const SizedBox(height: 24),
              _buildSectionHeader('About'),
              _buildAboutSection(),
              const SizedBox(height: 24), // Add bottom padding
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }

  Widget _buildThemeSwitch() {
    return ListTile(
      leading: Icon(
        _themeProvider.isDarkMode ? Icons.dark_mode : Icons.light_mode,
        color: Theme.of(context).colorScheme.primary,
      ),
      title: Text(AppLocalizations.getString('dark_mode', 'en')),
      subtitle: Text(
        AppLocalizations.getString(
          'switch_between_light_and_dark_themes',
          'en',
        ),
      ),
      trailing: Switch(
        value: _themeProvider.isDarkMode,
        onChanged: (value) {
          _themeProvider.setDarkMode(value);
        },
      ),
    );
  }

  Widget _buildHighContrastSwitch() {
    return ListTile(
      leading: Icon(
        Icons.contrast,
        color: Theme.of(context).colorScheme.primary,
      ),
      title: Text(AppLocalizations.getString('high_contrast', 'en')),
      subtitle: Text(
        AppLocalizations.getString(
          'increase_contrast_for_better_visibility',
          'en',
        ),
      ),
      trailing: Switch(
        value: _themeProvider.isHighContrast,
        onChanged: (value) {
          _themeProvider.setHighContrast(value);
        },
      ),
    );
  }

  Widget _buildTextScaleSlider() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          leading: Icon(
            Icons.text_fields,
            color: Theme.of(context).colorScheme.primary,
          ),
          title: Text(AppLocalizations.getString('text_scale', 'en')),
          subtitle: Text(
            '${AppLocalizations.getString('current_scale', 'en')} ${_themeProvider.textScaleFactor.toStringAsFixed(1)}x',
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Slider(
            value: _themeProvider.textScaleFactor,
            min: 0.8,
            max: 2.0,
            divisions: 12,
            label: '${_themeProvider.textScaleFactor.toStringAsFixed(1)}x',
            onChanged: (value) {
              _themeProvider.setTextScaleFactor(value);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildRTLToggle() {
    return ListTile(
      leading: Icon(
        _isRTLEnabled ? Icons.arrow_back : Icons.arrow_forward,
        color: Theme.of(context).colorScheme.primary,
      ),
      title: Text(AppLocalizations.getString('text_direction', 'en')),
      subtitle: Text(
        AppLocalizations.getString('switch_between_rtl_ltr', 'en'),
      ),
      trailing: Switch(
        value: _isRTLEnabled,
        onChanged: (value) {
          setState(() {
            _isRTLEnabled = value;
          });
          // TODO: Implement app-wide RTL/LTR switching
        },
      ),
    );
  }

  Widget _buildAccessibilitySettings() {
    return Column(
      children: [
        SwitchListTile(
          title: Text(AppLocalizations.getString('screen_reader', 'en')),
          subtitle: Text(
            AppLocalizations.getString('enable_voice_feedback', 'en'),
          ),
          value: false,
          onChanged: (value) {
            // TODO: Implement screen reader logic
          },
        ),
        SwitchListTile(
          title: Text(AppLocalizations.getString('large_touch_targets', 'en')),
          subtitle: Text(
            AppLocalizations.getString('increase_button_sizes', 'en'),
          ),
          value: false,
          onChanged: (value) {
            // TODO: Implement large touch targets logic
          },
        ),
      ],
    );
  }

  Widget _buildAboutSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.getString('app_version', 'en'),
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(AppLocalizations.getString('app_version_info', 'en')),
            const SizedBox(height: 16),
            Text(
              AppLocalizations.getString('app_description', 'en'),
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 8),
            Text(AppLocalizations.getString('feature_navigation', 'en')),
            Text(AppLocalizations.getString('feature_theme', 'en')),
            Text(AppLocalizations.getString('feature_method_channels', 'en')),
            Text(AppLocalizations.getString('feature_isolates', 'en')),
            Text(AppLocalizations.getString('feature_localization', 'en')),
            Text(AppLocalizations.getString('feature_semantic_ui', 'en')),
            Text(AppLocalizations.getString('feature_file_storage', 'en')),
          ],
        ),
      ),
    );
  }
}
