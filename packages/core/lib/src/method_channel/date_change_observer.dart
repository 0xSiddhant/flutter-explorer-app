import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

/// Observer for monitoring device date changes using platform-specific method channels
class DateChangeObserver {
  static const MethodChannel _channel = MethodChannel('date_change_observer');
  static const EventChannel _eventChannel = EventChannel('date_change_events');

  static DateChangeObserver? _instance;
  static bool _isInitialized = false;
  static StreamSubscription? _subscription;

  // Global context reference for showing snackbars
  static BuildContext? _globalContext;

  /// Get singleton instance
  factory DateChangeObserver() {
    _instance ??= DateChangeObserver._internal();
    return _instance!;
  }

  DateChangeObserver._internal();

  /// Initialize the date change observer
  ///
  /// [context] - BuildContext for showing snackbar notifications (optional)
  static void initialize({BuildContext? context}) {
    if (_isInitialized) {
      debugPrint('DateChangeObserver already initialized');
      return;
    }

    _globalContext = context;

    // Initialize the platform observer (fire and forget)
    _channel.invokeMethod('initialize').catchError((error) {
      debugPrint('Failed to initialize platform observer: $error');
    });

    // Listen for date change events
    _subscription = _eventChannel.receiveBroadcastStream().listen(
      (dynamic event) {
        _handleDateChange(event);
      },
      onError: (error) {
        debugPrint('DateChangeObserver error: $error');
      },
    );

    _isInitialized = true;
    debugPrint('DateChangeObserver initialized successfully');
  }

  /// Handle date change event from platform
  static void _handleDateChange(dynamic event) {
    try {
      if (event is Map) {
        final timestamp = event['timestamp'] as int?;
        final newDate = DateTime.fromMillisecondsSinceEpoch(timestamp ?? 0);

        debugPrint('Date changed to: $newDate');

        // Show global snackbar notification
        _showGlobalDateChangeNotification(newDate);
      }
    } catch (e) {
      debugPrint('Error handling date change: $e');
    }
  }

  /// Show global snackbar notification for date change
  static void _showGlobalDateChangeNotification(DateTime newDate) {
    try {
      final formattedDate = '${newDate.day}/${newDate.month}/${newDate.year}';

      // Use a post-frame callback to ensure we have a valid context
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_globalContext != null && _globalContext!.mounted) {
          ScaffoldMessenger.of(_globalContext!).showSnackBar(
            SnackBar(
              content: Text('Device date changed to: $formattedDate'),
              duration: const Duration(seconds: 3),
              backgroundColor: Colors.blue,
              behavior: SnackBarBehavior.floating,
              action: SnackBarAction(
                label: 'OK',
                textColor: Colors.white,
                onPressed: () {
                  ScaffoldMessenger.of(_globalContext!).hideCurrentSnackBar();
                },
              ),
            ),
          );
        }
      });
    } catch (e) {
      debugPrint('Error showing date change notification: $e');
    }
  }

  /// Dispose the observer and clean up resources
  static void dispose() {
    try {
      _subscription?.cancel();
      _subscription = null;

      // Dispose platform observer (fire and forget)
      _channel.invokeMethod('dispose').catchError((error) {
        debugPrint('Failed to dispose platform observer: $error');
      });

      _isInitialized = false;
      _globalContext = null;

      debugPrint('DateChangeObserver disposed successfully');
    } catch (e) {
      debugPrint('Error disposing DateChangeObserver: $e');
    }
  }

  /// Check if observer is initialized
  static bool get isInitialized => _isInitialized;

  /// Get current subscription status
  static bool get isListening => _subscription != null;
}
