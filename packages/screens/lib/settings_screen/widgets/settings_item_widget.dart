import 'package:core/core.dart';
import 'package:flutter/material.dart';
import '../models/settings_section_model.dart';

/// Widget for rendering individual settings items
class SettingsItemWidget extends StatelessWidget {
  final SettingsItem item;

  const SettingsItemWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    switch (item.type) {
      case SettingsItemType.switch_:
        return _buildSwitchTile(context);
      case SettingsItemType.slider:
        return _buildSliderTile(context);
      case SettingsItemType.dropdown:
        return _buildDropdownTile(context);
      case SettingsItemType.button:
        return _buildButtonTile(context);
      case SettingsItemType.info:
        return _buildInfoTile(context);
    }
  }

  Widget _buildSwitchTile(BuildContext context) {
    return SwitchListTile(
      title: Text(item.title),
      subtitle: item.subtitle != null ? Text(item.subtitle!) : null,
      value: item.value as bool? ?? false,
      onChanged: item.onChanged as Function(bool)?,
    );
  }

  Widget _buildSliderTile(BuildContext context) {
    final value = (item.value as num?)?.toDouble() ?? 1.0;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(title: Text(item.title), subtitle: Text(item.subtitle ?? '')),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Slider(
            value: value,
            min: 0.8,
            max: 2.0,
            divisions: 12,
            label: '${value.toStringAsFixed(1)}x',
            onChanged: item.onChanged as Function(double)?,
          ),
        ),
      ],
    );
  }

  Widget _buildDropdownTile(BuildContext context) {
    // Check if this is a theme selection dropdown
    if (item.configKey == 'theme.selectedThemeId') {
      return _buildThemeDropdownTile(context);
    }

    // Default language dropdown
    return _buildLanguageDropdownTile(context);
  }

  Widget _buildThemeDropdownTile(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.palette, color: Theme.of(context).colorScheme.primary),
              const SizedBox(width: 8),
              Text(
                item.title,
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 12),
          DropdownButtonFormField<String>(
            value: _getValidThemeValue(item.value as String?),
            decoration: InputDecoration(
              labelText: AppLocalizations.getString('select_app_theme'),
              border: const OutlineInputBorder(),
            ),
            items: [
              DropdownMenuItem<String>(
                value: HarryPotterTheme.themeId,
                child: Text(AppLocalizations.getString('harry_potter_theme')),
              ),
              DropdownMenuItem<String>(
                value: DarkBlueTheme.themeId,
                child: Text(AppLocalizations.getString('dark_blue_theme')),
              ),
            ],
            onChanged: (String? newValue) {
              if (newValue != null && item.onChanged != null) {
                item.onChanged!(newValue);
              }
            },
          ),
          const SizedBox(height: 8),
          Text(
            'Current: ${_getThemeDisplayName(item.value as String? ?? ThemeManager.defaultThemeId)}',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageDropdownTile(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.language,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(width: 8),
              Text(
                item.title,
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 12),
          DropdownButtonFormField<String>(
            value: item.value as String?,
            decoration: const InputDecoration(
              labelText: 'Select Language',
              border: OutlineInputBorder(),
            ),
            items: AppLocalizations.supportedLanguages.map((language) {
              return DropdownMenuItem<String>(
                value: language.code,
                child: Row(
                  children: [
                    Text(language.name),
                    const SizedBox(width: 8),
                    Text(
                      '(${language.nativeName})',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
            onChanged: (String? newValue) {
              if (newValue != null && item.onChanged != null) {
                item.onChanged!(newValue);
              }
            },
          ),
          const SizedBox(height: 8),
          Text(
            'Current: ${AppLocalizations.getLanguageByCode(item.value as String? ?? 'en')?.nativeName ?? 'English'}',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  String _getThemeDisplayName(String themeId) {
    switch (themeId) {
      case ThemeManager.harryPotterThemeId:
        return AppLocalizations.getString('harry_potter_theme');
      case ThemeManager.darkBlueThemeId:
        return AppLocalizations.getString('dark_blue_theme');
      default:
        return AppLocalizations.getString('harry_potter_theme');
    }
  }

  String? _getValidThemeValue(String? themeId) {
    if (themeId == null) return ThemeManager.defaultThemeId;

    // Check if the theme ID is valid
    if (themeId == ThemeManager.harryPotterThemeId ||
        themeId == ThemeManager.darkBlueThemeId) {
      return themeId;
    }

    // If invalid, return default
    return ThemeManager.defaultThemeId;
  }

  Widget _buildButtonTile(BuildContext context) {
    return ListTile(
      leading: Icon(
        _getIconData(item.icon ?? ''),
        color: Theme.of(context).colorScheme.primary,
      ),
      title: Text(item.title),
      subtitle: Text(item.subtitle ?? ''),
      trailing: const Icon(Icons.arrow_forward_ios),
      onTap: () {
        if (item.onChanged != null) {
          item.onChanged!(null);
        }
      },
    );
  }

  Widget _buildInfoTile(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              '${item.title}:',
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(child: Text(item.value?.toString() ?? '')),
        ],
      ),
    );
  }

  IconData _getIconData(String iconName) {
    switch (iconName) {
      case 'language':
        return Icons.language;
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
