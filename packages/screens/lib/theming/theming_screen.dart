import 'package:core/core.dart';
import 'package:flutter/material.dart';

import 'models/theme_control_model.dart';
import 'widgets/theme_controls_widget.dart';
import 'widgets/theme_preview_widget.dart';
import 'widgets/theme_info_widget.dart';
import 'data/theme_data.dart';

class ThemingScreen extends StatefulWidget {
  const ThemingScreen({super.key});

  @override
  State<ThemingScreen> createState() => _ThemingScreenState();
}

class _ThemingScreenState extends State<ThemingScreen> {
  late ScrollController _scrollController;

  // Local theme state for preview (doesn't affect global app)
  late ThemeControlModel _currentTheme;
  late ThemeControlModel _originalTheme;
  bool _hasHandledParams = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _initializeThemeState();

    // Listen for language changes to rebuild screen
    LanguageChangeListener.instance.addListener(_onLanguageChanged);

    // Listen for theme changes to update the screen
    ThemeObserver.instance.addListener(_onGlobalThemeChanged);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_hasHandledParams) {
      _handleDeepLinkParams();
      _hasHandledParams = true;
    }
  }

  void _initializeThemeState() {
    // Get current theme values
    _originalTheme = ThemeDataService.getCurrentTheme();
    _currentTheme = _originalTheme;
  }

  void _handleDeepLinkParams() {
    // Get query parameters using core package utility
    if (!RouteParamsUtils.hasQueryParameters(context)) return;

    // Collect all changes before calling setState once
    bool? newIsDarkMode;
    bool? newIsHighContrast;
    double? newTextScaleFactor;

    // Handle dark mode parameter
    final darkModeParam = RouteParamsUtils.getBooleanParameter(context, 'dark');
    if (darkModeParam != null) {
      newIsDarkMode = darkModeParam;
      debugPrint('Theming: Dark mode set to $newIsDarkMode');
    }

    // Handle high contrast parameter
    final highContrastParam = RouteParamsUtils.getBooleanParameter(
      context,
      'high_contrast',
    );
    if (highContrastParam != null) {
      newIsHighContrast = highContrastParam;
      debugPrint('Theming: High contrast set to $newIsHighContrast');
    }

    // Handle text scale factor parameter
    final textScaleParam = RouteParamsUtils.getDoubleParameter(
      context,
      'text_scale',
    );
    if (textScaleParam != null &&
        textScaleParam >= 0.5 &&
        textScaleParam <= 3.0) {
      newTextScaleFactor = textScaleParam;
      debugPrint('Theming: Text scale factor set to $newTextScaleFactor');
    } else if (textScaleParam != null) {
      debugPrint(
        'Theming: Invalid text scale factor $textScaleParam, using default',
      );
    }

    // Apply all changes in a single setState call
    if (newIsDarkMode != null ||
        newIsHighContrast != null ||
        newTextScaleFactor != null) {
      setState(() {
        _currentTheme = ThemeControlModel(
          isDarkMode: newIsDarkMode ?? _currentTheme.isDarkMode,
          isHighContrast: newIsHighContrast ?? _currentTheme.isHighContrast,
          textScaleFactor: newTextScaleFactor ?? _currentTheme.textScaleFactor,
        );
      });
    }

    // Debug all parameters
    debugPrint(
      'Theming: Deep link parameters: ${RouteParamsUtils.getParametersDebugString(context)}',
    );
  }

  void _onLanguageChanged() {
    setState(() {});
  }

  void _onGlobalThemeChanged() {
    // Update the screen when global theme changes
    setState(() {
      _initializeThemeState();
    });
  }

  @override
  void dispose() {
    LanguageChangeListener.instance.removeListener(_onLanguageChanged);
    ThemeObserver.instance.removeListener(_onGlobalThemeChanged);
    _scrollController.dispose();
    super.dispose();
  }

  void _onThemeChanged(ThemeControlModel newTheme) {
    setState(() {
      _currentTheme = newTheme;
    });
  }

  void _onApplyChanges() {
    ThemeDataService.applyTheme(_currentTheme);
    setState(() {
      _originalTheme = _currentTheme;
    });
  }

  void _onReset() {
    setState(() {
      _currentTheme = _originalTheme;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Create a local theme for preview that doesn't affect global state
    final localTheme = ThemeManager.instance.getThemeForPreview(
      ThemeManager.instance.selectedThemeId,
      _currentTheme.isDarkMode,
    );

    return Theme(
      data: localTheme,
      child: MediaQuery(
        data: MediaQuery.of(context).copyWith(
          textScaler: TextScaler.linear(_currentTheme.textScaleFactor),
        ),
        child: Scaffold(
          appBar: AppBar(
            title: Text(AppLocalizations.getString('theming')),
            backgroundColor: localTheme.colorScheme.inversePrimary,
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              controller: _scrollController,
              key: const PageStorageKey<String>('theming_screen_scroll'),
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ThemeControlsWidget(
                    currentTheme: _currentTheme,
                    originalTheme: _originalTheme,
                    onThemeChanged: _onThemeChanged,
                    onApplyChanges: _onApplyChanges,
                    onReset: _onReset,
                  ),
                  const SizedBox(height: 24),
                  const ThemePreviewWidget(),
                  const SizedBox(height: 24),
                  ThemeInfoWidget(theme: _currentTheme),
                  const SizedBox(height: 24), // Add bottom padding
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
