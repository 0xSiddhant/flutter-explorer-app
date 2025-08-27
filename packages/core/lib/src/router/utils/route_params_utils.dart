import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'large_data_handler.dart';

/// Utility class for handling route parameters
class RouteParamsUtils {
  /// Get query parameters from the current route context
  /// Returns an empty map if no parameters are found
  static Map<String, String> getQueryParameters(BuildContext context) {
    try {
      final routerState = GoRouterState.of(context);
      return routerState.uri.queryParameters;
    } catch (e) {
      debugPrint('RouteParamsUtils: Error getting query parameters: $e');
      return {};
    }
  }

  /// Get a specific query parameter value
  /// Returns null if the parameter doesn't exist
  static String? getQueryParameter(BuildContext context, String key) {
    final params = getQueryParameters(context);
    return params[key];
  }

  /// Get a boolean query parameter
  /// Returns null if the parameter doesn't exist or is invalid
  static bool? getBooleanParameter(BuildContext context, String key) {
    final value = getQueryParameter(context, key);
    if (value == null) return null;

    final lowerValue = value.toLowerCase();
    if (lowerValue == 'true') return true;
    if (lowerValue == 'false') return false;
    return null;
  }

  /// Get an integer query parameter
  /// Returns null if the parameter doesn't exist or is invalid
  static int? getIntParameter(BuildContext context, String key) {
    final value = getQueryParameter(context, key);
    if (value == null) return null;

    return int.tryParse(value);
  }

  /// Get a double query parameter
  /// Returns null if the parameter doesn't exist or is invalid
  static double? getDoubleParameter(BuildContext context, String key) {
    final value = getQueryParameter(context, key);
    if (value == null) return null;

    return double.tryParse(value);
  }

  /// Check if any query parameters exist
  static bool hasQueryParameters(BuildContext context) {
    final params = getQueryParameters(context);
    return params.isNotEmpty;
  }

  /// Get all query parameters as a formatted string for debugging
  static String getParametersDebugString(BuildContext context) {
    final params = getQueryParameters(context);
    if (params.isEmpty) return 'No parameters';

    return params.entries.map((e) => '${e.key}=${e.value}').join(', ');
  }

  /// Get a complex data structure from a large data parameter
  ///
  /// [context] - Build context
  /// [key] - Parameter key containing encoded large data
  ///
  /// Returns decoded data structure or null if not found/invalid
  static dynamic getLargeDataParameter(BuildContext context, String key) {
    final encodedValue = getQueryParameter(context, key);
    if (encodedValue == null || encodedValue.isEmpty) return null;

    try {
      return LargeDataHandler.decodeData(encodedValue);
    } catch (e) {
      debugPrint('RouteParamsUtils: Error decoding large data for $key: $e');
      return null;
    }
  }

  /// Get a list from a large data parameter
  ///
  /// [context] - Build context
  /// [key] - Parameter key containing encoded list data
  /// [itemDecoder] - Function to decode each list item
  ///
  /// Returns decoded list or empty list if not found/invalid
  static List<T> getLargeDataListParameter<T>(
    BuildContext context,
    String key,
    T Function(String) itemDecoder,
  ) {
    final encodedValue = getQueryParameter(context, key);
    if (encodedValue == null || encodedValue.isEmpty) return [];

    try {
      return LargeDataHandler.decodeList(encodedValue, itemDecoder);
    } catch (e) {
      debugPrint(
        'RouteParamsUtils: Error decoding large data list for $key: $e',
      );
      return [];
    }
  }

  /// Extract multiple large data parameters at once
  ///
  /// [context] - Build context
  /// [dataParamKeys] - List of parameter keys that contain large data
  ///
  /// Returns map of parameter names to decoded data
  static Map<String, dynamic> getLargeDataParameters(
    BuildContext context,
    List<String> dataParamKeys,
  ) {
    final result = <String, dynamic>{};

    for (final key in dataParamKeys) {
      final data = getLargeDataParameter(context, key);
      if (data != null) {
        result[key] = data;
      }
    }

    return result;
  }

  /// Check if a parameter contains large encoded data
  ///
  /// [context] - Build context
  /// [key] - Parameter key to check
  ///
  /// Returns true if parameter exists and appears to be encoded large data
  static bool hasLargeDataParameter(BuildContext context, String key) {
    final value = getQueryParameter(context, key);
    if (value == null || value.isEmpty) return false;

    // Check if it looks like encoded data (base64 or compressed)
    return value.length > 50 ||
        value.startsWith('compressed:') ||
        _isBase64Like(value);
  }

  /// Get parameter size information for debugging
  ///
  /// [context] - Build context
  ///
  /// Returns map of parameter names to their sizes
  static Map<String, int> getParameterSizes(BuildContext context) {
    final params = getQueryParameters(context);
    return params.map((key, value) => MapEntry(key, value.length));
  }

  /// Private helper to check if string looks like base64
  static bool _isBase64Like(String value) {
    // Simple heuristic: base64 strings are typically longer and contain
    // alphanumeric characters plus +, /, and = padding
    if (value.length < 20) return false;

    final base64Pattern = RegExp(r'^[A-Za-z0-9+/]*={0,2}$');
    return base64Pattern.hasMatch(value);
  }
}
