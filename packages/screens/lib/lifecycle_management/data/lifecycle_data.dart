import 'package:flutter/material.dart';
import '../models/lifecycle_card_model.dart';

/// Data provider for lifecycle phase cards
class LifecycleData {
  static List<LifecycleCardModel> getLifecycleCards(BuildContext context) {
    return [
      LifecycleCardModel(
        title: 'Creation',
        subtitle: 'Widget Birth',
        icon: Icons.add_circle,
        color: Colors.green,
        description: 'Widget is created and initialized',
        methods: [
          'constructor()',
          'initState()',
          'didChangeDependencies()',
        ],
      ),
      LifecycleCardModel(
        title: 'Updates',
        subtitle: 'Widget Changes',
        icon: Icons.update,
        color: Colors.blue,
        description: 'Widget updates and rebuilds',
        methods: [
          'didUpdateWidget()',
          'reassemble()',
          'setState()',
        ],
      ),
      LifecycleCardModel(
        title: 'Navigation',
        subtitle: 'Route Awareness',
        icon: Icons.navigation,
        color: Colors.orange,
        description: 'Screen navigation events',
        methods: [
          'onScreenVisible()',
          'onScreenInvisible()',
          'onScreenPushed()',
          'onScreenPopped()',
        ],
      ),
      LifecycleCardModel(
        title: 'App State',
        subtitle: 'Application Lifecycle',
        icon: Icons.apps,
        color: Colors.purple,
        description: 'App foreground/background states',
        methods: [
          'didChangeAppLifecycleState()',
          'resumed',
          'paused',
          'inactive',
          'detached',
        ],
      ),
      LifecycleCardModel(
        title: 'Destruction',
        subtitle: 'Widget Death',
        icon: Icons.remove_circle,
        color: Colors.red,
        description: 'Widget cleanup and disposal',
        methods: [
          'deactivate()',
          'dispose()',
        ],
      ),
      LifecycleCardModel(
        title: 'Memory',
        subtitle: 'Resource Management',
        icon: Icons.memory,
        color: Colors.teal,
        description: 'Memory and resource handling',
        methods: [
          'WidgetsBindingObserver',
          'addObserver()',
          'removeObserver()',
        ],
      ),
    ];
  }
}
