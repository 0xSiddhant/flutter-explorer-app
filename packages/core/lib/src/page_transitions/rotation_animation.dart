import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Rotation animation that rotates the page while scaling
class RotationAnimation {
  static Widget _buildRotationTransition(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    const begin = 0.0;
    const end = 1.0;
    const curve = Curves.easeInOutBack;

    var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

    var animationValue = animation.drive(tween);

    return Transform.rotate(
      angle: (1 - animationValue.value) * 0.5,
      child: Transform.scale(scale: animationValue.value, child: child),
    );
  }

  static CustomTransitionPage<dynamic> buildPage({
    required Widget child,
    required GoRouterState state,
  }) {
    return CustomTransitionPage(
      key: state.pageKey,
      name: state.name,
      child: child,
      transitionsBuilder: _buildRotationTransition,
      transitionDuration: const Duration(milliseconds: 700),
      reverseTransitionDuration: const Duration(milliseconds: 500),
    );
  }

  static PageRouteBuilder<dynamic> buildRoute({required Widget page}) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: _buildRotationTransition,
      transitionDuration: const Duration(milliseconds: 700),
      reverseTransitionDuration: const Duration(milliseconds: 500),
    );
  }
}
