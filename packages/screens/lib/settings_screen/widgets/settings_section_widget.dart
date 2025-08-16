import 'package:flutter/material.dart';
import '../models/settings_section_model.dart';
import 'settings_item_widget.dart';

/// Widget for rendering a settings section
class SettingsSectionWidget extends StatelessWidget {
  final SettingsSection section;

  const SettingsSectionWidget({super.key, required this.section});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader(context),
        const SizedBox(height: 8),
        Card(
          child: Column(
            children: section.items.map((item) {
              final isLast = section.items.last == item;
              return Column(
                children: [
                  SettingsItemWidget(item: item),
                  if (!isLast) const Divider(height: 1),
                ],
              );
            }).toList(),
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _buildSectionHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(
            _getIconData(section.icon),
            color: Theme.of(context).colorScheme.primary,
            size: 24,
          ),
          const SizedBox(width: 8),
          Text(
            section.title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }

  IconData _getIconData(String iconName) {
    switch (iconName) {
      case 'language':
        return Icons.language;
      case 'palette':
        return Icons.palette;
      case 'accessibility':
        return Icons.accessibility;
      case 'settings':
        return Icons.settings;
      case 'info':
        return Icons.info;
      case 'dark_mode':
        return Icons.dark_mode;
      case 'light_mode':
        return Icons.light_mode;
      case 'contrast':
        return Icons.contrast;
      case 'text_fields':
        return Icons.text_fields;
      case 'code':
        return Icons.code;
      case 'refresh':
        return Icons.refresh;
      case 'restore':
        return Icons.restore;
      default:
        return Icons.settings;
    }
  }
}
