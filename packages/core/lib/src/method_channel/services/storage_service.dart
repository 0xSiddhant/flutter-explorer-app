import 'package:flutter/services.dart';

/// Service for storage-related method channel operations
class StorageService {
  final MethodChannel _channel;

  const StorageService(this._channel);

  /// Save data to native storage
  Future<bool> saveData({required String key, required String value}) async {
    try {
      final result = await _channel.invokeMethod('saveData', {
        'key': key,
        'value': value,
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

  /// Load data from native storage
  Future<String?> loadData(String key) async {
    try {
      final result = await _channel.invokeMethod('loadData', {'key': key});
      if (result is String) {
        return result;
      } else {
        return null;
      }
    } on PlatformException {
      return null;
    }
  }

  /// Delete data from native storage
  Future<bool> deleteData(String key) async {
    try {
      final result = await _channel.invokeMethod('deleteData', {'key': key});
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

  /// Clear all data from native storage
  Future<bool> clearAllData() async {
    try {
      final result = await _channel.invokeMethod('clearAllData');
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

  /// Get available storage space
  Future<Map<String, dynamic>> getStorageInfo() async {
    try {
      final result = await _channel.invokeMethod('getStorageInfo');
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
        'error': 'Failed to get storage info: ${e.message}',
      };
    }
  }
}
