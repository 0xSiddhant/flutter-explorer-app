import 'package:flutter/material.dart';
import 'package:common/common.dart';
import '../models/accessibility_feature_model.dart';

/// Data provider for accessibility features and examples
class AccessibilityData {
  static const String _currentLanguage = 'en';

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
        title: AppLocalizations.getString(
          'screen_reader_mode',
          _currentLanguage,
        ),
        subtitle: AppLocalizations.getString(
          'enable_voice_feedback_for_ui',
          _currentLanguage,
        ),
        icon: Icons.visibility,
        isEnabled: isScreenReaderEnabled,
        onChanged: onScreenReaderChanged,
      ),
      AccessibilityFeatureModel(
        id: 'high_contrast',
        title: AppLocalizations.getString('high_contrast', _currentLanguage),
        subtitle: AppLocalizations.getString(
          'increase_contrast_for_better_visibility',
          _currentLanguage,
        ),
        icon: Icons.contrast,
        isEnabled: isHighContrastEnabled,
        onChanged: onHighContrastChanged,
      ),
      AccessibilityFeatureModel(
        id: 'large_text',
        title: AppLocalizations.getString('large_text', _currentLanguage),
        subtitle: AppLocalizations.getString(
          'increase_text_size_for_readability',
          _currentLanguage,
        ),
        icon: Icons.text_fields,
        isEnabled: isLargeTextEnabled,
        onChanged: onLargeTextChanged,
      ),
    ];
  }
}
