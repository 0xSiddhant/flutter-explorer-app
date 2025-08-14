import 'package:flutter/material.dart';
import 'package:core/core.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final ThemeProvider _themeProvider = ThemeProvider.instance;

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
        title: const Text('Settings'),
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
      title: const Text('Dark Mode'),
      subtitle: const Text('Switch between light and dark themes'),
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
      title: const Text('High Contrast'),
      subtitle: const Text('Increase contrast for better visibility'),
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
          title: const Text('Text Scale'),
          subtitle: Text(
            'Current scale: ${_themeProvider.textScaleFactor.toStringAsFixed(1)}x',
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

  Widget _buildAccessibilitySettings() {
    return Column(
      children: [
        SwitchListTile(
          title: const Text('Screen Reader'),
          subtitle: const Text('Enable voice feedback'),
          value: false,
          onChanged: (value) {
            // TODO: Implement screen reader logic
          },
        ),
        SwitchListTile(
          title: const Text('Large Touch Targets'),
          subtitle: const Text('Increase button sizes'),
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
            const Text(
              'App Version',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text('Flutter Core Features Demo v1.0.0'),
            const SizedBox(height: 16),
            const Text(
              'This app demonstrates various Flutter core features including:',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 8),
            const Text('• Navigation and Routing'),
            const Text('• Theme Management'),
            const Text('• Method Channels'),
            const Text('• Isolates'),
            const Text('• Localization'),
            const Text('• Semantic UI'),
            const Text('• File Storage'),
          ],
        ),
      ),
    );
  }
}
