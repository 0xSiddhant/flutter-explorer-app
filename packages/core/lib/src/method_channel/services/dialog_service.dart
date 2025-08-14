import 'package:flutter/services.dart';

/// Service for native dialog method channel operations
class DialogService {
  final MethodChannel _channel;

  const DialogService(this._channel);

  /// Show native dialog
  Future<bool> showNativeDialog({
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
}
