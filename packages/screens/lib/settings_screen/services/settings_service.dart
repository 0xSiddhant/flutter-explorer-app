import 'package:core/core.dart';
import 'package:flutter/material.dart';

/// Service for managing settings operations
class SettingsService {
  /// Update configuration value
  static Future<void> updateConfig(String key, dynamic value) async {
    try {
      await AppConfigService.instance.setValue(key, value);
    } catch (e) {
      debugPrint('Error updating configuration: $e');
      rethrow;
    }
  }

  /// Change app language
  static Future<void> changeLanguage(String languageCode) async {
    try {
      await updateConfig('internationalization.defaultLanguage', languageCode);
      await AppLocalizations.changeLanguage(languageCode);

      // The LanguageChangeListener will be notified by AppLocalizations.setLocale()
      // which is called by AppLocalizations.changeLanguage()
    } catch (e) {
      debugPrint('Error changing language: $e');
      rethrow;
    }
  }

  /// Reload configuration from file
  static Future<void> reloadConfiguration() async {
    try {
      await AppConfigService.instance.reload();
    } catch (e) {
      debugPrint('Error reloading configuration: $e');
      rethrow;
    }
  }

  /// Reset configuration to default
  static Future<void> resetConfiguration() async {
    try {
      await AppConfigService.instance.resetToDefault();
    } catch (e) {
      debugPrint('Error resetting configuration: $e');
      rethrow;
    }
  }

  /// Get app information from platform
  static Future<Map<String, dynamic>?> getAppInfo() async {
    try {
      return await AppConfigService.instance.getAppInfo();
    } catch (e) {
      debugPrint('Error getting app info: $e');
      return null;
    }
  }

  /// Get all configuration
  static Map<String, dynamic> getAllConfig() {
    try {
      return AppConfigService.instance.getAllConfig();
    } catch (e) {
      debugPrint('Error getting configuration: $e');
      return {};
    }
  }

  /// Show confirmation dialog for reset
  static Future<bool> showResetConfirmationDialog(BuildContext context) async {
    return await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(AppLocalizations.getString('reset_configuration')),
            content: Text(
              AppLocalizations.getString('reset_configuration_confirm'),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: Text(AppLocalizations.getString('cancel')),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                child: Text(AppLocalizations.getString('reset')),
              ),
            ],
          ),
        ) ??
        false;
  }

  /// Show success message
  static void showSuccessMessage(BuildContext context, String message) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message), backgroundColor: Colors.green),
      );
    }
  }

  /// Show error message
  static void showErrorMessage(BuildContext context, String message) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message), backgroundColor: Colors.red),
      );
    }
  }
}
