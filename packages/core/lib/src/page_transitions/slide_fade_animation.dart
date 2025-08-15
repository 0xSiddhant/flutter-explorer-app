import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Slide fade animation that combines slide up with fade effect
class SlideFadeAnimation {
  static Widget _buildSlideFadeTransition(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    const begin = Offset(0.0, 1.0);
    const end = Offset.zero;
    const curve = Curves.easeInOutCubic;

    var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

    var offsetAnimation = animation.drive(tween);

    return SlideTransition(
      position: offsetAnimation,
      child: FadeTransition(opacity: animation, child: child),
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
      transitionsBuilder: _buildSlideFadeTransition,
      transitionDuration: const Duration(milliseconds: 600),
      reverseTransitionDuration: const Duration(milliseconds: 400),
    );
  }

  static PageRouteBuilder<dynamic> buildRoute({required Widget page}) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: _buildSlideFadeTransition,
      transitionDuration: const Duration(milliseconds: 600),
      reverseTransitionDuration: const Duration(milliseconds: 400),
    );
  }
}
