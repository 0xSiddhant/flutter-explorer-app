import 'package:flutter/services.dart';

/// Service for vibration method channel operations
class VibrationService {
  final MethodChannel _channel;

  const VibrationService(this._channel);

  /// Trigger device vibration
  Future<bool> vibrate({int duration = 500}) async {
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
}
