import 'package:flutter/material.dart';
import 'package:core/core.dart' show AppLocalizations;

/// Reusable error screen widget for handling unknown routes or errors
class ErrorScreen extends StatelessWidget {
  /// Error title to display
  final String? title;

  /// Error message to display
  final String? message;

  /// Error code to display (e.g., "404")
  final String? errorCode;

  /// Icon to display
  final IconData? icon;

  /// Action button text
  final String? actionButtonText;

  /// Action to perform when button is pressed
  final VoidCallback? onActionPressed;

  /// Whether to show the default "Go Home" button
  final bool showHomeButton;

  const ErrorScreen({
    super.key,
    this.title,
    this.message,
    this.errorCode,
    this.icon,
    this.actionButtonText,
    this.onActionPressed,
    this.showHomeButton = true,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title ?? AppLocalizations.getString('error_screen_title')),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon ?? Icons.error_outline, size: 64, color: Colors.red),
              const SizedBox(height: 16),
              if (errorCode != null) ...[
                Text(
                  errorCode!,
                  style: const TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
                const SizedBox(height: 16),
              ],
              Text(
                title ?? AppLocalizations.getString('error_screen_title'),
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                message ?? AppLocalizations.getString('error_screen_message'),
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 32),
              if (onActionPressed != null) ...[
                ElevatedButton(
                  onPressed: onActionPressed,
                  child: Text(
                    actionButtonText ??
                        AppLocalizations.getString('error_screen_action'),
                  ),
                ),
                const SizedBox(height: 16),
              ],
              if (showHomeButton)
                ElevatedButton(
                  onPressed: () {
                    // Navigate to home - this will be handled by the calling code
                    Navigator.of(context).popUntil((route) => route.isFirst);
                  },
                  child: Text(
                    AppLocalizations.getString('error_screen_go_home'),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
