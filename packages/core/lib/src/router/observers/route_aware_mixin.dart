import 'package:flutter/material.dart';
import 'route_observer.dart';

/// Mixin for screens to track navigation lifecycle
mixin RouteAwareMixin<T extends StatefulWidget> on State<T>
    implements RouteAware {
  AppRouteObserver? _routeObserver;
  String? _currentRouteName;

  /// Get current route name
  String? get currentRouteName => _currentRouteName;

  /// Get time spent on current screen
  Duration? get timeSpentOnScreen {
    if (_currentRouteName != null && _routeObserver != null) {
      return _routeObserver!.getTimeSpentOnScreen(_currentRouteName!);
    }
    return null;
  }

  /// Called when screen becomes visible
  void onScreenVisible() {
    // Override in subclasses
  }

  /// Called when screen becomes invisible
  void onScreenInvisible() {
    // Override in subclasses
  }

  /// Called when screen is pushed
  void onScreenPushed() {
    // Override in subclasses
  }

  /// Called when screen is popped
  void onScreenPopped() {
    // Override in subclasses
  }

  /// Called when screen is replaced
  void onScreenReplaced() {
    // Override in subclasses
  }

  /// Get navigation analytics
  Map<String, dynamic>? getNavigationAnalytics() {
    return _routeObserver?.getNavigationAnalytics();
  }

  /// Get screen visit count
  int getScreenVisitCount(String routeName) {
    return _routeObserver?.screenVisitCount[routeName] ?? 0;
  }

  /// Get screen performance metrics
  Map<String, dynamic> getScreenPerformanceMetrics() {
    if (_currentRouteName == null || _routeObserver == null) {
      return {};
    }

    final visitCount = getScreenVisitCount(_currentRouteName!);
    final entryTime = _routeObserver!.getCurrentScreenEntryTime(
      _currentRouteName!,
    );
    final timeSpent = timeSpentOnScreen;

    return {
      'routeName': _currentRouteName,
      'visitCount': visitCount,
      'entryTime': entryTime?.toIso8601String(),
      'timeSpent': timeSpent?.inSeconds,
      'isCurrentlyVisible': _currentRouteName != null,
    };
  }

  /// Get navigation insights
  Map<String, dynamic> getNavigationInsights() {
    final analytics = getNavigationAnalytics();
    if (analytics == null) return {};

    return {
      'totalNavigations': analytics['totalNavigations'],
      'uniqueScreens': analytics['uniqueScreens'],
      'mostVisitedScreen': analytics['mostVisitedScreen'],
      'averageTimePerScreen': analytics['averageTimePerScreen'],
      'navigationPattern': analytics['navigationPattern'],
      'sessionDuration': analytics['sessionDuration'],
    };
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Get the route observer from the navigator
    final navigator = Navigator.of(context);
    if (navigator.widget.observers.isNotEmpty) {
      for (final observer in navigator.widget.observers) {
        if (observer is AppRouteObserver) {
          _routeObserver = observer;
          break;
        }
      }
    }

    // Subscribe to route changes
    _routeObserver?.subscribe(this, ModalRoute.of(context) as PageRoute);

    // Extract current route name
    final route = ModalRoute.of(context);
    if (route != null) {
      _currentRouteName = route.settings.name;
    }
  }

  @override
  void dispose() {
    // Unsubscribe from route changes
    _routeObserver?.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPopNext() {
    // Screen became visible after another screen was popped
    onScreenVisible();
  }

  @override
  void didPop() {
    // Screen was popped
    onScreenPopped();
  }

  @override
  void didPush() {
    // Screen was pushed
    onScreenPushed();
  }

  @override
  void didPushNext() {
    // Another screen was pushed on top
    onScreenInvisible();
  }
}
