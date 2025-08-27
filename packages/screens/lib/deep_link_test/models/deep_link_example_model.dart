import 'package:flutter/material.dart';

/// Model class representing a deep link example
class DeepLinkExampleModel {
  final String url;
  final String description;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const DeepLinkExampleModel({
    required this.url,
    required this.description,
    required this.icon,
    required this.color,
    required this.onTap,
  });
}
