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
  final ThemeProvider _themeProvider = ThemeProvider.instance;

  @override
  void initState() {
    super.initState();
    // Set up callback to rebuild app when theme changes
    _themeProvider.setThemeChangedCallback(() {
      setState(() {});
    });

    // Listen for language changes to rebuild the app
    LanguageChangeListener.instance.addListener(_onLanguageChanged);
  }

  @override
  void dispose() {
    LanguageChangeListener.instance.removeListener(_onLanguageChanged);
    super.dispose();
  }

  void _onLanguageChanged() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Explorer',
      theme: _themeProvider.currentTheme,
      routerConfig: AppRouteManager.router,
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
              textScaler: TextScaler.linear(_themeProvider.textScaleFactor),
            ),
            child: child!,
          ),
        );
      },
    );
  }
}
