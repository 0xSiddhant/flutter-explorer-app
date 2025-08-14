import 'package:core/src/router/navigation_observer.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:screens/detail_screen/detail_screen.dart';
import 'package:screens/tab_screen/tab_screen.dart';

class AppRouteManager {
  AppRouteManager._();

  static final GoRouter router = GoRouter(
    redirect: (BuildContext context, GoRouterState state) {
      final isAuthenticated =
          false; // your logic to check if user is authenticated
      if (!isAuthenticated) {
        return '/login';
      } else {
        return '/'; // return "null" to display the intended route without redirecting
      }
    },
    observers: [MyNavigatorObserver()],
    // errorBuilder: (context, state) => ErrorPage(state.error),
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
          //         GoRoute(
          // path: '/fruits/:id',
          // builder: (context, state) {
          //    final id = state.pathParameters["id"]! // Get "id" param from URL
          //    return FruitsPage(id: id);
          // },)
          // GoRoute(
          //   path: '/fruit-details',
          //   pageBuilder: (context, state) {
          //     return CustomTransitionPage(
          //       key: state.pageKey,
          //       child: FruitDetailsScreen(),
          //       transitionsBuilder:
          //           (context, animation, secondaryAnimation, child) {
          //             // Change the opacity of the screen using a Curve based on the the animation's value
          //             return FadeTransition(
          //               opacity: CurveTween(
          //                 curve: Curves.easeInOutCirc,
          //               ).animate(animation),
          //               child: child,
          //             );
          //           },
          //     );
          //   },
          // ),
        ],
      ),
    ],
  );

  static void navigateToDetailScreen(BuildContext context) {
    context.go('/details');
  }
}

// Go Router with tab bar
