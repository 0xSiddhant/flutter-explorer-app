import 'package:core/core.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.amberAccent,
        child: Center(
          child: ElevatedButton(
            onPressed: () => AppRouteManager.navigateToDetailScreen(context),
            child: const Text('Go to the Details screen'),
          ),
        ),
      ),
    );
  }
}
