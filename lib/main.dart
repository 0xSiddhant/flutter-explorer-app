import 'package:flutter/material.dart';
import 'package:core/core.dart';
import 'package:common/common.dart';
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

  // Initialize localization system
  try {
    await AppLocalizations.initialize();
  } catch (e) {
    // Show error dialog and exit app gracefully
    await InitializationErrorHandler.showErrorDialogAndExit(
      'Localization System',
      e.toString(),
    );
    return;
  }

  // Load theme settings from configuration
  try {
    await ThemeProvider.instance.loadFromConfig();
  } catch (e) {
    // Log error but continue (theme can work with defaults)
    debugPrint('Warning: Failed to load theme from config: $e');
  }

  runApp(const FlutterExplorerApp());
}
