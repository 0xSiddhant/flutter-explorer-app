import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Scale animation that scales the page from center
class ScaleAnimation {
  static Widget _buildScaleTransition(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    const begin = 0.0;
    const end = 1.0;
    const curve = Curves.elasticOut;

    var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

    var scaleAnimation = animation.drive(tween);

    return ScaleTransition(scale: scaleAnimation, child: child);
  }

  static CustomTransitionPage<dynamic> buildPage({
    required Widget child,
    required GoRouterState state,
  }) {
    return CustomTransitionPage(
      key: state.pageKey,
      name: state.name,
      child: child,
      transitionsBuilder: _buildScaleTransition,
      transitionDuration: const Duration(milliseconds: 800),
      reverseTransitionDuration: const Duration(milliseconds: 400),
    );
  }

  static PageRouteBuilder<dynamic> buildRoute({required Widget page}) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: _buildScaleTransition,
      transitionDuration: const Duration(milliseconds: 800),
      reverseTransitionDuration: const Duration(milliseconds: 400),
    );
  }
}
