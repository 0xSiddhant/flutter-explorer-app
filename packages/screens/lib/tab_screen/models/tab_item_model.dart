import 'package:flutter/material.dart';

/// Model representing a tab item
class TabItemModel {
  final IconData icon;
  final String label;
  final int index;
  final Widget screen;

  const TabItemModel({
    required this.icon,
    required this.label,
    required this.index,
    required this.screen,
  });
}
