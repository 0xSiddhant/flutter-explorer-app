import 'package:flutter/services.dart';

/// Service for device-related method channel operations
class DeviceService {
  final MethodChannel _channel;

  const DeviceService(this._channel);

  /// Get device information
  Future<Map<String, dynamic>> getDeviceInfo() async {
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
}
