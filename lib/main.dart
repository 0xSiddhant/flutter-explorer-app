import 'package:flutter/material.dart';
import 'package:core/core.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  /// Constructs a [MyApp]
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(routerConfig: AppRouteManager.router);
  }
}
