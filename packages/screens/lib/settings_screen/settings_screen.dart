import 'package:flutter/material.dart';
import 'package:core/core.dart';
import 'package:common/common.dart';
import 'widgets/config_viewer_widget.dart';

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
        title: Text(AppLocalizations.getString('settings')),
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
              _buildSectionHeader('Configuration'),
              _buildConfigurationSection(),
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
      title: Text(AppLocalizations.getString('dark_mode')),
      subtitle: Text(
        AppLocalizations.getString('switch_between_light_and_dark_themes'),
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
      title: Text(AppLocalizations.getString('high_contrast')),
      subtitle: Text(
        AppLocalizations.getString('increase_contrast_for_better_visibility'),
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
          title: Text(AppLocalizations.getString('text_scale')),
          subtitle: Text(
            '${AppLocalizations.getString('current_scale')} ${_themeProvider.textScaleFactor.toStringAsFixed(1)}x',
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
      title: Text(AppLocalizations.getString('text_direction')),
      subtitle: Text(AppLocalizations.getString('switch_between_rtl_ltr')),
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
          title: Text(AppLocalizations.getString('screen_reader')),
          subtitle: Text(AppLocalizations.getString('enable_voice_feedback')),
          value: false,
          onChanged: (value) {
            // TODO: Implement screen reader logic
          },
        ),
        SwitchListTile(
          title: Text(AppLocalizations.getString('large_touch_targets')),
          subtitle: Text(AppLocalizations.getString('increase_button_sizes')),
          value: false,
          onChanged: (value) {
            // TODO: Implement large touch targets logic
          },
        ),
      ],
    );
  }

  Widget _buildConfigurationSection() {
    return Card(
      child: Column(
        children: [
          ListTile(
            leading: Icon(
              Icons.code,
              color: Theme.of(context).colorScheme.primary,
            ),
            title: const Text('Configuration Viewer'),
            subtitle: const Text('View raw JSON configuration file'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ConfigViewerWidget(),
                ),
              );
            },
          ),
          const Divider(height: 1),
          ListTile(
            leading: Icon(
              Icons.refresh,
              color: Theme.of(context).colorScheme.primary,
            ),
            title: const Text('Reload Configuration'),
            subtitle: const Text('Refresh configuration from file'),
            onTap: () async {
              try {
                await AppConfigService.instance.reload();
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Configuration reloaded successfully'),
                      backgroundColor: Colors.green,
                    ),
                  );
                }
              } catch (e) {
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Error reloading configuration: $e'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              }
            },
          ),
          const Divider(height: 1),
          ListTile(
            leading: Icon(
              Icons.restore,
              color: Theme.of(context).colorScheme.primary,
            ),
            title: const Text('Reset to Default'),
            subtitle: const Text('Reset all settings to default values'),
            onTap: () async {
              final confirmed = await showDialog<bool>(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Reset Configuration'),
                  content: const Text(
                    'Are you sure you want to reset all configuration to default values? '
                    'This action cannot be undone.',
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context, false),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context, true),
                      child: const Text('Reset'),
                    ),
                  ],
                ),
              );

              if (confirmed == true) {
                try {
                  await AppConfigService.instance.resetToDefault();
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Configuration reset to default'),
                        backgroundColor: Colors.orange,
                      ),
                    );
                  }
                } catch (e) {
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Error resetting configuration: $e'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                }
              }
            },
          ),
        ],
      ),
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
              AppLocalizations.getString('app_version'),
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(AppLocalizations.getString('app_version_info')),
            const SizedBox(height: 16),
            Text(
              AppLocalizations.getString('app_description'),
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 8),
            Text(AppLocalizations.getString('feature_navigation')),
            Text(AppLocalizations.getString('feature_theme')),
            Text(AppLocalizations.getString('feature_method_channels')),
            Text(AppLocalizations.getString('feature_isolates')),
            Text(AppLocalizations.getString('feature_localization')),
            Text(AppLocalizations.getString('feature_semantic_ui')),
            Text(AppLocalizations.getString('feature_file_storage')),
          ],
        ),
      ),
    );
  }
}
