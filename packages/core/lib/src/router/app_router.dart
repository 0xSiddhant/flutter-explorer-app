import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'constants/route_constants.dart';
import 'generators/route_generator.dart';
import 'services/navigation_service.dart';
import 'observers/route_observer.dart';
import 'observers/comprehensive_navigation_observer.dart';

/// Main application router manager that uses modular routing components
class AppRouteManager {
  AppRouteManager._();

  // Create custom route observer instances
  static final AppRouteObserver _routeObserver = AppRouteObserver();
  static final ComprehensiveNavigationObserver _comprehensiveObserver =
      ComprehensiveNavigationObserver();

  /// Get the route observer instance
  static AppRouteObserver get routeObserver => _routeObserver;

  /// Get the comprehensive navigation observer instance
  static ComprehensiveNavigationObserver get comprehensiveObserver =>
      _comprehensiveObserver;

  /// Main GoRouter instance using modular components
  static final GoRouter router = GoRouter(
    navigatorKey: NavigationService.navigatorKey,
    observers: [
      _comprehensiveObserver, // Add comprehensive navigation observer
      _routeObserver, // Add custom route observer
    ],
    initialLocation: RouteConstants.splash.path,
    redirect: RouteGenerator.redirect,
    refreshListenable: Listenable.merge(
      RouteGenerator.generateRefreshListeners(),
    ),
    routes: [
      ...RouteGenerator.generateRoutes(),
      RouteGenerator.generateErrorRoute(),
    ],
  );

  // Generic navigation methods using NavigationService and RouteConstants
  static void navigateToRoute(
    BuildContext context,
    String route, {
    bool usePush = false,
  }) {
    NavigationService.navigateTo(route, usePush: usePush);
  }

  static void navigateToRouteByName(
    BuildContext context,
    String routeName, {
    bool usePush = false,
  }) {
    NavigationService.navigateToByName(routeName, usePush: usePush);
  }

  // Convenience methods for specific routes using RouteConstants
  static void navigateToDetailScreen(
    BuildContext context, {
    bool usePush = true,
  }) {
    NavigationService.navigateTo(RouteConstants.detail.path, usePush: usePush);
  }

  static void navigateToTheming(BuildContext context, {bool usePush = true}) {
    NavigationService.navigateTo(RouteConstants.theming.path, usePush: usePush);
  }

  static void navigateToThemeComponentShowcase(
    BuildContext context, {
    bool usePush = true,
  }) {
    NavigationService.navigateTo(
      RouteConstants.themeComponentShowcase.path,
      usePush: usePush,
    );
  }

  static void navigateToNativeCommunication(
    BuildContext context, {
    bool usePush = true,
  }) {
    NavigationService.navigateTo(
      RouteConstants.nativeCommunication.path,
      usePush: usePush,
    );
  }

  static void navigateToBackgroundTasks(
    BuildContext context, {
    bool usePush = true,
  }) {
    NavigationService.navigateTo(
      RouteConstants.backgroundTasks.path,
      usePush: usePush,
    );
  }

  static void navigateToInternationalization(
    BuildContext context, {
    bool usePush = true,
  }) {
    NavigationService.navigateTo(
      RouteConstants.internationalization.path,
      usePush: usePush,
    );
  }

  static void navigateToAccessibility(
    BuildContext context, {
    bool usePush = true,
  }) {
    NavigationService.navigateTo(
      RouteConstants.accessibility.path,
      usePush: usePush,
    );
  }

  static void navigateToFileManagement(
    BuildContext context, {
    bool usePush = true,
  }) {
    NavigationService.navigateTo(
      RouteConstants.fileManagement.path,
      usePush: usePush,
    );
  }

  static void navigateToAdvancedProcessing(
    BuildContext context, {
    bool usePush = true,
  }) {
    NavigationService.navigateTo(
      RouteConstants.advancedProcessing.path,
      usePush: usePush,
    );
  }

  static void navigateToNavigationAnalytics(
    BuildContext context, {
    bool usePush = true,
  }) {
    NavigationService.navigateTo(
      RouteConstants.navigationAnalytics.path,
      usePush: usePush,
    );
  }

  static void navigateToLifecycleManagement(
    BuildContext context, {
    bool usePush = true,
  }) {
    NavigationService.navigateTo(
      RouteConstants.lifecycleManagement.path,
      usePush: usePush,
    );
  }

  static void navigateToTypographyShowcase(
    BuildContext context, {
    bool usePush = true,
  }) {
    NavigationService.navigateTo(
      RouteConstants.typographyShowcase.path,
      usePush: usePush,
    );
  }

  /// Navigate to home screen
  static void navigateToHome(BuildContext context) {
    NavigationService.navigateTo(RouteConstants.home.path);
  }

  /// Navigate to tab screen
  static void navigateToTabScreen(BuildContext context) {
    NavigationService.navigateTo(RouteConstants.tabScreen.path);
  }

  // Navigation analytics methods
  static Map<String, dynamic> getNavigationAnalytics() {
    return _routeObserver.getNavigationAnalytics();
  }

  static List<String> getNavigationHistory() {
    return _routeObserver.navigationHistory;
  }

  static Map<String, int> getScreenVisitCount() {
    return _routeObserver.screenVisitCount;
  }

  static List<MapEntry<String, int>> getMostVisitedScreens() {
    return _routeObserver.getMostVisitedScreens();
  }

  static void clearNavigationHistory() {
    _routeObserver.clearHistory();
  }

  // Additional utility methods using NavigationService
  static void goBack() {
    NavigationService.goBack();
  }

  static bool canGoBack() {
    return NavigationService.canGoBack();
  }

  static String? getCurrentRoute() {
    return NavigationService.getCurrentRoute();
  }

  static String getCurrentRouteName() {
    return NavigationService.getCurrentRouteName();
  }

  static bool isOnRoute(String route) {
    return NavigationService.isOnRoute(route);
  }

  static bool isOnRouteName(String routeName) {
    return NavigationService.isOnRouteName(routeName);
  }

  static void clearStackAndGoHome() {
    NavigationService.clearStackAndGoHome();
  }

  static void clearStackAndGoTo(String route) {
    NavigationService.clearStackAndGoTo(route);
  }

  static void clearStackAndGoToByName(String routeName) {
    NavigationService.clearStackAndGoToByName(routeName);
  }
}
