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
