import 'package:flutter/material.dart';
import '../constants/route_constants.dart';

/// Comprehensive navigation observer for advanced analytics and performance tracking
class ComprehensiveNavigationObserver
    extends RouteObserver<PageRoute<dynamic>> {
  // Performance tracking (unique to comprehensive observer)
  final Map<String, List<Duration>> _screenPerformanceData = {};
  final Map<String, int> _navigationErrors = {};

  // User behavior analysis (unique to comprehensive observer)
  final Map<String, List<Duration>> _timeSpentPerScreen = {};
  final List<String> _navigationPatterns = [];
  final Map<String, int> _backNavigationCount = {};

  // Session tracking (unique to comprehensive observer)
  DateTime? _sessionStartTime;
  int _totalSessionNavigations = 0;
  String? _lastVisitedScreen;

  // Advanced analytics (unique to comprehensive observer)
  final Map<String, dynamic> _navigationMetrics = {};

  /// Get performance data
  Map<String, List<Duration>> get screenPerformanceData =>
      Map.unmodifiable(_screenPerformanceData);

  /// Get navigation errors
  Map<String, int> get navigationErrors => Map.unmodifiable(_navigationErrors);

  /// Get time spent per screen
  Map<String, List<Duration>> get timeSpentPerScreen =>
      Map.unmodifiable(_timeSpentPerScreen);

  /// Get navigation patterns
  List<String> get navigationPatterns => List.unmodifiable(_navigationPatterns);

  /// Get session duration
  Duration? get sessionDuration {
    if (_sessionStartTime == null) return null;
    return DateTime.now().difference(_sessionStartTime!);
  }

  /// Get average time spent on a screen
  Duration getAverageTimeSpentOnScreen(String routeName) {
    final times = _timeSpentPerScreen[routeName];
    if (times == null || times.isEmpty) return Duration.zero;

    final totalMilliseconds = times.fold<int>(
      0,
      (sum, duration) => sum + duration.inMilliseconds,
    );
    return Duration(milliseconds: totalMilliseconds ~/ times.length);
  }

  /// Get screens with highest average time spent
  List<MapEntry<String, Duration>> getScreensWithHighestTimeSpent() {
    final entries = _timeSpentPerScreen.entries.map((entry) {
      return MapEntry(entry.key, getAverageTimeSpentOnScreen(entry.key));
    }).toList();

    entries.sort((a, b) => b.value.compareTo(a.value));
    return entries;
  }

  /// Get comprehensive analytics with advanced metrics
  Map<String, dynamic> getComprehensiveAnalytics() {
    return {
      'performanceMetrics': _getPerformanceMetrics(),
      'userBehaviorMetrics': _getUserBehaviorMetrics(),
      'navigationErrors': _navigationErrors,
      'backNavigationCount': _backNavigationCount,
      'screensWithHighestTimeSpent': getScreensWithHighestTimeSpent()
          .take(5)
          .map((e) => {'screen': e.key, 'avgTime': e.value.inSeconds})
          .toList(),
      'sessionDuration': sessionDuration,
      'totalSessionNavigations': _totalSessionNavigations,
      'lastVisitedScreen': _lastVisitedScreen,
      'navigationPatterns': _navigationPatterns,
    };
  }

  /// Get performance metrics
  Map<String, dynamic> _getPerformanceMetrics() {
    final metrics = <String, dynamic>{};

    _screenPerformanceData.forEach((screen, durations) {
      if (durations.isNotEmpty) {
        final avgDuration =
            durations.fold<int>(0, (sum, d) => sum + d.inMilliseconds) ~/
            durations.length;
        metrics[screen] = {
          'averageLoadTime': Duration(milliseconds: avgDuration),
          'totalLoads': durations.length,
          'fastestLoad': durations.reduce((a, b) => a < b ? a : b),
          'slowestLoad': durations.reduce((a, b) => a > b ? a : b),
        };
      }
    });

    return metrics;
  }

  /// Get user behavior metrics
  Map<String, dynamic> _getUserBehaviorMetrics() {
    return {
      'totalBackNavigations': _backNavigationCount.values.fold<int>(
        0,
        (sum, count) => sum + count,
      ),
      'mostFrequentBackNavigation': _backNavigationCount.isNotEmpty
          ? _backNavigationCount.entries
                .reduce((a, b) => a.value > b.value ? a : b)
                .key
          : null,
      'averageSessionDuration': sessionDuration?.inMinutes ?? 0,
      'navigationEfficiency': _calculateNavigationEfficiency(),
      'userEngagementScore': _calculateUserEngagementScore(),
    };
  }

  /// Calculate navigation efficiency (ratio of forward to back navigations)
  double _calculateNavigationEfficiency() {
    final totalBackNavigations = _backNavigationCount.values.fold<int>(
      0,
      (sum, count) => sum + count,
    );
    if (_totalSessionNavigations == 0) return 0.0;

    return (_totalSessionNavigations - totalBackNavigations) /
        _totalSessionNavigations;
  }

  /// Calculate user engagement score based on time spent and navigation patterns
  double _calculateUserEngagementScore() {
    if (_totalSessionNavigations == 0) return 0.0;

    final avgTimePerScreen = _calculateAverageTimePerScreen();
    final navigationEfficiency = _calculateNavigationEfficiency();
    final uniqueScreensRatio =
        _timeSpentPerScreen.length / _totalSessionNavigations;

    // Weighted score: 40% time spent, 30% efficiency, 30% screen diversity
    return (avgTimePerScreen * 0.4) +
        (navigationEfficiency * 30) +
        (uniqueScreensRatio * 30);
  }

  /// Calculate average time spent per screen
  double _calculateAverageTimePerScreen() {
    if (_timeSpentPerScreen.isEmpty) return 0.0;

    final totalTime = _timeSpentPerScreen.values.fold<Duration>(
      Duration.zero,
      (total, durations) =>
          total +
          durations.fold<Duration>(
            Duration.zero,
            (sum, duration) => sum + duration,
          ),
    );

    return totalTime.inSeconds / _timeSpentPerScreen.length;
  }

  /// Clear all comprehensive analytics data
  void clearComprehensiveData() {
    _screenPerformanceData.clear();
    _navigationErrors.clear();
    _timeSpentPerScreen.clear();
    _navigationPatterns.clear();
    _backNavigationCount.clear();
    _sessionStartTime = null;
    _totalSessionNavigations = 0;
    _lastVisitedScreen = null;
    _navigationMetrics.clear();
  }

  /// Start a new session
  void startSession() {
    _sessionStartTime = DateTime.now();
    _totalSessionNavigations = 0;
    print('🟢 Session started at ${_sessionStartTime!.toIso8601String()}');
  }

  /// End current session
  void endSession() {
    if (_sessionStartTime != null) {
      final duration = DateTime.now().difference(_sessionStartTime!);
      print(
        '🔴 Session ended | Duration: ${duration.inMinutes}m ${duration.inSeconds % 60}s | Total navigations: $_totalSessionNavigations',
      );
      _sessionStartTime = null;
    }
  }

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);

    final routeName = _getRouteName(route);
    final previousRouteName = previousRoute != null
        ? _getRouteName(previousRoute)
        : null;

    // Initialize session if not started
    if (_sessionStartTime == null) {
      startSession();
    }

    _lastVisitedScreen = routeName;
    _totalSessionNavigations++;

    // Track navigation pattern
    if (previousRouteName != null) {
      _navigationPatterns.add('$previousRouteName → $routeName');
    }

    // Performance tracking
    _trackScreenPerformance(routeName);

    _logNavigation('PUSH', routeName, previousRouteName);
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);

    final routeName = _getRouteName(route);
    final previousRouteName = previousRoute != null
        ? _getRouteName(previousRoute)
        : null;

    final timeSpent = _calculateTimeSpent(routeName);

    // Track time spent
    if (timeSpent != null) {
      _timeSpentPerScreen.putIfAbsent(routeName, () => []).add(timeSpent);
    }

    // Track back navigation
    if (previousRouteName != null) {
      _backNavigationCount[previousRouteName] =
          (_backNavigationCount[previousRouteName] ?? 0) + 1;
    }

    _logNavigation('POP', routeName, previousRouteName, timeSpent);
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);

    final newRouteName = newRoute != null ? _getRouteName(newRoute) : null;
    final oldRouteName = oldRoute != null ? _getRouteName(oldRoute) : null;

    if (newRouteName != null) {
      _lastVisitedScreen = newRouteName;
      _totalSessionNavigations++;
    }

    if (oldRouteName != null) {
      final timeSpent = _calculateTimeSpent(oldRouteName);

      if (timeSpent != null) {
        _timeSpentPerScreen.putIfAbsent(oldRouteName, () => []).add(timeSpent);
      }

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

    final timeSpent = _calculateTimeSpent(routeName);

    if (timeSpent != null) {
      _timeSpentPerScreen.putIfAbsent(routeName, () => []).add(timeSpent);
    }

    _logNavigation('REMOVE', routeName, previousRouteName, timeSpent);
  }

  /// Track screen performance (simulated load time)
  void _trackScreenPerformance(String routeName) {
    // Simulate performance tracking - in real app, you'd measure actual load times
    final loadTime = Duration(
      milliseconds: 100 + (DateTime.now().millisecond % 500),
    );
    _screenPerformanceData.putIfAbsent(routeName, () => []).add(loadTime);
  }

  /// Record navigation error
  void recordNavigationError(String routeName, String error) {
    _navigationErrors[routeName] = (_navigationErrors[routeName] ?? 0) + 1;
    print('❌ Navigation Error: $routeName - $error');
  }

  /// Calculate time spent on a route (simplified for comprehensive observer)
  Duration? _calculateTimeSpent(String routeName) {
    // This is a simplified calculation - in a real app, you'd track entry/exit times
    return Duration(
      seconds: 5 + (DateTime.now().second % 30),
    ); // Simulated time
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
    final timePart = timeSpent != null
        ? ' | timeSpent=${timeSpent.inSeconds}s'
        : '';

    final sessionInfo = _sessionStartTime != null
        ? ' | session=${sessionDuration?.inMinutes}m'
        : '';

    print(
      '$actionIcon $action: $prev → $curr | @ $timestamp$timePart$sessionInfo',
    );
  }
}
