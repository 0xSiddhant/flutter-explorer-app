import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
}
