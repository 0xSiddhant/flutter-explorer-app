import 'package:flutter/material.dart';
import '../config/app_config_service.dart';

/// Global provider for managing accessibility settings across the app
class AccessibilityProvider extends ChangeNotifier {
  static final AccessibilityProvider _instance =
      AccessibilityProvider._internal();
  factory AccessibilityProvider() => _instance;
  AccessibilityProvider._internal();

  static AccessibilityProvider get instance => _instance;

  bool _isScreenReaderEnabled = false;
  bool _isHighContrastEnabled = false;
  bool _isLargeTextEnabled = false;
  bool _isReducedMotionEnabled = false;
  bool _isColorBlindSupportEnabled = false;
  bool _isLargeTouchTargetsEnabled = false;
  bool _isHapticFeedbackEnabled = false;
  bool _isSimplifiedUIEnabled = false;
  bool _isEnhancedFocusEnabled = false;
  double _minimumTouchTargetSize = 48.0;

  /// Current screen reader state
  bool get isScreenReaderEnabled => _isScreenReaderEnabled;

  /// Current high contrast state
  bool get isHighContrastEnabled => _isHighContrastEnabled;

  /// Current large text state
  bool get isLargeTextEnabled => _isLargeTextEnabled;

  /// Current reduced motion state
  bool get isReducedMotionEnabled => _isReducedMotionEnabled;

  /// Current color blind support state
  bool get isColorBlindSupportEnabled => _isColorBlindSupportEnabled;

  /// Current large touch targets state
  bool get isLargeTouchTargetsEnabled => _isLargeTouchTargetsEnabled;

  /// Current haptic feedback state
  bool get isHapticFeedbackEnabled => _isHapticFeedbackEnabled;

  /// Current simplified UI state
  bool get isSimplifiedUIEnabled => _isSimplifiedUIEnabled;

  /// Current enhanced focus state
  bool get isEnhancedFocusEnabled => _isEnhancedFocusEnabled;

  /// Current minimum touch target size
  double get minimumTouchTargetSize => _minimumTouchTargetSize;

  /// Load accessibility settings from configuration
  Future<void> loadFromConfig() async {
    try {
      final config = AppConfigService.instance.getAllConfig();
      final accessibility =
          config['accessibility'] as Map<String, dynamic>? ?? {};

      _isScreenReaderEnabled = accessibility['enableScreenReader'] ?? false;
      _isHighContrastEnabled = accessibility['enableHighContrast'] ?? false;
      _isLargeTextEnabled = accessibility['enableLargeText'] ?? false;
      _isReducedMotionEnabled = accessibility['enableReducedMotion'] ?? false;
      _isColorBlindSupportEnabled =
          accessibility['enableColorBlindSupport'] ?? false;
      _isLargeTouchTargetsEnabled =
          accessibility['enableLargeTouchTargets'] ?? false;
      _isHapticFeedbackEnabled = accessibility['enableHapticFeedback'] ?? false;
      _isSimplifiedUIEnabled = accessibility['enableSimplifiedUI'] ?? false;
      _isEnhancedFocusEnabled = accessibility['enableEnhancedFocus'] ?? false;
      _minimumTouchTargetSize =
          (accessibility['minimumTouchTargetSize'] ?? 48.0).toDouble();

      notifyListeners();
    } catch (e) {
      debugPrint('Error loading accessibility settings: $e');
    }
  }

  /// Set screen reader enabled state
  Future<void> setScreenReaderEnabled(bool value) async {
    _isScreenReaderEnabled = value;
    notifyListeners();

    try {
      await AppConfigService.instance.setValue(
        'accessibility.enableScreenReader',
        value,
      );
    } catch (e) {
      debugPrint('Error updating screen reader setting: $e');
    }
  }

  /// Set high contrast enabled state
  Future<void> setHighContrastEnabled(bool value) async {
    _isHighContrastEnabled = value;
    notifyListeners();

    try {
      await AppConfigService.instance.setValue(
        'accessibility.enableHighContrast',
        value,
      );
    } catch (e) {
      debugPrint('Error updating high contrast setting: $e');
    }
  }

  /// Set large text enabled state
  Future<void> setLargeTextEnabled(bool value) async {
    _isLargeTextEnabled = value;
    notifyListeners();

    try {
      await AppConfigService.instance.setValue(
        'accessibility.enableLargeText',
        value,
      );
    } catch (e) {
      debugPrint('Error updating large text setting: $e');
    }
  }

  /// Set reduced motion enabled state
  Future<void> setReducedMotionEnabled(bool value) async {
    _isReducedMotionEnabled = value;
    notifyListeners();

    try {
      await AppConfigService.instance.setValue(
        'accessibility.enableReducedMotion',
        value,
      );
    } catch (e) {
      debugPrint('Error updating reduced motion setting: $e');
    }
  }

  /// Set color blind support enabled state
  Future<void> setColorBlindSupportEnabled(bool value) async {
    _isColorBlindSupportEnabled = value;
    notifyListeners();

    try {
      await AppConfigService.instance.setValue(
        'accessibility.enableColorBlindSupport',
        value,
      );
    } catch (e) {
      debugPrint('Error updating color blind support setting: $e');
    }
  }

  /// Set large touch targets enabled state
  Future<void> setLargeTouchTargetsEnabled(bool value) async {
    _isLargeTouchTargetsEnabled = value;
    notifyListeners();

    try {
      await AppConfigService.instance.setValue(
        'accessibility.enableLargeTouchTargets',
        value,
      );
    } catch (e) {
      debugPrint('Error updating large touch targets setting: $e');
    }
  }

  /// Set haptic feedback enabled state
  Future<void> setHapticFeedbackEnabled(bool value) async {
    _isHapticFeedbackEnabled = value;
    notifyListeners();

    try {
      await AppConfigService.instance.setValue(
        'accessibility.enableHapticFeedback',
        value,
      );
    } catch (e) {
      debugPrint('Error updating haptic feedback setting: $e');
    }
  }

  /// Set simplified UI enabled state
  Future<void> setSimplifiedUIEnabled(bool value) async {
    _isSimplifiedUIEnabled = value;
    notifyListeners();

    try {
      await AppConfigService.instance.setValue(
        'accessibility.enableSimplifiedUI',
        value,
      );
    } catch (e) {
      debugPrint('Error updating simplified UI setting: $e');
    }
  }

  /// Set enhanced focus enabled state
  Future<void> setEnhancedFocusEnabled(bool value) async {
    _isEnhancedFocusEnabled = value;
    notifyListeners();

    try {
      await AppConfigService.instance.setValue(
        'accessibility.enableEnhancedFocus',
        value,
      );
    } catch (e) {
      debugPrint('Error updating enhanced focus setting: $e');
    }
  }

  /// Set minimum touch target size
  Future<void> setMinimumTouchTargetSize(double value) async {
    _minimumTouchTargetSize = value;
    notifyListeners();

    try {
      await AppConfigService.instance.setValue(
        'accessibility.minimumTouchTargetSize',
        value,
      );
    } catch (e) {
      debugPrint('Error updating minimum touch target size: $e');
    }
  }

  /// Get theme with accessibility modifications applied
  ThemeData getAccessibleTheme(ThemeData baseTheme) {
    ThemeData accessibleTheme = baseTheme;

    // Apply large text scaling
    if (_isLargeTextEnabled) {
      accessibleTheme = accessibleTheme.copyWith(
        textTheme: accessibleTheme.textTheme.copyWith(
          displayLarge: accessibleTheme.textTheme.displayLarge?.copyWith(
            fontSize:
                (accessibleTheme.textTheme.displayLarge?.fontSize ?? 96) * 1.3,
          ),
          displayMedium: accessibleTheme.textTheme.displayMedium?.copyWith(
            fontSize:
                (accessibleTheme.textTheme.displayMedium?.fontSize ?? 60) * 1.3,
          ),
          displaySmall: accessibleTheme.textTheme.displaySmall?.copyWith(
            fontSize:
                (accessibleTheme.textTheme.displaySmall?.fontSize ?? 48) * 1.3,
          ),
          headlineLarge: accessibleTheme.textTheme.headlineLarge?.copyWith(
            fontSize:
                (accessibleTheme.textTheme.headlineLarge?.fontSize ?? 40) * 1.3,
          ),
          headlineMedium: accessibleTheme.textTheme.headlineMedium?.copyWith(
            fontSize:
                (accessibleTheme.textTheme.headlineMedium?.fontSize ?? 34) *
                1.3,
          ),
          headlineSmall: accessibleTheme.textTheme.headlineSmall?.copyWith(
            fontSize:
                (accessibleTheme.textTheme.headlineSmall?.fontSize ?? 24) * 1.3,
          ),
          titleLarge: accessibleTheme.textTheme.titleLarge?.copyWith(
            fontSize:
                (accessibleTheme.textTheme.titleLarge?.fontSize ?? 22) * 1.3,
          ),
          titleMedium: accessibleTheme.textTheme.titleMedium?.copyWith(
            fontSize:
                (accessibleTheme.textTheme.titleMedium?.fontSize ?? 16) * 1.3,
          ),
          titleSmall: accessibleTheme.textTheme.titleSmall?.copyWith(
            fontSize:
                (accessibleTheme.textTheme.titleSmall?.fontSize ?? 14) * 1.3,
          ),
          bodyLarge: accessibleTheme.textTheme.bodyLarge?.copyWith(
            fontSize:
                (accessibleTheme.textTheme.bodyLarge?.fontSize ?? 16) * 1.3,
          ),
          bodyMedium: accessibleTheme.textTheme.bodyMedium?.copyWith(
            fontSize:
                (accessibleTheme.textTheme.bodyMedium?.fontSize ?? 14) * 1.3,
          ),
          bodySmall: accessibleTheme.textTheme.bodySmall?.copyWith(
            fontSize:
                (accessibleTheme.textTheme.bodySmall?.fontSize ?? 12) * 1.3,
          ),
          labelLarge: accessibleTheme.textTheme.labelLarge?.copyWith(
            fontSize:
                (accessibleTheme.textTheme.labelLarge?.fontSize ?? 14) * 1.3,
          ),
          labelMedium: accessibleTheme.textTheme.labelMedium?.copyWith(
            fontSize:
                (accessibleTheme.textTheme.labelMedium?.fontSize ?? 12) * 1.3,
          ),
          labelSmall: accessibleTheme.textTheme.labelSmall?.copyWith(
            fontSize:
                (accessibleTheme.textTheme.labelSmall?.fontSize ?? 11) * 1.3,
          ),
        ),
      );
    }

    // Apply high contrast colors
    if (_isHighContrastEnabled) {
      accessibleTheme = accessibleTheme.copyWith(
        colorScheme: accessibleTheme.colorScheme.copyWith(
          primary: accessibleTheme.brightness == Brightness.dark
              ? Colors.white
              : Colors.black,
          onPrimary: accessibleTheme.brightness == Brightness.dark
              ? Colors.black
              : Colors.white,
          surface: accessibleTheme.brightness == Brightness.dark
              ? Colors.black
              : Colors.white,
          onSurface: accessibleTheme.brightness == Brightness.dark
              ? Colors.white
              : Colors.black,
          background: accessibleTheme.brightness == Brightness.dark
              ? Colors.black
              : Colors.white,
          onBackground: accessibleTheme.brightness == Brightness.dark
              ? Colors.white
              : Colors.black,
        ),
      );
    }

    // Apply color blind support (alternative color scheme)
    if (_isColorBlindSupportEnabled) {
      accessibleTheme = accessibleTheme.copyWith(
        colorScheme: accessibleTheme.colorScheme.copyWith(
          primary: Colors.blue,
          secondary: Colors.orange,
          tertiary: Colors.green,
          error: Colors.red,
          surface: accessibleTheme.brightness == Brightness.dark
              ? Colors.grey[800]!
              : Colors.grey[100]!,
        ),
      );
    }

    // Apply simplified UI (reduced visual complexity)
    if (_isSimplifiedUIEnabled) {
      accessibleTheme = accessibleTheme.copyWith(
        cardTheme: accessibleTheme.cardTheme.copyWith(
          elevation: 1,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        appBarTheme: accessibleTheme.appBarTheme.copyWith(
          elevation: 1,
          centerTitle: true,
        ),
      );
    }

    // Apply enhanced focus indicators
    if (_isEnhancedFocusEnabled) {
      accessibleTheme = accessibleTheme.copyWith(
        focusColor: accessibleTheme.colorScheme.primary,
        hoverColor: accessibleTheme.colorScheme.primary.withOpacity(0.1),
      );
    }

    return accessibleTheme;
  }

  /// Check if animations should be reduced
  bool get shouldReduceMotion => _isReducedMotionEnabled;

  /// Get animation duration based on reduced motion setting
  Duration getAnimationDuration(Duration defaultDuration) {
    return _isReducedMotionEnabled
        ? const Duration(milliseconds: 0)
        : defaultDuration;
  }

  /// Get minimum touch target size based on accessibility setting
  double getTouchTargetSize() {
    return _isLargeTouchTargetsEnabled ? 64.0 : _minimumTouchTargetSize;
  }

  /// Check if haptic feedback should be provided
  bool get shouldProvideHapticFeedback => _isHapticFeedbackEnabled;

  /// Get color blind friendly colors
  Map<String, Color> getColorBlindFriendlyColors() {
    if (!_isColorBlindSupportEnabled) {
      return {};
    }

    return {
      'primary': Colors.blue,
      'secondary': Colors.orange,
      'success': Colors.green,
      'warning': Colors.yellow,
      'error': Colors.red,
      'info': Colors.cyan,
    };
  }

  /// Check if simplified UI should be applied
  bool get shouldUseSimplifiedUI => _isSimplifiedUIEnabled;

  /// Check if enhanced focus should be applied
  bool get shouldUseEnhancedFocus => _isEnhancedFocusEnabled;
}
