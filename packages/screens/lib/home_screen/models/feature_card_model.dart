import 'package:flutter/material.dart';

/// Model class representing a feature card on the home screen
class FeatureCardModel {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const FeatureCardModel({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.onTap,
  });
}
