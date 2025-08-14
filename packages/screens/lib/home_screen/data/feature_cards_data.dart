import 'package:flutter/material.dart';
import 'package:core/core.dart';
import '../models/feature_card_model.dart';

/// Data provider for feature cards on the home screen
class FeatureCardsData {
  static List<FeatureCardModel> getFeatureCards(BuildContext context) {
    return [
      FeatureCardModel(
        title: 'Navigation',
        subtitle: 'Route Management',
        icon: Icons.navigation,
        color: Colors.blue,
        onTap: () => AppRouteManager.navigateToDetailScreen(context),
      ),
      FeatureCardModel(
        title: 'Theming',
        subtitle: 'Dynamic Themes',
        icon: Icons.palette,
        color: Colors.purple,
        onTap: () => AppRouteManager.navigateToTheming(context),
      ),
      FeatureCardModel(
        title: 'Native Communication',
        subtitle: 'Platform Integration',
        icon: Icons.phone_android,
        color: Colors.green,
        onTap: () => AppRouteManager.navigateToNativeCommunication(context),
      ),
      FeatureCardModel(
        title: 'Background Tasks',
        subtitle: 'Isolate Processing',
        icon: Icons.sync,
        color: Colors.orange,
        onTap: () => AppRouteManager.navigateToBackgroundTasks(context),
      ),
      FeatureCardModel(
        title: 'Internationalization',
        subtitle: 'Multi-language Support',
        icon: Icons.language,
        color: Colors.red,
        onTap: () => AppRouteManager.navigateToInternationalization(context),
      ),
      FeatureCardModel(
        title: 'Accessibility',
        subtitle: 'Semantic UI',
        icon: Icons.accessibility,
        color: Colors.teal,
        onTap: () => AppRouteManager.navigateToAccessibility(context),
      ),
      FeatureCardModel(
        title: 'File Management',
        subtitle: 'Local Storage',
        icon: Icons.folder,
        color: Colors.indigo,
        onTap: () => AppRouteManager.navigateToFileManagement(context),
      ),
      FeatureCardModel(
        title: 'Advanced Processing',
        subtitle: 'Complex Operations',
        icon: Icons.science,
        color: Colors.deepOrange,
        onTap: () => AppRouteManager.navigateToAdvancedProcessing(context),
      ),
    ];
  }
}
