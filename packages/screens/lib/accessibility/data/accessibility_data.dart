import 'package:core/core.dart';
import 'package:flutter/material.dart';
import '../models/accessibility_feature_model.dart';

/// Data provider for accessibility features and examples
class AccessibilityData {
  /// Get accessibility features for the controls section
  static List<AccessibilityFeatureModel> getAccessibilityFeatures({
    required bool isScreenReaderEnabled,
    required bool isHighContrastEnabled,
    required bool isLargeTextEnabled,
    required Function(bool) onScreenReaderChanged,
    required Function(bool) onHighContrastChanged,
    required Function(bool) onLargeTextChanged,
  }) {
    return [
      AccessibilityFeatureModel(
        id: 'screen_reader',
        title: AppLocalizations.getString('screen_reader_mode'),
        subtitle: AppLocalizations.getString('enable_voice_feedback_for_ui'),
        icon: Icons.visibility,
        isEnabled: isScreenReaderEnabled,
        onChanged: onScreenReaderChanged,
      ),
      AccessibilityFeatureModel(
        id: 'high_contrast',
        title: AppLocalizations.getString('high_contrast'),
        subtitle: AppLocalizations.getString(
          'increase_contrast_for_better_visibility',
        ),
        icon: Icons.contrast,
        isEnabled: isHighContrastEnabled,
        onChanged: onHighContrastChanged,
      ),
      AccessibilityFeatureModel(
        id: 'large_text',
        title: AppLocalizations.getString('large_text'),
        subtitle: AppLocalizations.getString(
          'increase_text_size_for_readability',
        ),
        icon: Icons.text_fields,
        isEnabled: isLargeTextEnabled,
        onChanged: onLargeTextChanged,
      ),
    ];
  }
}
