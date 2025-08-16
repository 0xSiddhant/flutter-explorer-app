import 'package:flutter/services.dart';

/// Service for camera-related method channel operations
class CameraService {
  final MethodChannel _channel;

  const CameraService(this._channel);

  /// Take a photo using native camera
  Future<Map<String, dynamic>> takePhoto() async {
    try {
      final result = await _channel.invokeMethod('takePhoto');
      if (result is Map) {
        return Map<String, dynamic>.from(result);
      } else {
        return {
          'success': false,
          'error': 'Unexpected result type: ${result.runtimeType}',
        };
      }
    } on PlatformException catch (e) {
      return {'success': false, 'error': 'Failed to take photo: ${e.message}'};
    }
  }

  /// Check camera permissions
  Future<bool> checkCameraPermission() async {
    try {
      final result = await _channel.invokeMethod('checkCameraPermission');
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

  /// Request camera permissions
  Future<bool> requestCameraPermission() async {
    try {
      final result = await _channel.invokeMethod('requestCameraPermission');
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
