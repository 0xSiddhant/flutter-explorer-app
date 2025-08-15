import 'package:flutter/services.dart';

/// Service for notification-related method channel operations
class NotificationService {
  final MethodChannel _channel;

  const NotificationService(this._channel);

  /// Generic method to parse method channel results
  bool _parseResult(
    dynamic result, {
    List<String> successValues = const ['true', 'success'],
  }) {
    if (result is bool) {
      return result;
    } else if (result is String) {
      return successValues.contains(result.toLowerCase());
    }
    return false;
  }

  /// Generic method to invoke method channel with error handling
  Future<bool> _invokeMethod(
    String method, [
    Map<String, dynamic>? arguments,
  ]) async {
    try {
      final result = await _channel.invokeMethod(method, arguments);
      return _parseResult(result);
    } on PlatformException {
      return false;
    }
  }

  /// Show a local notification
  Future<bool> showNotification({
    required String title,
    required String message,
    int id = 1,
  }) async {
    return _invokeMethod('showNotification', {
      'title': title,
      'message': message,
      'id': id,
    });
  }

  /// Cancel a notification by ID
  Future<bool> cancelNotification(int id) async {
    return _invokeMethod('cancelNotification', {'id': id});
  }

  /// Cancel all notifications
  Future<bool> cancelAllNotifications() async {
    return _invokeMethod('cancelAllNotifications');
  }

  /// Check notification permissions
  Future<bool> checkNotificationPermission() async {
    try {
      final result = await _channel.invokeMethod('checkNotificationPermission');
      return _parseResult(
        result,
        successValues: ['true', 'success', 'granted'],
      );
    } on PlatformException {
      return false;
    }
  }

  /// Request notification permissions
  Future<bool> requestNotificationPermission() async {
    try {
      final result = await _channel.invokeMethod(
        'requestNotificationPermission',
      );
      return _parseResult(
        result,
        successValues: ['true', 'success', 'granted'],
      );
    } on PlatformException {
      return false;
    }
  }
}
