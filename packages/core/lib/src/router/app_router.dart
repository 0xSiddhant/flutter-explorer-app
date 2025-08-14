import 'package:core/src/router/navigation_observer.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:screens/detail_screen/detail_screen.dart';
import 'package:screens/tab_screen/tab_screen.dart';
import 'package:screens/theme_demo_screen/theme_demo_screen.dart';
import 'package:screens/method_channel_demo/method_channel_demo.dart';
import 'package:screens/isolate_demo/isolate_demo.dart';
import 'package:screens/localization_demo/localization_demo.dart';
import 'package:screens/semantic_demo/semantic_demo.dart';
import 'package:screens/file_storage_demo/file_storage_demo.dart';
import 'package:screens/advanced_isolate_demo/advanced_isolate_demo.dart';

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
            path: 'theme-demo',
            builder: (BuildContext context, GoRouterState state) {
              return const ThemeDemoScreen();
            },
          ),
          GoRoute(
            path: 'method-channel-demo',
            builder: (BuildContext context, GoRouterState state) {
              return const MethodChannelDemo();
            },
          ),
          GoRoute(
            path: 'isolate-demo',
            builder: (BuildContext context, GoRouterState state) {
              return const IsolateDemo();
            },
          ),
          GoRoute(
            path: 'localization-demo',
            builder: (BuildContext context, GoRouterState state) {
              return const LocalizationDemo();
            },
          ),
          GoRoute(
            path: 'semantic-demo',
            builder: (BuildContext context, GoRouterState state) {
              return const SemanticDemo();
            },
          ),
          GoRoute(
            path: 'file-storage-demo',
            builder: (BuildContext context, GoRouterState state) {
              return const FileStorageDemo();
            },
          ),
          GoRoute(
            path: 'advanced-isolate-demo',
            builder: (BuildContext context, GoRouterState state) {
              return const AdvancedIsolateDemo();
            },
          ),
        ],
      ),
    ],
  );

  static void navigateToDetailScreen(BuildContext context) {
    context.go('/details');
  }

  static void navigateToThemeDemo(BuildContext context) {
    context.go('/theme-demo');
  }

  static void navigateToMethodChannelDemo(BuildContext context) {
    context.go('/method-channel-demo');
  }

  static void navigateToIsolateDemo(BuildContext context) {
    context.go('/isolate-demo');
  }

  static void navigateToLocalizationDemo(BuildContext context) {
    context.go('/localization-demo');
  }

  static void navigateToSemanticDemo(BuildContext context) {
    context.go('/semantic-demo');
  }

  static void navigateToFileStorageDemo(BuildContext context) {
    context.go('/file-storage-demo');
  }

  static void navigateToAdvancedIsolateDemo(BuildContext context) {
    context.go('/advanced-isolate-demo');
  }
}
