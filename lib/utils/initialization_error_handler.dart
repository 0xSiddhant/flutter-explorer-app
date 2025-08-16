import 'dart:io';
import 'package:flutter/material.dart';
import 'package:core/core.dart';

/// Utility class for handling initialization errors and showing error dialogs
class InitializationErrorHandler {
  /// Show initialization error dialog and exit app gracefully
  static Future<void> showErrorDialogAndExit(
    String serviceName,
    String error,
  ) async {
    // Create a simple app to show the error dialog
    runApp(
      MaterialApp(
        home: Scaffold(
          backgroundColor: Colors.red.shade50,
          body: Center(
            child: AlertDialog(
              title: Row(
                children: [
                  Icon(Icons.error_outline, color: Colors.red, size: 28),
                  const SizedBox(width: 8),
                  Text(AppLocalizations.getString('initialization_failed')),
                ],
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.getString('failed_to_initialize_service', {
                      'serviceName': serviceName,
                    }),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    AppLocalizations.getString('error_label', {'error': error}),
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    AppLocalizations.getString('initialization_error_message'),
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    // Exit app gracefully
                    _exitAppGracefully();
                  },
                  child: Text(AppLocalizations.getString('ok')),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Exit the app gracefully using multiple methods to ensure termination
  static void _exitAppGracefully() {
    exit(0);
  }
}
