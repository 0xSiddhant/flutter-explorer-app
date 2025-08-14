import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'navigation_observer.dart';
import 'route_observer.dart';
import 'package:screens/detail_screen/detail_screen.dart';
import 'package:screens/tab_screen/tab_screen.dart';
import 'package:screens/theming/theming_screen.dart';
import 'package:screens/native_communication/native_communication_screen.dart';
import 'package:screens/background_tasks/background_tasks_screen.dart';
import 'package:screens/internationalization/internationalization_screen.dart';
import 'package:screens/accessibility/accessibility_screen.dart';
import 'package:screens/file_management/file_management_screen.dart';
import 'package:screens/advanced_processing/advanced_processing_screen.dart';
import 'package:screens/navigation_analytics/navigation_analytics_screen.dart';
import 'package:screens/lifecycle_management/lifecycle_management_screen.dart';
import 'package:screens/splash_screen/splash_screen.dart';

class AppRouteManager {
  AppRouteManager._();

  // Create custom route observer instance
  static final AppRouteObserver _routeObserver = AppRouteObserver();

  /// Get the route observer instance
  static AppRouteObserver get routeObserver => _routeObserver;

  static final GoRouter router = GoRouter(
    observers: [
      MyNavigatorObserver(),
      _routeObserver, // Add custom route observer
    ],
    initialLocation: '/splash',
    routes: <RouteBase>[
      GoRoute(
        path: '/splash',
        name: 'splash',
        builder: (BuildContext context, GoRouterState state) {
          return const SplashScreen();
        },
      ),
      GoRoute(
        path: '/',
        name: 'home',
        builder: (BuildContext context, GoRouterState state) {
          return const TabScreen();
        },
        routes: <RouteBase>[
          GoRoute(
            path: 'details',
            name: 'details',
            builder: (BuildContext context, GoRouterState state) {
              return const DetailScreen();
            },
          ),
          GoRoute(
            path: 'theming',
            name: 'theming',
            builder: (BuildContext context, GoRouterState state) {
              return const ThemingScreen();
            },
          ),
          GoRoute(
            path: 'native-communication',
            name: 'native-communication',
            builder: (BuildContext context, GoRouterState state) {
              return const NativeCommunicationScreen();
            },
          ),
          GoRoute(
            path: 'background-tasks',
            name: 'background-tasks',
            builder: (BuildContext context, GoRouterState state) {
              return const BackgroundTasksScreen();
            },
          ),
          GoRoute(
            path: 'internationalization',
            name: 'internationalization',
            builder: (BuildContext context, GoRouterState state) {
              return const InternationalizationScreen();
            },
          ),
          GoRoute(
            path: 'accessibility',
            name: 'accessibility',
            builder: (BuildContext context, GoRouterState state) {
              return const AccessibilityScreen();
            },
          ),
          GoRoute(
            path: 'file-management',
            name: 'file-management',
            builder: (BuildContext context, GoRouterState state) {
              return const FileManagementScreen();
            },
          ),
          GoRoute(
            path: 'advanced-processing',
            name: 'advanced-processing',
            builder: (BuildContext context, GoRouterState state) {
              return const AdvancedProcessingScreen();
            },
          ),
          GoRoute(
            path: 'navigation-analytics',
            name: 'navigation-analytics',
            builder: (BuildContext context, GoRouterState state) {
              return const NavigationAnalyticsScreen();
            },
          ),
          GoRoute(
            path: 'lifecycle-management',
            name: 'lifecycle-management',
            builder: (BuildContext context, GoRouterState state) {
              return const LifecycleManagementScreen();
            },
          ),
        ],
      ),
    ],
  );

  // Navigation methods
  static void navigateToDetailScreen(BuildContext context) {
    context.go('/details');
  }

  static void navigateToTheming(BuildContext context) {
    context.go('/theming');
  }

  static void navigateToNativeCommunication(BuildContext context) {
    context.go('/native-communication');
  }

  static void navigateToBackgroundTasks(BuildContext context) {
    context.go('/background-tasks');
  }

  static void navigateToInternationalization(BuildContext context) {
    context.go('/internationalization');
  }

  static void navigateToAccessibility(BuildContext context) {
    context.go('/accessibility');
  }

  static void navigateToFileManagement(BuildContext context) {
    context.go('/file-management');
  }

  static void navigateToAdvancedProcessing(BuildContext context) {
    context.go('/advanced-processing');
  }

  static void navigateToNavigationAnalytics(BuildContext context) {
    context.go('/navigation-analytics');
  }

  static void navigateToLifecycleManagement(BuildContext context) {
    context.go('/lifecycle-management');
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

  /// Navigate to home screen
  static void navigateToHome(BuildContext context) {
    context.go('/');
  }
}
