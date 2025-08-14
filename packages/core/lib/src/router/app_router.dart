import 'package:core/src/router/navigation_observer.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:screens/detail_screen/detail_screen.dart';
import 'package:screens/tab_screen/tab_screen.dart';
import 'package:screens/theming/theming_screen.dart';
import 'package:screens/native_communication/native_communication_screen.dart';
import 'package:screens/background_tasks/background_tasks_screen.dart';
import 'package:screens/internationalization/internationalization_screen.dart';
import 'package:screens/accessibility/accessibility_screen.dart';
import 'package:screens/file_management/file_management_screen.dart';
import 'package:screens/advanced_processing/advanced_processing_screen.dart';

class AppRouteManager {
  AppRouteManager._();

  static final GoRouter router = GoRouter(
    observers: [MyNavigatorObserver()],
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return const TabScreen();
        },
        routes: <RouteBase>[
          GoRoute(
            path: 'details',
            builder: (BuildContext context, GoRouterState state) {
              return const DetailScreen();
            },
          ),
          GoRoute(
            path: 'theming',
            builder: (BuildContext context, GoRouterState state) {
              return const ThemingScreen();
            },
          ),
          GoRoute(
            path: 'native-communication',
            builder: (BuildContext context, GoRouterState state) {
              return const NativeCommunicationScreen();
            },
          ),
          GoRoute(
            path: 'background-tasks',
            builder: (BuildContext context, GoRouterState state) {
              return const BackgroundTasksScreen();
            },
          ),
          GoRoute(
            path: 'internationalization',
            builder: (BuildContext context, GoRouterState state) {
              return const InternationalizationScreen();
            },
          ),
          GoRoute(
            path: 'accessibility',
            builder: (BuildContext context, GoRouterState state) {
              return const AccessibilityScreen();
            },
          ),
          GoRoute(
            path: 'file-management',
            builder: (BuildContext context, GoRouterState state) {
              return const FileManagementScreen();
            },
          ),
          GoRoute(
            path: 'advanced-processing',
            builder: (BuildContext context, GoRouterState state) {
              return const AdvancedProcessingScreen();
            },
          ),
        ],
      ),
    ],
  );

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
}
