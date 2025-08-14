import 'package:flutter/services.dart';
import 'services/device_service.dart';
import 'services/battery_service.dart';
import 'services/dialog_service.dart';
import 'services/vibration_service.dart';
import 'services/camera_service.dart';
import 'services/location_service.dart';
import 'services/notification_service.dart';
import 'services/storage_service.dart';
import 'services/network_service.dart';

/// Central manager for all method channel operations
class MethodChannelManager {
  // Main channel for basic operations
  static const String _channelName = 'flutter_demo_channel';
  static const MethodChannel _channel = MethodChannel(_channelName);

  // Separate channels for different services
  static const String _cameraChannelName = 'flutter_camera_channel';
  static const MethodChannel _cameraChannel = MethodChannel(_cameraChannelName);

  static const String _locationChannelName = 'flutter_location_channel';
  static const MethodChannel _locationChannel = MethodChannel(
    _locationChannelName,
  );

  static const String _notificationChannelName = 'flutter_notification_channel';
  static const MethodChannel _notificationChannel = MethodChannel(
    _notificationChannelName,
  );

  static const String _storageChannelName = 'flutter_storage_channel';
  static const MethodChannel _storageChannel = MethodChannel(
    _storageChannelName,
  );

  static const String _networkChannelName = 'flutter_network_channel';
  static const MethodChannel _networkChannel = MethodChannel(
    _networkChannelName,
  );

  // Service instances
  static const CameraService _cameraService = CameraService(_cameraChannel);
  static const LocationService _locationService = LocationService(
    _locationChannel,
  );
  static const NotificationService _notificationService = NotificationService(
    _notificationChannel,
  );
  static const StorageService _storageService = StorageService(_storageChannel);
  static const NetworkService _networkService = NetworkService(_networkChannel);

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
    } on PlatformException {
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
    } on PlatformException {
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
    } on PlatformException {
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

  // Camera Service Methods
  /// Take a photo using native camera
  static Future<Map<String, dynamic>> takePhoto() async {
    return _cameraService.takePhoto();
  }

  /// Check camera permissions
  static Future<bool> checkCameraPermission() async {
    return _cameraService.checkCameraPermission();
  }

  /// Request camera permissions
  static Future<bool> requestCameraPermission() async {
    return _cameraService.requestCameraPermission();
  }

  // Location Service Methods
  /// Get current location
  static Future<Map<String, dynamic>> getCurrentLocation() async {
    return _locationService.getCurrentLocation();
  }

  /// Check location permissions
  static Future<bool> checkLocationPermission() async {
    return _locationService.checkLocationPermission();
  }

  /// Request location permissions
  static Future<bool> requestLocationPermission() async {
    return _locationService.requestLocationPermission();
  }

  /// Get location services status
  static Future<bool> isLocationEnabled() async {
    return _locationService.isLocationEnabled();
  }

  // Notification Service Methods
  /// Show a local notification
  static Future<bool> showNotification({
    required String title,
    required String message,
    int id = 1,
  }) async {
    return _notificationService.showNotification(
      title: title,
      message: message,
      id: id,
    );
  }

  /// Cancel a notification by ID
  static Future<bool> cancelNotification(int id) async {
    return _notificationService.cancelNotification(id);
  }

  /// Cancel all notifications
  static Future<bool> cancelAllNotifications() async {
    return _notificationService.cancelAllNotifications();
  }

  /// Check notification permissions
  static Future<bool> checkNotificationPermission() async {
    return _notificationService.checkNotificationPermission();
  }

  /// Request notification permissions
  static Future<bool> requestNotificationPermission() async {
    return _notificationService.requestNotificationPermission();
  }

  // Storage Service Methods
  /// Save data to native storage
  static Future<bool> saveData({
    required String key,
    required String value,
  }) async {
    return _storageService.saveData(key: key, value: value);
  }

  /// Load data from native storage
  static Future<String?> loadData(String key) async {
    return _storageService.loadData(key);
  }

  /// Delete data from native storage
  static Future<bool> deleteData(String key) async {
    return _storageService.deleteData(key);
  }

  /// Clear all data from native storage
  static Future<bool> clearAllData() async {
    return _storageService.clearAllData();
  }

  /// Get available storage space
  static Future<Map<String, dynamic>> getStorageInfo() async {
    return _storageService.getStorageInfo();
  }

  // Network Service Methods
  /// Perform a GET request
  static Future<Map<String, dynamic>> getRequest({
    required String url,
    Map<String, String>? headers,
  }) async {
    return _networkService.getRequest(url: url, headers: headers);
  }

  /// Perform a POST request
  static Future<Map<String, dynamic>> postRequest({
    required String url,
    Map<String, String>? headers,
    String? body,
  }) async {
    return _networkService.postRequest(url: url, headers: headers, body: body);
  }

  /// Perform a PUT request
  static Future<Map<String, dynamic>> putRequest({
    required String url,
    Map<String, String>? headers,
    String? body,
  }) async {
    return _networkService.putRequest(url: url, headers: headers, body: body);
  }

  /// Perform a DELETE request
  static Future<Map<String, dynamic>> deleteRequest({
    required String url,
    Map<String, String>? headers,
  }) async {
    return _networkService.deleteRequest(url: url, headers: headers);
  }
}
