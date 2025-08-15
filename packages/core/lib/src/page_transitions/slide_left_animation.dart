import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Slide left animation that slides the page from right to left
class SlideLeftAnimation {
  static Widget _buildSlideLeftTransition(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    const begin = Offset(1.0, 0.0);
    const end = Offset.zero;
    const curve = Curves.easeOutQuart;

    var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

    var offsetAnimation = animation.drive(tween);

    return SlideTransition(position: offsetAnimation, child: child);
  }

  static CustomTransitionPage<dynamic> buildPage({
    required Widget child,
    required GoRouterState state,
  }) {
    return CustomTransitionPage(
      key: state.pageKey,
      name: state.name,
      child: child,
      transitionsBuilder: _buildSlideLeftTransition,
      transitionDuration: const Duration(milliseconds: 550),
      reverseTransitionDuration: const Duration(milliseconds: 350),
    );
  }

  static PageRouteBuilder<dynamic> buildRoute({required Widget page}) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: _buildSlideLeftTransition,
      transitionDuration: const Duration(milliseconds: 550),
      reverseTransitionDuration: const Duration(milliseconds: 350),
    );
  }
}
