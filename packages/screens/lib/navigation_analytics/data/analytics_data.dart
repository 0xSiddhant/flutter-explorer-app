import 'package:core/core.dart';
import '../models/analytics_model.dart';

/// Data provider for navigation analytics
class AnalyticsData {
  static AnalyticsModel getAnalytics() {
    final analyticsMap = AppRouteManager.getNavigationAnalytics();
    return AnalyticsModel.fromMap(analyticsMap);
  }

  static List<String> getNavigationHistory() {
    return AppRouteManager.getNavigationHistory();
  }

  static Map<String, int> getScreenVisitCount() {
    return AppRouteManager.getScreenVisitCount();
  }

  static List<MapEntry<String, int>> getMostVisitedScreens() {
    return AppRouteManager.getMostVisitedScreens();
  }

  static void clearHistory() {
    AppRouteManager.clearNavigationHistory();
  }

  // New comprehensive analytics methods
  static Map<String, List<Duration>> getScreenPerformanceData() {
    return AppRouteManager.comprehensiveObserver.screenPerformanceData;
  }

  static Map<String, int> getNavigationErrors() {
    return AppRouteManager.comprehensiveObserver.navigationErrors;
  }

  static Map<String, List<Duration>> getTimeSpentPerScreen() {
    return AppRouteManager.comprehensiveObserver.timeSpentPerScreen;
  }

  static List<String> getNavigationPatterns() {
    return AppRouteManager.comprehensiveObserver.navigationPatterns;
  }

  static Duration? getSessionDuration() {
    return AppRouteManager.comprehensiveObserver.sessionDuration;
  }

  static List<MapEntry<String, Duration>> getScreensWithHighestTimeSpent() {
    return AppRouteManager.comprehensiveObserver
        .getScreensWithHighestTimeSpent();
  }

  static Duration getAverageTimeSpentOnScreen(String routeName) {
    return AppRouteManager.comprehensiveObserver.getAverageTimeSpentOnScreen(
      routeName,
    );
  }

  static void recordNavigationError(String routeName, String error) {
    AppRouteManager.comprehensiveObserver.recordNavigationError(
      routeName,
      error,
    );
  }

  static void startSession() {
    AppRouteManager.comprehensiveObserver.startSession();
  }

  static void endSession() {
    AppRouteManager.comprehensiveObserver.endSession();
  }

  static Map<String, dynamic> getComprehensiveAnalytics() {
    return AppRouteManager.comprehensiveObserver.getComprehensiveAnalytics();
  }

  static void clearComprehensiveData() {
    AppRouteManager.comprehensiveObserver.clearComprehensiveData();
  }

  static String formatRouteName(String routeName) {
    switch (routeName) {
      case 'home':
        return 'Home';
      case 'details':
        return 'Details';
      case 'theming':
        return 'Theming';
      case 'native-communication':
        return 'Native Communication';
      case 'background-tasks':
        return 'Background Tasks';
      case 'internationalization':
        return 'Internationalization';
      case 'accessibility':
        return 'Accessibility';
      case 'file-management':
        return 'File Management';
      case 'advanced-processing':
        return 'Advanced Processing';
      case 'navigation-analytics':
        return 'Navigation Analytics';
      case 'lifecycle-demo':
        return 'Lifecycle Demo';
      default:
        return routeName;
    }
  }
}
