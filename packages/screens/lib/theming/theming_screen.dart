import 'package:core/core.dart';
import 'package:flutter/material.dart';

class ThemingScreen extends StatefulWidget {
  const ThemingScreen({super.key});

  @override
  State<ThemingScreen> createState() => _ThemingScreenState();
}

class _ThemingScreenState extends State<ThemingScreen> with RouteAwareMixin {
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
  void onScreenVisible() {
    super.onScreenVisible();
    print('🎨 Theming screen became visible');
  }

  @override
  void onScreenInvisible() {
    super.onScreenInvisible();
    print('🎨 Theming screen became invisible');
  }

  @override
  void onScreenPushed() {
    super.onScreenPushed();
    print('🎨 Theming screen was pushed');
  }

  @override
  void onScreenPopped() {
    super.onScreenPopped();
    print('🎨 Theming screen was popped');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.getString('theming')),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildThemeControls(),
              const SizedBox(height: 24),
              _buildThemePreview(),
              const SizedBox(height: 24),
              _buildThemeInfo(),
              const SizedBox(height: 24), // Add bottom padding
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildThemeControls() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Theme Controls',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            SwitchListTile(
              title: Text(AppLocalizations.getString('dark_mode')),
              subtitle: Text(
                AppLocalizations.getString(
                  'switch_between_light_and_dark_themes',
                ),
              ),
              value: _themeProvider.isDarkMode,
              onChanged: (value) {
                _themeProvider.setDarkMode(value);
              },
            ),
            SwitchListTile(
              title: Text(AppLocalizations.getString('high_contrast')),
              subtitle: Text(
                AppLocalizations.getString(
                  'increase_contrast_for_better_visibility',
                ),
              ),
              value: _themeProvider.isHighContrast,
              onChanged: (value) {
                _themeProvider.setHighContrast(value);
              },
            ),
            ListTile(
              title: Text(AppLocalizations.getString('text_scale')),
              subtitle: Text(
                'Current: ${_themeProvider.textScaleFactor.toStringAsFixed(1)}x',
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: () {
                      if (_themeProvider.textScaleFactor > 0.8) {
                        _themeProvider.setTextScaleFactor(
                          _themeProvider.textScaleFactor - 0.1,
                        );
                      }
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      if (_themeProvider.textScaleFactor < 2.0) {
                        _themeProvider.setTextScaleFactor(
                          _themeProvider.textScaleFactor + 0.1,
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildThemePreview() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Theme Preview',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text(AppLocalizations.getString('elevated_button')),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {},
                    child: Text(AppLocalizations.getString('outlined_button')),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: 'Text Field',
                hintText: 'Enter some text',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Checkbox(value: true, onChanged: (value) {}),
                Text(AppLocalizations.getString('checkbox')),
                const SizedBox(width: 16),
                Radio<bool>(
                  value: true,
                  groupValue: true,
                  onChanged: (value) {},
                ),
                Text(AppLocalizations.getString('radio')),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildThemeInfo() {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Current Theme Info',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildColorInfo('Primary', colorScheme.primary),
            _buildColorInfo('On Primary', colorScheme.onPrimary),
            _buildColorInfo('Secondary', colorScheme.secondary),
            _buildColorInfo('Surface', colorScheme.surface),
            _buildColorInfo('Surface', colorScheme.surface),
            _buildColorInfo('Error', colorScheme.error),
            const SizedBox(height: 16),
            Text(
              'Brightness: ${Theme.of(context).brightness.name}',
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
            Text(
              'Text Scale: ${_themeProvider.textScaleFactor.toStringAsFixed(1)}x',
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildColorInfo(String label, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              color: color,
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              '$label: #${color.toARGB32().toRadixString(16).padLeft(8, '0').toUpperCase()}',
              style: const TextStyle(fontFamily: 'monospace'),
            ),
          ),
        ],
      ),
    );
  }
}
