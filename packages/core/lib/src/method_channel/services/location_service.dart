import 'package:flutter/services.dart';

/// Service for location-related method channel operations
class LocationService {
  final MethodChannel _channel;

  const LocationService(this._channel);

  /// Get current location
  Future<Map<String, dynamic>> getCurrentLocation() async {
    try {
      final result = await _channel.invokeMethod('getCurrentLocation');
      if (result is Map) {
        return Map<String, dynamic>.from(result);
      } else {
        return {
          'success': false,
          'error': 'Unexpected result type: ${result.runtimeType}',
        };
      }
    } on PlatformException catch (e) {
      return {
        'success': false,
        'error': 'Failed to get location: ${e.message}',
      };
    }
  }

  /// Check location permissions
  Future<bool> checkLocationPermission() async {
    try {
      final result = await _channel.invokeMethod('checkLocationPermission');
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

  /// Request location permissions
  Future<bool> requestLocationPermission() async {
    try {
      final result = await _channel.invokeMethod('requestLocationPermission');
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

  /// Get location services status
  Future<bool> isLocationEnabled() async {
    try {
      final result = await _channel.invokeMethod('isLocationEnabled');
      if (result is bool) {
        return result;
      } else if (result is String) {
        return result.toLowerCase() == 'true' ||
            result.toLowerCase() == 'enabled';
      } else {
        return false;
      }
    } on PlatformException {
      return false;
    }
  }
}
