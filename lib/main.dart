import 'package:flutter/material.dart';
import 'package:core/core.dart';
import 'flutter_explorer_app.dart';
import 'utils/utils.dart';

void main() async {
  // Ensure Flutter bindings are initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize configuration service
  try {
    await AppConfigService.instance.initialize();
    debugPrint("AppConfigService initialized main");
  } catch (e) {
    // Show error dialog and exit app gracefully
    await InitializationErrorHandler.showErrorDialogAndExit(
      'Configuration Service',
      e.toString(),
    );
    return;
  }

  // Initialize localization system with language from config
  try {
    debugPrint('Loading language from config...');
    await AppLocalizations.initializeFromConfig();
  } catch (e) {
    // Only exit app if both config-based and default initialization fail
    debugPrint('Critical error: Localization initialization failed: $e');
    await InitializationErrorHandler.showErrorDialogAndExit(
      'Localization System',
      e.toString(),
    );
    return;
  }

  // Load theme settings from configuration
  try {
    await ThemeManager.instance.loadFromConfig();

    // Reset text scale factor to default if it's not 1.0
    if (ThemeManager.instance.textScaleFactor != 1.0) {
      debugPrint('Resetting text scale factor to default (1.0)');
      await ThemeManager.instance.resetTextScaleFactor();
    }
  } catch (e) {
    // Log error but continue (theme can work with defaults)
    debugPrint('Warning: Failed to load theme from config: $e');
  }

  // Load accessibility settings from configuration
  try {
    await AccessibilityProvider.instance.loadFromConfig();
  } catch (e) {
    // Log error but continue (accessibility can work with defaults)
    debugPrint('Warning: Failed to load accessibility from config: $e');
  }

  // Initialize state restoration service
  try {
    await StateRestorationService.instance.initialize();
    debugPrint('StateRestorationService initialized successfully');
  } catch (e) {
    // Log error but continue (state restoration can work with defaults)
    debugPrint('Warning: Failed to initialize state restoration: $e');
  }

  runApp(const FlutterExplorerApp());
}
