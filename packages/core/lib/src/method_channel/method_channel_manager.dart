import 'package:flutter/services.dart';
import 'services/device_service.dart';
import 'services/battery_service.dart';
import 'services/dialog_service.dart';
import 'services/vibration_service.dart';

/// Central manager for all method channel operations
class MethodChannelManager {
  static const String _channelName = 'flutter_demo_channel';
  static const MethodChannel _channel = MethodChannel(_channelName);

  /// Get device information
  static Future<Map<String, dynamic>> getDeviceInfo() async {
    try {
      final result = await _channel.invokeMethod('getDeviceInfo');
      if (result is Map) {
        return Map<String, dynamic>.from(result);
      } else if (result is String) {
        // Handle case where native code returns a string
        return {'platform': 'Unknown', 'version': result, 'message': result};
      } else {
        return {
          'error': 'Unexpected result type: ${result.runtimeType}',
          'platform': 'Unknown',
          'version': 'Unknown',
        };
      }
    } on PlatformException catch (e) {
      return {
        'error': 'Failed to get device info: ${e.message}',
        'platform': 'Unknown',
        'version': 'Unknown',
      };
    }
  }

  /// Get battery level
  static Future<int> getBatteryLevel() async {
    try {
      final result = await _channel.invokeMethod('getBatteryLevel');
      if (result is int) {
        return result;
      } else if (result is String) {
        // Try to parse string to int
        return int.tryParse(result) ?? -1;
      } else {
        return -1; // Return -1 to indicate error
      }
    } on PlatformException catch (e) {
      return -1; // Return -1 to indicate error
    }
  }

  /// Show native dialog
  static Future<bool> showNativeDialog({
    required String title,
    required String message,
  }) async {
    try {
      final result = await _channel.invokeMethod('showNativeDialog', {
        'title': title,
        'message': message,
      });
      if (result is bool) {
        return result;
      } else if (result is String) {
        // Handle case where native code returns a string
        return result.toLowerCase() == 'true' ||
            result.toLowerCase() == 'success';
      } else {
        return false;
      }
    } on PlatformException catch (e) {
      return false;
    }
  }

  /// Trigger device vibration
  static Future<bool> vibrate({int duration = 500}) async {
    try {
      final result = await _channel.invokeMethod('vibrate', {
        'duration': duration,
      });
      if (result is bool) {
        return result;
      } else if (result is String) {
        // Handle case where native code returns a string
        return result.toLowerCase() == 'true' ||
            result.toLowerCase() == 'success';
      } else {
        return false;
      }
    } on PlatformException catch (e) {
      return false;
    }
  }

  /// Get device service instance
  static DeviceService get deviceService => DeviceService(_channel);

  /// Get battery service instance
  static BatteryService get batteryService => BatteryService(_channel);

  /// Get dialog service instance
  static DialogService get dialogService => DialogService(_channel);

  /// Get vibration service instance
  static VibrationService get vibrationService => VibrationService(_channel);
}
