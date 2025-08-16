import 'package:core/core.dart';
import 'package:flutter/material.dart';
import '../models/theme_control_model.dart';

class ThemeInfoWidget extends StatelessWidget {
  final ThemeControlModel theme;

  const ThemeInfoWidget({super.key, required this.theme});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.getString('theme_information'),
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildInfoRow(
              'Dark Mode',
              theme.isDarkMode ? 'Enabled' : 'Disabled',
            ),
            _buildInfoRow(
              'High Contrast',
              theme.isHighContrast ? 'Enabled' : 'Disabled',
            ),
            _buildInfoRow(
              'Text Scale',
              '${theme.textScaleFactor.toStringAsFixed(1)}x',
            ),
            _buildInfoRow('Brightness', theme.isDarkMode ? 'Dark' : 'Light'),
            _buildInfoRow(
              'Color Scheme',
              theme.isHighContrast ? 'High Contrast' : 'Standard',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
