import 'package:flutter/material.dart';

/// Model class representing a lifecycle phase card
class LifecycleCardModel {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final String description;
  final List<String> methods;

  const LifecycleCardModel({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.description,
    required this.methods,
  });
}
