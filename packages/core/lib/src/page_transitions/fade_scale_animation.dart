import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Fade scale animation that combines fade and scale effects
class FadeScaleAnimation {
  static Widget _buildFadeScaleTransition(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    const begin = 0.0;
    const end = 1.0;
    const curve = Curves.easeOutCubic;

    var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

    var animationValue = animation.drive(tween);

    return FadeTransition(
      opacity: animationValue,
      child: Transform.scale(
        scale: 0.8 + (animationValue.value * 0.2),
        child: child,
      ),
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
      transitionsBuilder: _buildFadeScaleTransition,
      transitionDuration: const Duration(milliseconds: 600),
      reverseTransitionDuration: const Duration(milliseconds: 400),
    );
  }

  static PageRouteBuilder<dynamic> buildRoute({required Widget page}) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: _buildFadeScaleTransition,
      transitionDuration: const Duration(milliseconds: 600),
      reverseTransitionDuration: const Duration(milliseconds: 400),
    );
  }
}
