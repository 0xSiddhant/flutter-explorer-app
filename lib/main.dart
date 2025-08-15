import 'package:flutter/material.dart';
import 'package:core/core.dart';
import 'package:common/common.dart';

void main() async {
  // Ensure Flutter bindings are initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize localization system
  await AppLocalizations.initialize();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  /// Constructs a [MyApp]
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final ThemeProvider _themeProvider = ThemeProvider.instance;

  @override
  void initState() {
    super.initState();
    // Set up callback to rebuild app when theme changes
    _themeProvider.setThemeChangedCallback(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Explorer',
      theme: _themeProvider.currentTheme,
      routerConfig: AppRouteManager.router,
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaler: TextScaler.linear(_themeProvider.textScaleFactor),
          ),
          child: child!,
        );
      },
    );
  }
}
