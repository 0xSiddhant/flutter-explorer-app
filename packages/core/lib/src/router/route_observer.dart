import 'package:flutter/material.dart';

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

    _logNavigation('PUSH', routeName, previousRouteName);
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);

    final routeName = _getRouteName(route);
    final previousRouteName = previousRoute != null
        ? _getRouteName(previousRoute)
        : null;

    final timeSpent = getTimeSpentOnScreen(routeName);
    _screenEntryTimes.remove(routeName);

    _logNavigation('POP', routeName, previousRouteName, timeSpent);
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
      final timeSpent = getTimeSpentOnScreen(oldRouteName);
      _screenEntryTimes.remove(oldRouteName);
      _logNavigation('REPLACE', newRouteName, oldRouteName, timeSpent);
    }
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
        return pathMatch.group(1) ?? 'unknown';
      }
    }

    return 'unknown';
  }

  void _logNavigation(
    String action,
    String? currentRoute,
    String? previousRoute, [
    Duration? timeSpent,
  ]) {
    final timestamp = DateTime.now().toIso8601String();
    final timeSpentStr = timeSpent != null ? ' (${timeSpent.inSeconds}s)' : '';

    print(
      '🔄 Navigation: $action | Current: $currentRoute | Previous: $previousRoute$timeSpentStr | Time: $timestamp',
    );
  }
}
