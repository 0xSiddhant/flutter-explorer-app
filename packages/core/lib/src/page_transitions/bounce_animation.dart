import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Bounce animation that bounces the page into view
class BounceAnimation {
  static Widget _buildBounceTransition(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    const begin = 0.0;
    const end = 1.0;
    const curve = Curves.bounceOut;

    var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

    var scaleAnimation = animation.drive(tween);

    return Transform.scale(scale: scaleAnimation.value, child: child);
  }

  static CustomTransitionPage<dynamic> buildPage({
    required Widget child,
    required GoRouterState state,
  }) {
    return CustomTransitionPage(
      key: state.pageKey,
      name: state.name,
      child: child,
      transitionsBuilder: _buildBounceTransition,
      transitionDuration: const Duration(milliseconds: 900),
      reverseTransitionDuration: const Duration(milliseconds: 300),
    );
  }

  static PageRouteBuilder<dynamic> buildRoute({required Widget page}) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: _buildBounceTransition,
      transitionDuration: const Duration(milliseconds: 900),
      reverseTransitionDuration: const Duration(milliseconds: 300),
    );
  }
}
