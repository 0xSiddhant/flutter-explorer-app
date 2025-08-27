import 'package:flutter/material.dart';
import 'package:core/core.dart';

/// Main application widget for Flutter Explorer
class FlutterExplorerApp extends StatefulWidget {
  /// Constructs a [FlutterExplorerApp]
  const FlutterExplorerApp({super.key});

  @override
  State<FlutterExplorerApp> createState() => _FlutterExplorerAppState();
}

class _FlutterExplorerAppState extends State<FlutterExplorerApp> {
  final ThemeManager _themeManager = ThemeManager.instance;
  final AccessibilityProvider _accessibilityProvider =
      AccessibilityProvider.instance;

  @override
  void initState() {
    super.initState();

    // Listen for theme changes to rebuild the app
    ThemeObserver.instance.addListener(_onThemeChanged);

    // Listen for accessibility changes to rebuild the app
    _accessibilityProvider.addListener(_onAccessibilityChanged);

    // Listen for language changes to rebuild the app
    LanguageChangeListener.instance.addListener(_onLanguageChanged);

    // Initialize date change observer
    _initializeDateChangeObserver();

    // Initialize navigation restoration after the widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeNavigationRestoration();
    });
  }

  @override
  void dispose() {
    LanguageChangeListener.instance.removeListener(_onLanguageChanged);
    ThemeObserver.instance.removeListener(_onThemeChanged);
    _accessibilityProvider.removeListener(_onAccessibilityChanged);
    DateChangeObserver.dispose();
    super.dispose();
  }

  void _onLanguageChanged() {
    setState(() {});
  }

  void _onThemeChanged() {
    setState(() {});
  }

  void _onAccessibilityChanged() {
    setState(() {});
  }

  void _initializeDateChangeObserver() {
    DateChangeObserver.initialize(context: context);
    debugPrint('Date change observer initialization started');
  }

  void _initializeNavigationRestoration() {
    final navigationRestorationService = NavigationRestorationService.instance;
    if (navigationRestorationService.needsRestoration) {
      debugPrint('FlutterExplorerApp: Initializing navigation restoration');
      navigationRestorationService.restoreNavigationStack(
        AppRouteManager.router,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Apply accessibility settings to the theme
    final baseTheme = _themeManager.currentTheme;
    final accessibleTheme = _accessibilityProvider.getAccessibleTheme(
      baseTheme,
    );

    debugPrint(
      'FlutterExplorerApp: Building with theme - Base brightness: ${baseTheme.brightness}, Accessible brightness: ${accessibleTheme.brightness}',
    );

    return MaterialApp.router(
      title: 'Flutter Explorer',
      theme: accessibleTheme,
      debugShowCheckedModeBanner: false,
      routerConfig: AppRouteManager.router,
      restorationScopeId: 'flutter_explorer_app',
      builder: (context, child) {
        // Get current language from LanguageChangeListener
        final currentLanguage = LanguageChangeListener.instance.currentLanguage;
        final textDirection = AppLocalizations.getTextDirectionForLocale(
          Locale(currentLanguage),
        );

        return Directionality(
          textDirection: textDirection,
          child: MediaQuery(
            data: MediaQuery.of(context).copyWith(
              textScaler: TextScaler.linear(_themeManager.textScaleFactor),
            ),
            child: child!,
          ),
        );
      },
    );
  }
}
