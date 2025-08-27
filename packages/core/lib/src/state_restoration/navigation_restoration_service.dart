import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../router/constants/route_constants.dart';
import 'state_restoration_service.dart';

/// Service for restoring the complete navigation stack
/// Handles rebuilding the navigation hierarchy when app restarts
class NavigationRestorationService {
  static final NavigationRestorationService _instance =
      NavigationRestorationService._internal();
  factory NavigationRestorationService() => _instance;
  NavigationRestorationService._internal();

  static NavigationRestorationService get instance => _instance;

  /// Restore the complete navigation stack
  /// This method should be called after the router is initialized
  Future<void> restoreNavigationStack(GoRouter router) async {
    final restorationService = StateRestorationService.instance;
    final navigationStack = restorationService.navigationStack;

    if (navigationStack.length <= 1) {
      debugPrint(
        'NavigationRestorationService: No navigation stack to restore',
      );
      return;
    }

    debugPrint(
      'NavigationRestorationService: Restoring navigation stack: $navigationStack',
    );

    try {
      // Set restoration mode to prevent duplicate route additions
      restorationService.setRestoringMode(true);

      // Restore the navigation stack in memory first
      restorationService.restoreNavigationStack(navigationStack);

      // Build the navigation stack by navigating through each route
      await _buildNavigationStack(router, navigationStack);

      // Update tab index if the restored route is a tab screen
      // Use a more robust approach with multiple attempts
      _scheduleTabIndexUpdate(restorationService.currentRoute);

      debugPrint(
        'NavigationRestorationService: Navigation stack restored successfully',
      );

      // Save state after restoration is complete
      await restorationService.saveStateAfterRestoration();

      // Ensure the final tab index is saved after restoration
      final finalTabIndex = restorationService.currentTabIndex;
      restorationService.updateTabIndexAfterRestoration(finalTabIndex);
      debugPrint(
        'NavigationRestorationService: Final tab index saved: $finalTabIndex',
      );
    } catch (e) {
      debugPrint(
        'NavigationRestorationService: Error restoring navigation stack: $e',
      );
      // Fallback to current route only
      await _navigateToRoute(router, restorationService.currentRoute);
    } finally {
      // Clear restoration mode after navigation is complete
      restorationService.setRestoringMode(false);
    }
  }

  /// Build the navigation stack by navigating through each route
  Future<void> _buildNavigationStack(
    GoRouter router,
    List<String> navigationStack,
  ) async {
    // Start from the first valid route (skip splash if it's the first)
    String startRoute = navigationStack.first;
    if (startRoute == RouteConstants.splash.path &&
        navigationStack.length > 1) {
      startRoute = navigationStack[1];
    }

    // Navigate to the start route first
    if (startRoute != RouteConstants.splash.path) {
      await _navigateToRoute(router, startRoute);
    }

    // Navigate through the rest of the stack using push
    for (int i = 2; i < navigationStack.length; i++) {
      final route = navigationStack[i];
      if (route != RouteConstants.splash.path) {
        await _pushRoute(router, route);
      }
    }
  }

  /// Navigate to a specific route
  Future<void> _navigateToRoute(GoRouter router, String route) async {
    try {
      // Use a small delay to ensure navigation completes
      await Future.delayed(const Duration(milliseconds: 100));

      if (RouteConstants.isPathValid(route)) {
        router.go(route);
        debugPrint('NavigationRestorationService: Navigated to $route');
      } else {
        debugPrint('NavigationRestorationService: Invalid route: $route');
      }
    } catch (e) {
      debugPrint(
        'NavigationRestorationService: Error navigating to $route: $e',
      );
    }
  }

  /// Push a route to the navigation stack
  Future<void> _pushRoute(GoRouter router, String route) async {
    try {
      // Use a small delay to ensure navigation completes
      await Future.delayed(const Duration(milliseconds: 100));

      if (RouteConstants.isPathValid(route)) {
        // Use push to add to navigation stack
        router.push(route);
        debugPrint('NavigationRestorationService: Pushed route: $route');
      } else {
        debugPrint('NavigationRestorationService: Invalid route: $route');
      }
    } catch (e) {
      debugPrint(
        'NavigationRestorationService: Error pushing route $route: $e',
      );
    }
  }

  /// Check if navigation restoration is needed
  bool get needsRestoration {
    final restorationService = StateRestorationService.instance;
    return restorationService.hasNavigationHistory;
  }

  /// Get the target route for restoration
  String get targetRoute {
    final restorationService = StateRestorationService.instance;
    final navigationStack = restorationService.navigationStack;

    // Return the last valid route in the stack
    for (int i = navigationStack.length - 1; i >= 0; i--) {
      final route = navigationStack[i];
      if (route != RouteConstants.splash.path &&
          RouteConstants.isPathValid(route)) {
        return route;
      }
    }

    return RouteConstants.tabScreen.path;
  }

  /// Clear navigation stack and set a new route
  void clearAndSetRoute(String route) {
    StateRestorationService.instance.clearAndSetRoute(route);
  }

  /// Get the current navigation stack for debugging
  List<String> get currentNavigationStack {
    return StateRestorationService.instance.navigationStack;
  }

  /// Schedule tab index update with retry mechanism
  void _scheduleTabIndexUpdate(String route) {
    int attempts = 0;
    const maxAttempts = 5;
    const delayMs = 100;

    void attemptUpdate() {
      attempts++;
      debugPrint(
        'NavigationRestorationService: Attempting tab index update (attempt $attempts/$maxAttempts)',
      );

      try {
        _updateTabIndexForRestoredRoute(route);
        debugPrint(
          'NavigationRestorationService: Tab index update completed successfully',
        );
      } catch (e) {
        debugPrint(
          'NavigationRestorationService: Tab index update failed (attempt $attempts): $e',
        );

        if (attempts < maxAttempts) {
          Future.delayed(
            Duration(milliseconds: delayMs * attempts),
            attemptUpdate,
          );
        } else {
          debugPrint(
            'NavigationRestorationService: Tab index update failed after $maxAttempts attempts',
          );
        }
      }
    }

    // Start the first attempt after a short delay
    Future.delayed(const Duration(milliseconds: delayMs), attemptUpdate);
  }

  /// Update tab index based on the restored route
  void _updateTabIndexForRestoredRoute(String route) {
    final restorationService = StateRestorationService.instance;

    debugPrint(
      'NavigationRestorationService: Updating tab index for route: $route',
    );

    // Map routes to tab indices
    int? targetTabIndex;

    // Check if the route should map to a specific tab
    if (route == RouteConstants.settings.path ||
        route == RouteConstants.configViewer.path) {
      // Settings and config-viewer routes -> settings tab (index 1)
      targetTabIndex = 1;
    } else if (route == RouteConstants.tabScreen.path) {
      // Tab screen route - check the current tab index from state restoration
      // If we're on tab screen, use the saved tab index
      final savedTabIndex = restorationService.currentTabIndex;
      targetTabIndex = savedTabIndex;
      // Ensure the tab index is valid (0 or 1)
      if (targetTabIndex < 0 || targetTabIndex > 1) {
        targetTabIndex = 0; // Default to home tab if invalid
      }
    } else {
      // All other routes -> home tab (index 0)
      // This includes: home, theming, theme-component-showcase,
      // and all feature routes
      targetTabIndex = 0;
    }

    // Use the restoration-specific method to avoid immediate state saving
    restorationService.updateTabIndexDuringRestoration(targetTabIndex);
  }
}
