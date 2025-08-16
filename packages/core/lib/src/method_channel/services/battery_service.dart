import 'package:flutter/services.dart';

/// Service for battery-related method channel operations
class BatteryService {
  final MethodChannel _channel;

  const BatteryService(this._channel);

  /// Get battery level
  Future<int> getBatteryLevel() async {
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
}
