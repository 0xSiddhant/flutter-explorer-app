import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'constants/route_constants.dart';

/// Simplified deep link manager for handling custom URL schemes
/// Works directly with GoRouter for clean navigation
class DeepLinkManager {
  static final DeepLinkManager _instance = DeepLinkManager._internal();
  factory DeepLinkManager() => _instance;
  DeepLinkManager._internal();

  static DeepLinkManager get instance => _instance;

  /// Handle deep link navigation - simplified approach
  Future<void> handleDeepLink(String url, GoRouter router) async {
    try {
      debugPrint('DeepLinkManager: Handling deep link: $url');

      // Validate scheme
      if (!url.startsWith('${RouteConstants.deepLinkScheme}://')) {
        debugPrint('DeepLinkManager: Invalid scheme, navigating to home');
        router.go(RouteConstants.tabScreen.path);
        return;
      }

      // Parse URL
      final uri = Uri.parse(url);
      final path = uri.path.isEmpty ? uri.host : uri.path;
      final queryParameters = uri.queryParameters;

      debugPrint('DeepLinkManager: Path: $path, Parameters: $queryParameters');

      // Check if deep link is allowed
      if (!RouteConstants.isDeepLinkAllowed(path)) {
        debugPrint(
          'DeepLinkManager: Deep link not allowed, navigating to home',
        );
        router.go(RouteConstants.tabScreen.path);
        return;
      }

      // Get mapped route
      final routeModel = RouteConstants.getRouteForDeepLink(path);
      if (routeModel == null) {
        debugPrint(
          'DeepLinkManager: No route mapping found, navigating to home',
        );
        router.go(RouteConstants.tabScreen.path);
        return;
      }

      // Build route with parameters
      final targetRoute = _buildRouteWithParams(
        routeModel.path,
        queryParameters,
      );

      // Navigate directly using GoRouter
      if (routeModel.path == RouteConstants.tabScreen.path) {
        // If target is tab screen, use go()
        router.go(targetRoute);
      } else {
        // For other routes, ensure we're on tab screen first, then push
        router.go(RouteConstants.tabScreen.path);
        await Future.delayed(const Duration(milliseconds: 100));
        router.push(targetRoute);
      }

      debugPrint('DeepLinkManager: Navigation completed to: $targetRoute');
    } catch (e) {
      debugPrint('DeepLinkManager: Error handling deep link: $e');
      router.go(RouteConstants.tabScreen.path);
    }
  }

  /// Build route with parameters as query string
  String _buildRouteWithParams(String route, Map<String, String> parameters) {
    if (parameters.isEmpty) {
      return route;
    }

    final queryParams = parameters.entries
        .map(
          (e) =>
              '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}',
        )
        .join('&');

    return '$route?$queryParams';
  }

  /// Get the deep link scheme
  String get scheme => RouteConstants.deepLinkScheme;

  /// Get all allowed deep links
  Set<String> get allowedDeepLinks => RouteConstants.getAllowedDeepLinks();

  /// Check if a deep link is allowed
  bool isDeepLinkAllowed(String path) {
    return RouteConstants.isDeepLinkAllowed(path);
  }

  /// Get route mapping for a deep link
  String? getRouteForDeepLink(String path) {
    final routeModel = RouteConstants.getRouteForDeepLink(path);
    return routeModel?.path;
  }

  /// Debug method to print all deep link mappings
  void debugDeepLinkMappings() {
    debugPrint('=== Deep Link Mappings ===');
    debugPrint('Scheme: ${RouteConstants.deepLinkScheme}');
    debugPrint('Allowed deep links: ${RouteConstants.getAllowedDeepLinks()}');

    RouteConstants.deepLinkRoutes.forEach((key, value) {
      debugPrint('$key -> ${value.path}');
    });
    debugPrint('========================');
  }
}
