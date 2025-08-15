import 'package:core/core.dart';
/// Model representing a settings section
class SettingsSection {
  final String title;
  final String icon;
  final List<SettingsItem> items;

  const SettingsSection({
    required this.title,
    required this.icon,
    required this.items,
  });
}

/// Model representing a settings item
class SettingsItem {
  final String title;
  final String? subtitle;
  final String? icon;
  final SettingsItemType type;
  final dynamic value;
  final Function(dynamic)? onChanged;
  final String? configKey;

  const SettingsItem({
    required this.title,
    this.subtitle,
    this.icon,
    required this.type,
    this.value,
    this.onChanged,
    this.configKey,
  });
}

/// Types of settings items
enum SettingsItemType {
  switch_,
  slider,
  dropdown,
  button,
  info,
}
