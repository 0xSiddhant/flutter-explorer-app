import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'comprehensive_navigation_observer.dart';
import 'route_observer.dart';
import '../page_transitions/page_transitions.dart';
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
  static final ComprehensiveNavigationObserver _comprehensiveObserver =
      ComprehensiveNavigationObserver();

  /// Get the route observer instance
  static AppRouteObserver get routeObserver => _routeObserver;

  /// Get the comprehensive navigation observer instance
  static ComprehensiveNavigationObserver get comprehensiveObserver =>
      _comprehensiveObserver;

  static final GoRouter router = GoRouter(
    observers: [
      _comprehensiveObserver, // Add comprehensive navigation observer
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
            pageBuilder: (BuildContext context, GoRouterState state) {
              return SlideUpAnimation.buildPage(
                child: const DetailScreen(),
                state: state,
              );
            },
          ),
          GoRoute(
            path: 'theming',
            name: 'theming',
            pageBuilder: (BuildContext context, GoRouterState state) {
              return SlideRightAnimation.buildPage(
                child: const ThemingScreen(),
                state: state,
              );
            },
          ),
          GoRoute(
            path: 'native-communication',
            name: 'native-communication',
            pageBuilder: (BuildContext context, GoRouterState state) {
              return ScaleAnimation.buildPage(
                child: const NativeCommunicationScreen(),
                state: state,
              );
            },
          ),
          GoRoute(
            path: 'background-tasks',
            name: 'background-tasks',
            pageBuilder: (BuildContext context, GoRouterState state) {
              return RotationAnimation.buildPage(
                child: const BackgroundTasksScreen(),
                state: state,
              );
            },
          ),
          GoRoute(
            path: 'internationalization',
            name: 'internationalization',
            pageBuilder: (BuildContext context, GoRouterState state) {
              return FadeScaleAnimation.buildPage(
                child: const InternationalizationScreen(),
                state: state,
              );
            },
          ),
          GoRoute(
            path: 'accessibility',
            name: 'accessibility',
            pageBuilder: (BuildContext context, GoRouterState state) {
              return SlideDiagonalAnimation.buildPage(
                child: const AccessibilityScreen(),
                state: state,
              );
            },
          ),
          GoRoute(
            path: 'file-management',
            name: 'file-management',
            pageBuilder: (BuildContext context, GoRouterState state) {
              return BounceAnimation.buildPage(
                child: const FileManagementScreen(),
                state: state,
              );
            },
          ),
          GoRoute(
            path: 'advanced-processing',
            name: 'advanced-processing',
            pageBuilder: (BuildContext context, GoRouterState state) {
              return FlipAnimation.buildPage(
                child: const AdvancedProcessingScreen(),
                state: state,
              );
            },
          ),
          GoRoute(
            path: 'navigation-analytics',
            name: 'navigation-analytics',
            pageBuilder: (BuildContext context, GoRouterState state) {
              return SlideFadeAnimation.buildPage(
                child: const NavigationAnalyticsScreen(),
                state: state,
              );
            },
          ),
          GoRoute(
            path: 'lifecycle-management',
            name: 'lifecycle-management',
            pageBuilder: (BuildContext context, GoRouterState state) {
              return SlideLeftAnimation.buildPage(
                child: const LifecycleManagementScreen(),
                state: state,
              );
            },
          ),
        ],
      ),
    ],
  );

  // Navigation methods
  static void navigateToDetailScreen(
    BuildContext context, {
    bool usePush = false,
  }) {
    if (usePush) {
      context.push('/details');
    } else {
      context.go('/details');
    }
  }

  static void navigateToTheming(BuildContext context, {bool usePush = false}) {
    if (usePush) {
      context.push('/theming');
    } else {
      context.go('/theming');
    }
  }

  static void navigateToNativeCommunication(
    BuildContext context, {
    bool usePush = false,
  }) {
    if (usePush) {
      context.push('/native-communication');
    } else {
      context.go('/native-communication');
    }
  }

  static void navigateToBackgroundTasks(
    BuildContext context, {
    bool usePush = false,
  }) {
    if (usePush) {
      context.push('/background-tasks');
    } else {
      context.go('/background-tasks');
    }
  }

  static void navigateToInternationalization(
    BuildContext context, {
    bool usePush = false,
  }) {
    if (usePush) {
      context.push('/internationalization');
    } else {
      context.go('/internationalization');
    }
  }

  static void navigateToAccessibility(
    BuildContext context, {
    bool usePush = false,
  }) {
    if (usePush) {
      context.push('/accessibility');
    } else {
      context.go('/accessibility');
    }
  }

  static void navigateToFileManagement(
    BuildContext context, {
    bool usePush = false,
  }) {
    if (usePush) {
      context.push('/file-management');
    } else {
      context.go('/file-management');
    }
  }

  static void navigateToAdvancedProcessing(
    BuildContext context, {
    bool usePush = false,
  }) {
    if (usePush) {
      context.push('/advanced-processing');
    } else {
      context.go('/advanced-processing');
    }
  }

  static void navigateToNavigationAnalytics(
    BuildContext context, {
    bool usePush = false,
  }) {
    if (usePush) {
      context.push('/navigation-analytics');
    } else {
      context.go('/navigation-analytics');
    }
  }

  static void navigateToLifecycleManagement(
    BuildContext context, {
    bool usePush = false,
  }) {
    if (usePush) {
      context.push('/lifecycle-management');
    } else {
      context.go('/lifecycle-management');
    }
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
