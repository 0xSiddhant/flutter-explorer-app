import 'package:core/core.dart';
import 'package:flutter/material.dart';
import '../models/theme_control_model.dart';

class ThemeControlsWidget extends StatelessWidget {
  final ThemeControlModel currentTheme;
  final ThemeControlModel originalTheme;
  final Function(ThemeControlModel) onThemeChanged;
  final VoidCallback onApplyChanges;
  final VoidCallback onReset;

  const ThemeControlsWidget({
    super.key,
    required this.currentTheme,
    required this.originalTheme,
    required this.onThemeChanged,
    required this.onApplyChanges,
    required this.onReset,
  });

  bool get hasChanges {
    return currentTheme != originalTheme;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.preview, color: Colors.orange),
                const SizedBox(width: 8),
                Text(
                  AppLocalizations.getString('theme_preview_mode'),
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.orange.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.orange.withValues(alpha: 0.3)),
              ),
              child: Text(
                AppLocalizations.getString('theme_preview_description'),
                style: const TextStyle(fontSize: 12, color: Colors.orange),
              ),
            ),
            const SizedBox(height: 16),
            _buildDarkModeToggle(),
            _buildHighContrastToggle(),
            _buildTextScaleControl(),
            const SizedBox(height: 24),
            _buildActionButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildDarkModeToggle() {
    return SwitchListTile(
      title: Text(AppLocalizations.getString('dark_mode')),
      subtitle: Text(
        AppLocalizations.getString('switch_between_light_and_dark_themes'),
      ),
      value: currentTheme.isDarkMode,
      onChanged: (value) {
        onThemeChanged(currentTheme.copyWith(isDarkMode: value));
      },
    );
  }

  Widget _buildHighContrastToggle() {
    return SwitchListTile(
      title: Text(AppLocalizations.getString('high_contrast')),
      subtitle: Text(
        AppLocalizations.getString('increase_contrast_for_better_visibility'),
      ),
      value: currentTheme.isHighContrast,
      onChanged: (value) {
        onThemeChanged(currentTheme.copyWith(isHighContrast: value));
      },
    );
  }

  Widget _buildTextScaleControl() {
    return ListTile(
      title: Text(AppLocalizations.getString('text_scale')),
      subtitle: Text(
        'Current: ${currentTheme.textScaleFactor.toStringAsFixed(1)}x',
      ),
      trailing: SizedBox(
        width: 100,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.remove),
              onPressed: () {
                if (currentTheme.textScaleFactor > 0.8) {
                  onThemeChanged(
                    currentTheme.copyWith(
                      textScaleFactor: currentTheme.textScaleFactor - 0.1,
                    ),
                  );
                }
              },
            ),
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                if (currentTheme.textScaleFactor < 2.0) {
                  onThemeChanged(
                    currentTheme.copyWith(
                      textScaleFactor: currentTheme.textScaleFactor + 0.1,
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            onPressed: hasChanges ? onApplyChanges : null,
            icon: const Icon(Icons.save),
            label: Text(AppLocalizations.getString('apply_changes')),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: OutlinedButton.icon(
            onPressed: hasChanges ? onReset : null,
            icon: const Icon(Icons.refresh),
            label: Text(AppLocalizations.getString('reset')),
            style: OutlinedButton.styleFrom(foregroundColor: Colors.orange),
          ),
        ),
      ],
    );
  }
}
