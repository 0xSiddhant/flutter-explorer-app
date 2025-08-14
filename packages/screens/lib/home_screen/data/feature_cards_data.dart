import 'package:flutter/material.dart';
import 'package:core/core.dart';
import '../models/feature_card_model.dart';

/// Data provider for feature cards on the home screen
class FeatureCardsData {
  static List<FeatureCardModel> getFeatureCards(BuildContext context) {
    return [
      FeatureCardModel(
        title: 'Navigation',
        subtitle: 'Go Router Demo',
        icon: Icons.navigation,
        color: Colors.blue,
        onTap: () => AppRouteManager.navigateToDetailScreen(context),
      ),
      FeatureCardModel(
        title: 'Theme',
        subtitle: 'Theme Switching',
        icon: Icons.palette,
        color: Colors.purple,
        onTap: () => AppRouteManager.navigateToThemeDemo(context),
      ),
      FeatureCardModel(
        title: 'Method Channel',
        subtitle: 'Native Communication',
        icon: Icons.phone_android,
        color: Colors.green,
        onTap: () => AppRouteManager.navigateToMethodChannelDemo(context),
      ),
      FeatureCardModel(
        title: 'Isolates',
        subtitle: 'Background Processing',
        icon: Icons.sync,
        color: Colors.orange,
        onTap: () => AppRouteManager.navigateToIsolateDemo(context),
      ),
      FeatureCardModel(
        title: 'Localization',
        subtitle: 'Multi-language Support',
        icon: Icons.language,
        color: Colors.red,
        onTap: () => AppRouteManager.navigateToLocalizationDemo(context),
      ),
      FeatureCardModel(
        title: 'Semantic UI',
        subtitle: 'Accessibility',
        icon: Icons.accessibility,
        color: Colors.teal,
        onTap: () => AppRouteManager.navigateToSemanticDemo(context),
      ),
      FeatureCardModel(
        title: 'File Storage',
        subtitle: 'Local File Operations',
        icon: Icons.folder,
        color: Colors.indigo,
        onTap: () => AppRouteManager.navigateToFileStorageDemo(context),
      ),
      FeatureCardModel(
        title: 'Advanced Isolates',
        subtitle: 'Real-world Examples',
        icon: Icons.science,
        color: Colors.deepOrange,
        onTap: () => AppRouteManager.navigateToAdvancedIsolateDemo(context),
      ),
    ];
  }
}
