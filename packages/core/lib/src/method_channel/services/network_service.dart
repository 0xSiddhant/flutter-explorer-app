import 'package:flutter/services.dart';

/// Service for network-related method channel operations
class NetworkService {
  final MethodChannel _channel;

  const NetworkService(this._channel);

  /// Perform a GET request
  Future<Map<String, dynamic>> getRequest({
    required String url,
    Map<String, String>? headers,
  }) async {
    try {
      final result = await _channel.invokeMethod('getRequest', {
        'url': url,
        'headers': headers ?? {},
      });
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
        'error': 'Failed to perform GET request: ${e.message}',
      };
    }
  }

  /// Perform a POST request
  Future<Map<String, dynamic>> postRequest({
    required String url,
    Map<String, String>? headers,
    String? body,
  }) async {
    try {
      final result = await _channel.invokeMethod('postRequest', {
        'url': url,
        'headers': headers ?? {},
        'body': body ?? '',
      });
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
        'error': 'Failed to perform POST request: ${e.message}',
      };
    }
  }

  /// Perform a PUT request
  Future<Map<String, dynamic>> putRequest({
    required String url,
    Map<String, String>? headers,
    String? body,
  }) async {
    try {
      final result = await _channel.invokeMethod('putRequest', {
        'url': url,
        'headers': headers ?? {},
        'body': body ?? '',
      });
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
        'error': 'Failed to perform PUT request: ${e.message}',
      };
    }
  }

  /// Perform a DELETE request
  Future<Map<String, dynamic>> deleteRequest({
    required String url,
    Map<String, String>? headers,
  }) async {
    try {
      final result = await _channel.invokeMethod('deleteRequest', {
        'url': url,
        'headers': headers ?? {},
      });
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
        'error': 'Failed to perform DELETE request: ${e.message}',
      };
    }
  }
}
