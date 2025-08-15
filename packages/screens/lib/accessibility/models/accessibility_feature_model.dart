import 'package:core/core.dart';
import 'package:flutter/material.dart';

/// Model representing an accessibility feature
class AccessibilityFeatureModel {
  final String id;
  final String title;
  final String subtitle;
  final IconData icon;
  final bool isEnabled;
  final Function(bool) onChanged;

  const AccessibilityFeatureModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.isEnabled,
    required this.onChanged,
  });
}

/// Model representing a semantic UI example
class SemanticExampleModel {
  final String id;
  final String title;
  final String description;
  final Widget widget;

  const SemanticExampleModel({
    required this.id,
    required this.title,
    required this.description,
    required this.widget,
  });
}

/// Model representing a semantic list item
class SemanticListItemModel {
  final String id;
  final String title;
  final String subtitle;
  final IconData? trailingIcon;

  const SemanticListItemModel({
    required this.id,
    required this.title,
    required this.subtitle,
    this.trailingIcon,
  });
}

/// Model representing a semantic tab
class SemanticTabModel {
  final String id;
  final String label;
  final IconData icon;
  final int index;

  const SemanticTabModel({
    required this.id,
    required this.label,
    required this.icon,
    required this.index,
  });
}
