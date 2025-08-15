import 'package:core/core.dart';
import 'package:flutter/material.dart';

/// Model class representing a native communication feature
class NativeFeatureModel {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const NativeFeatureModel({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.onTap,
  });
}
