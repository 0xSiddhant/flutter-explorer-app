import 'package:core/core.dart';
import 'package:flutter/material.dart';

/// Animated logo widget for splash screen
class AnimatedLogo extends StatelessWidget {
  final Animation<double> scaleAnimation;
  final Animation<double> rotationAnimation;
  final Animation<double> pulseAnimation;

  const AnimatedLogo({
    super.key,
    required this.scaleAnimation,
    required this.rotationAnimation,
    required this.pulseAnimation,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([
        scaleAnimation,
        rotationAnimation,
        pulseAnimation,
      ]),
      builder: (context, child) {
        return Transform.scale(
          scale: scaleAnimation.value * pulseAnimation.value,
          child: Transform.rotate(
            angle: rotationAnimation.value * 2 * 3.14159,
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.2),
                boxShadow: [
                  BoxShadow(
                    color: Colors.white.withValues(alpha: 0.3),
                    blurRadius: 30,
                    spreadRadius: 10,
                  ),
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 20,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: Icon(Icons.explore, size: 60, color: Colors.white),
            ),
          ),
        );
      },
    );
  }
}
