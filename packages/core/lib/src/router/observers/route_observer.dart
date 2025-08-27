import 'package:flutter/material.dart';
import '../constants/route_constants.dart';
import '../../state_restoration/state_restoration_service.dart';

/// Custom route observer for tracking navigation state and analytics
class AppRouteObserver extends RouteObserver<PageRoute<dynamic>> {
  final List<String> _navigationHistory = [];
  final Map<String, int> _screenVisitCount = {};
  final Map<String, DateTime> _screenEntryTimes = {};

  /// Get navigation history
  List<String> get navigationHistory => List.unmodifiable(_navigationHistory);

  /// Get screen visit counts
  Map<String, int> get screenVisitCount => Map.unmodifiable(_screenVisitCount);

  /// Get current screen entry time
  DateTime? getCurrentScreenEntryTime(String routeName) {
    return _screenEntryTimes[routeName];
  }

  /// Get time spent on a specific screen
  Duration? getTimeSpentOnScreen(String routeName) {
    final entryTime = _screenEntryTimes[routeName];
    if (entryTime != null) {
      return DateTime.now().difference(entryTime);
    }
    return null;
  }

  /// Get most visited screens
  List<MapEntry<String, int>> getMostVisitedScreens() {
    final sortedEntries = _screenVisitCount.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    return sortedEntries;
  }

  /// Get navigation analytics
  Map<String, dynamic> getNavigationAnalytics() {
    return {
      'totalNavigations': _navigationHistory.length,
      'uniqueScreens': _screenVisitCount.length,
      'mostVisitedScreen': _screenVisitCount.isNotEmpty
          ? _screenVisitCount.entries
                .reduce((a, b) => a.value > b.value ? a : b)
                .key
          : null,
      'screenVisitCount': _screenVisitCount,
      'navigationHistory': _navigationHistory,
      'averageTimePerScreen': _calculateAverageTimePerScreen(),
      'navigationPattern': _analyzeNavigationPattern(),
      'sessionDuration': _calculateSessionDuration(),
    };
  }

  /// Calculate average time spent per screen
  double _calculateAverageTimePerScreen() {
    if (_screenVisitCount.isEmpty) return 0.0;

    final totalTime = _screenEntryTimes.values.fold<Duration>(
      Duration.zero,
      (total, entryTime) => total + DateTime.now().difference(entryTime),
    );

    return totalTime.inSeconds / _screenVisitCount.length;
  }

  /// Analyze navigation pattern
  Map<String, dynamic> _analyzeNavigationPattern() {
    if (_navigationHistory.length < 2) {
      return {'pattern': 'Insufficient data', 'frequency': 0};
    }

    final patterns = <String, int>{};
    for (int i = 0; i < _navigationHistory.length - 1; i++) {
      final pattern = '${_navigationHistory[i]} → ${_navigationHistory[i + 1]}';
      patterns[pattern] = (patterns[pattern] ?? 0) + 1;
    }

    final mostCommonPattern = patterns.entries.reduce(
      (a, b) => a.value > b.value ? a : b,
    );

    return {
      'mostCommonPattern': mostCommonPattern.key,
      'patternFrequency': mostCommonPattern.value,
      'totalPatterns': patterns.length,
    };
  }

  /// Calculate session duration
  Duration _calculateSessionDuration() {
    if (_navigationHistory.isEmpty) return Duration.zero;

    // This is a simplified calculation - in a real app, you'd store timestamps
    return Duration(minutes: _navigationHistory.length * 2); // Estimate
  }

  /// Clear navigation history
  void clearHistory() {
    _navigationHistory.clear();
    _screenVisitCount.clear();
    _screenEntryTimes.clear();
  }

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);

    final routeName = _getRouteName(route);
    final previousRouteName = previousRoute != null
        ? _getRouteName(previousRoute)
        : null;

    _navigationHistory.add(routeName);
    _screenVisitCount[routeName] = (_screenVisitCount[routeName] ?? 0) + 1;
    _screenEntryTimes[routeName] = DateTime.now();

    // Update state restoration service with current route
    // Skip splash screen navigation as it's the initial route
    // Skip during restoration mode to avoid duplicate tracking
    final currentPath = _getRoutePath(route);
    if (currentPath != null &&
        currentPath != RouteConstants.splash.path &&
        !StateRestorationService.instance.isRestoring) {
      // Check if this is a push navigation or a go navigation
      final isPushNavigation = _isPushNavigation(route, previousRoute);

      if (isPushNavigation) {
        StateRestorationService.instance.pushRoute(currentPath);
      } else {
        // This is a go navigation, clear the stack and set new route
        StateRestorationService.instance.navigateToRoute(currentPath);
      }

      // Validate navigation stack after navigation
      StateRestorationService.instance.validateNavigationStack();
    }

    _logNavigation('PUSH', routeName, previousRouteName);
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);

    final routeName = _getRouteName(route);
    final previousRouteName = previousRoute != null
        ? _getRouteName(previousRoute)
        : null;

    _screenEntryTimes.remove(routeName);

    // Update state restoration service - pop the route
    // Only pop if we're not in restoration mode
    if (!StateRestorationService.instance.isRestoring) {
      StateRestorationService.instance.popRoute();

      // Validate navigation stack after pop
      StateRestorationService.instance.validateNavigationStack();
    }

    _logNavigation('POP', routeName, previousRouteName);
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);

    final newRouteName = newRoute != null ? _getRouteName(newRoute) : null;
    final oldRouteName = oldRoute != null ? _getRouteName(oldRoute) : null;

    if (newRouteName != null) {
      _navigationHistory.add(newRouteName);
      _screenVisitCount[newRouteName] =
          (_screenVisitCount[newRouteName] ?? 0) + 1;
      _screenEntryTimes[newRouteName] = DateTime.now();
    }

    if (oldRouteName != null) {
      _screenEntryTimes.remove(oldRouteName);
    }

    // Update state restoration service - replace the route
    // Only replace if we're not in restoration mode
    if (!StateRestorationService.instance.isRestoring) {
      final newPath = newRoute != null ? _getRoutePath(newRoute) : null;
      if (newPath != null) {
        StateRestorationService.instance.replaceRoute(newPath);
      }
    }

    _logNavigation('REPLACE', newRouteName, oldRouteName);
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didRemove(route, previousRoute);

    final routeName = _getRouteName(route);
    final previousRouteName = previousRoute != null
        ? _getRouteName(previousRoute)
        : null;

    final timeSpent = getTimeSpentOnScreen(routeName);
    _screenEntryTimes.remove(routeName);

    _logNavigation('REMOVE', routeName, previousRouteName, timeSpent);
  }

  String _getRouteName(Route<dynamic> route) {
    if (route.settings.name != null) {
      return route.settings.name!;
    }

    // Extract route name from route object
    final routeString = route.toString();
    if (routeString.contains('GoRoute')) {
      // Extract path from GoRoute
      final pathMatch = RegExp(r"path: '([^']+)'").firstMatch(routeString);
      if (pathMatch != null) {
        final path = pathMatch.group(1);
        if (path != null) {
          // Convert path to route name using RouteConstants
          return RouteConstants.getRouteNameFromPath(path);
        }
      }
    }

    return 'unknown';
  }

  String? _getRoutePath(Route<dynamic> route) {
    // Extract path from route object
    final routeString = route.toString();
    if (routeString.contains('GoRoute')) {
      // Extract path from GoRoute
      final pathMatch = RegExp(r"path: '([^']+)'").firstMatch(routeString);
      if (pathMatch != null) {
        return pathMatch.group(1);
      }
    }

    // Try to get path from route settings
    if (route.settings.name != null) {
      final routeModel = RouteConstants.getRouteFromName(route.settings.name!);
      return routeModel?.path;
    }

    return null;
  }

  /// Check if this is a push navigation (adds to stack) vs go navigation (replaces stack)
  bool _isPushNavigation(Route<dynamic> route, Route<dynamic>? previousRoute) {
    // If there's no previous route, this is likely a go navigation
    if (previousRoute == null) {
      return false;
    }

    // Check if the previous route is still in the navigation stack
    final previousPath = _getRoutePath(previousRoute);
    if (previousPath != null) {
      final restorationService = StateRestorationService.instance;
      return restorationService.navigationStack.contains(previousPath);
    }

    // Default to push navigation for safety
    return true;
  }

  void _logNavigation(
    String action,
    String? currentRoute,
    String? previousRoute, [
    Duration? timeSpent,
  ]) {
    final timestamp = DateTime.now().toIso8601String();
    final actionIcon =
        {'PUSH': '➡️', 'POP': '⬅️', 'REPLACE': '♻️', 'REMOVE': '🗑️'}[action] ??
        '🔄';

    final prev = previousRoute?.isNotEmpty == true ? previousRoute : '-';
    final curr = currentRoute?.isNotEmpty == true ? currentRoute : '-';
    final visitCount = currentRoute != null
        ? (_screenVisitCount[currentRoute] ?? 0)
        : 0;
    final timePart = timeSpent != null
        ? ' | timeSpent=${timeSpent.inSeconds}s'
        : '';

    print(
      '$actionIcon $action: $prev → $curr | visit#$visitCount | @ $timestamp$timePart',
    );
  }
}
