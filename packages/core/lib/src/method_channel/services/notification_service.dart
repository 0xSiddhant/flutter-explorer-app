import 'package:flutter/services.dart';

/// Service for notification-related method channel operations
class NotificationService {
  final MethodChannel _channel;

  const NotificationService(this._channel);

  /// Show a local notification
  Future<bool> showNotification({
    required String title,
    required String message,
    int id = 1,
  }) async {
    try {
      final result = await _channel.invokeMethod('showNotification', {
        'title': title,
        'message': message,
        'id': id,
      });
      if (result is bool) {
        return result;
      } else if (result is String) {
        return result.toLowerCase() == 'true' ||
            result.toLowerCase() == 'success';
      } else {
        return false;
      }
    } on PlatformException {
      return false;
    }
  }

  /// Cancel a notification by ID
  Future<bool> cancelNotification(int id) async {
    try {
      final result = await _channel.invokeMethod('cancelNotification', {
        'id': id,
      });
      if (result is bool) {
        return result;
      } else if (result is String) {
        return result.toLowerCase() == 'true' ||
            result.toLowerCase() == 'success';
      } else {
        return false;
      }
    } on PlatformException {
      return false;
    }
  }

  /// Cancel all notifications
  Future<bool> cancelAllNotifications() async {
    try {
      final result = await _channel.invokeMethod('cancelAllNotifications');
      if (result is bool) {
        return result;
      } else if (result is String) {
        return result.toLowerCase() == 'true' ||
            result.toLowerCase() == 'success';
      } else {
        return false;
      }
    } on PlatformException {
      return false;
    }
  }

  /// Check notification permissions
  Future<bool> checkNotificationPermission() async {
    try {
      final result = await _channel.invokeMethod('checkNotificationPermission');
      if (result is bool) {
        return result;
      } else if (result is String) {
        return result.toLowerCase() == 'true' ||
            result.toLowerCase() == 'granted';
      } else {
        return false;
      }
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
      if (result is bool) {
        return result;
      } else if (result is String) {
        return result.toLowerCase() == 'true' ||
            result.toLowerCase() == 'granted';
      } else {
        return false;
      }
    } on PlatformException {
      return false;
    }
  }
}
