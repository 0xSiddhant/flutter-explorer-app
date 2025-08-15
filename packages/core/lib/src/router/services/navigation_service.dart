import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../constants/route_constants.dart';

/// Global navigation service that provides centralized navigation functionality
class NavigationService {
  // Private constructor to prevent instantiation
  NavigationService._();

  /// Global navigation key for accessing navigation context from anywhere
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  /// Get the current navigation context
  static BuildContext? get context => navigatorKey.currentContext;

  /// Get the current GoRouter instance
  static GoRouter? get router => GoRouter.of(context!);

  /// Navigate to a route using GoRouter
  static void navigateTo(String route, {bool usePush = false}) {
    if (context == null) return;

    if (usePush) {
      context!.push(route);
    } else {
      context!.go(route);
    }
  }

  /// Navigate to a route by route name
  static void navigateToByName(String routeName, {bool usePush = false}) {
    final route = RouteConstants.getPathFromRouteName(routeName);
    navigateTo(route, usePush: usePush);
  }

  /// Navigate back
  static void goBack() {
    if (context == null) return;
    context!.pop();
  }

  /// Check if can go back
  static bool canGoBack() {
    if (context == null) return false;
    return Navigator.canPop(context!);
  }

  /// Get current route path
  static String? getCurrentRoute() {
    if (router == null) return null;
    return router!.routerDelegate.currentConfiguration.uri.path;
  }

  /// Get current route name
  static String getCurrentRouteName() {
    final currentRoute = getCurrentRoute();
    if (currentRoute == null) return 'unknown';
    return RouteConstants.getRouteNameFromPath(currentRoute);
  }

  /// Check if currently on a specific route
  static bool isOnRoute(String route) {
    return getCurrentRoute() == route;
  }

  /// Check if currently on a specific route name
  static bool isOnRouteName(String routeName) {
    final route = RouteConstants.getPathFromRouteName(routeName);
    return isOnRoute(route);
  }

  /// Clear navigation stack and go to home
  static void clearStackAndGoHome() {
    if (context == null) return;
    context!.go(RouteConstants.home.path);
  }

  /// Clear navigation stack and go to a specific route
  static void clearStackAndGoTo(String route) {
    if (context == null) return;
    context!.go(route);
  }

  /// Clear navigation stack and go to a specific route by name
  static void clearStackAndGoToByName(String routeName) {
    final route = RouteConstants.getPathFromRouteName(routeName);
    clearStackAndGoTo(route);
  }
}
