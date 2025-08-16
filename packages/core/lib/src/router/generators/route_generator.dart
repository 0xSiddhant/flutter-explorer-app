import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:screens/screens.dart';
import 'package:common/common.dart';
import '../constants/route_constants.dart';
import '../../page_transitions/page_transitions.dart';

/// Route generator that centralizes all route definitions
class RouteGenerator {
  // Private constructor to prevent instantiation
  RouteGenerator._();

  /// Generate all application routes
  static List<GoRoute> generateRoutes() {
    return [
      // Home route
      GoRoute(
        path: RouteConstants.home.path,
        name: RouteConstants.home.name,
        pageBuilder: (context, state) => FadeScaleAnimation.buildPage(
          child: const HomeScreen(),
          state: state,
        ),
      ),

      // Splash route
      GoRoute(
        path: RouteConstants.splash.path,
        name: RouteConstants.splash.name,
        pageBuilder: (context, state) => SlideFadeAnimation.buildPage(
          child: const SplashScreen(),
          state: state,
        ),
      ),

      // Settings route
      GoRoute(
        path: RouteConstants.settings.path,
        name: RouteConstants.settings.name,
        pageBuilder: (context, state) => SlideUpAnimation.buildPage(
          child: const SettingsScreen(),
          state: state,
        ),
      ),

      // Tab screen route
      GoRoute(
        path: RouteConstants.tabScreen.path,
        name: RouteConstants.tabScreen.name,
        pageBuilder: (context, state) => SlideRightAnimation.buildPage(
          child: const TabScreen(),
          state: state,
        ),
      ),

      // Detail screen route
      GoRoute(
        path: RouteConstants.detail.path,
        name: RouteConstants.detail.name,
        pageBuilder: (context, state) =>
            ScaleAnimation.buildPage(child: const DetailScreen(), state: state),
      ),

      // Theming route
      GoRoute(
        path: RouteConstants.theming.path,
        name: RouteConstants.theming.name,
        pageBuilder: (context, state) => RotationAnimation.buildPage(
          child: const ThemingScreen(),
          state: state,
        ),
      ),

      // Native communication route
      GoRoute(
        path: RouteConstants.nativeCommunication.path,
        name: RouteConstants.nativeCommunication.name,
        pageBuilder: (context, state) => SlideDiagonalAnimation.buildPage(
          child: const NativeCommunicationScreen(),
          state: state,
        ),
      ),

      // Background tasks route
      GoRoute(
        path: RouteConstants.backgroundTasks.path,
        name: RouteConstants.backgroundTasks.name,
        pageBuilder: (context, state) => BounceAnimation.buildPage(
          child: const BackgroundTasksScreen(),
          state: state,
        ),
      ),

      // Internationalization route
      GoRoute(
        path: RouteConstants.internationalization.path,
        name: RouteConstants.internationalization.name,
        pageBuilder: (context, state) => FlipAnimation.buildPage(
          child: const InternationalizationScreen(),
          state: state,
        ),
      ),

      // Accessibility route
      GoRoute(
        path: RouteConstants.accessibility.path,
        name: RouteConstants.accessibility.name,
        pageBuilder: (context, state) => SlideUpAnimation.buildPage(
          child: const AccessibilityScreen(),
          state: state,
        ),
      ),

      // File management route
      GoRoute(
        path: RouteConstants.fileManagement.path,
        name: RouteConstants.fileManagement.name,
        pageBuilder: (context, state) => SlideRightAnimation.buildPage(
          child: const FileManagementScreen(),
          state: state,
        ),
      ),

      // Advanced processing route
      GoRoute(
        path: RouteConstants.advancedProcessing.path,
        name: RouteConstants.advancedProcessing.name,
        pageBuilder: (context, state) => ScaleAnimation.buildPage(
          child: const AdvancedProcessingScreen(),
          state: state,
        ),
      ),

      // Navigation analytics route
      GoRoute(
        path: RouteConstants.navigationAnalytics.path,
        name: RouteConstants.navigationAnalytics.name,
        pageBuilder: (context, state) => FadeScaleAnimation.buildPage(
          child: const NavigationAnalyticsScreen(),
          state: state,
        ),
      ),

      // Lifecycle management route
      GoRoute(
        path: RouteConstants.lifecycleManagement.path,
        name: RouteConstants.lifecycleManagement.name,
        pageBuilder: (context, state) => SlideDiagonalAnimation.buildPage(
          child: const LifecycleManagementScreen(),
          state: state,
        ),
      ),

      // Typography showcase route
      GoRoute(
        path: RouteConstants.typographyShowcase.path,
        name: RouteConstants.typographyShowcase.name,
        pageBuilder: (context, state) => FadeScaleAnimation.buildPage(
          child: const TypographyShowcaseScreen(),
          state: state,
        ),
      ),
    ];
  }

  /// Generate error route for handling unknown routes
  static GoRoute generateErrorRoute() {
    return GoRoute(
      path: '/error',
      name: 'error',
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const ErrorScreen(errorCode: '404', icon: Icons.error_outline),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    );
  }

  /// Generate redirect function for route protection or custom logic
  static String? redirect(BuildContext context, GoRouterState state) {
    // Add any custom redirect logic here
    // For example: authentication checks, route protection, etc.

    // Example: Redirect to splash if not authenticated
    // if (!isAuthenticated && state.uri.path != RouteConstants.splash) {
    //   return RouteConstants.splash;
    // }

    return null; // No redirect needed
  }

  /// Generate refresh listeners for route changes
  static List<ChangeNotifier> generateRefreshListeners() {
    // Add any refresh listeners here
    // For example: authentication state, theme changes, etc.
    return [];
  }
}
