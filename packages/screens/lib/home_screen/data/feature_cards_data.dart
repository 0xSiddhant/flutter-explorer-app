import 'package:core/core.dart';
import 'package:flutter/material.dart';
import '../models/feature_card_model.dart';

/// Data provider for feature cards on the home screen
class FeatureCardsData {
  static List<FeatureCardModel> getFeatureCards(BuildContext context) {
    final config = AppConfigService.instance.getAllConfig();
    final features = config['features'] as Map<String, dynamic>? ?? {};

    final allFeatures = [
      FeatureCardModel(
        title: AppLocalizations.getString('navigation'),
        subtitle: AppLocalizations.getString('route_management'),
        icon: Icons.navigation,
        color: Colors.blue,
        onTap: () => AppRouteManager.navigateToDetailScreen(context),
        featureKey: 'enableNavigation',
      ),
      FeatureCardModel(
        title: AppLocalizations.getString('theming'),
        subtitle: AppLocalizations.getString('dynamic_themes'),
        icon: Icons.palette,
        color: Colors.purple,
        onTap: () => AppRouteManager.navigateToTheming(context),
        featureKey: 'enableTheming',
      ),
      FeatureCardModel(
        title: AppLocalizations.getString('native_communication'),
        subtitle: AppLocalizations.getString('platform_integration'),
        icon: Icons.phone_android,
        color: Colors.green,
        onTap: () => AppRouteManager.navigateToNativeCommunication(context),
        featureKey: 'enableNativeCommunication',
      ),
      FeatureCardModel(
        title: AppLocalizations.getString('background_tasks'),
        subtitle: AppLocalizations.getString('isolate_processing'),
        icon: Icons.sync,
        color: Colors.orange,
        onTap: () => AppRouteManager.navigateToBackgroundTasks(context),
        featureKey: 'enableBackgroundTasks',
      ),
      FeatureCardModel(
        title: AppLocalizations.getString('internationalization'),
        subtitle: AppLocalizations.getString('multi_language_support'),
        icon: Icons.language,
        color: Colors.red,
        onTap: () => AppRouteManager.navigateToInternationalization(context),
        featureKey: 'enableInternationalization',
      ),
      FeatureCardModel(
        title: AppLocalizations.getString('accessibility'),
        subtitle: AppLocalizations.getString('semantic_ui'),
        icon: Icons.accessibility,
        color: Colors.teal,
        onTap: () => AppRouteManager.navigateToAccessibility(context),
        featureKey: 'enableAccessibility',
      ),
      FeatureCardModel(
        title: AppLocalizations.getString('file_management'),
        subtitle: AppLocalizations.getString('local_storage'),
        icon: Icons.folder,
        color: Colors.indigo,
        onTap: () => AppRouteManager.navigateToFileManagement(context),
        featureKey: 'enableFileManagement',
      ),
      FeatureCardModel(
        title: AppLocalizations.getString('advanced_processing'),
        subtitle: AppLocalizations.getString('complex_operations'),
        icon: Icons.science,
        color: Colors.deepOrange,
        onTap: () => AppRouteManager.navigateToAdvancedProcessing(context),
        featureKey: 'enableAdvancedProcessing',
      ),
      FeatureCardModel(
        title: AppLocalizations.getString('navigation_analytics'),
        subtitle: AppLocalizations.getString('route_tracking'),
        icon: Icons.analytics,
        color: Colors.cyan,
        onTap: () => AppRouteManager.navigateToNavigationAnalytics(context),
        featureKey: 'enableNavigationAnalytics',
      ),
      FeatureCardModel(
        title: AppLocalizations.getString('lifecycle_management'),
        subtitle: AppLocalizations.getString('widget_states'),
        icon: Icons.auto_awesome,
        color: Colors.amber,
        onTap: () => AppRouteManager.navigateToLifecycleManagement(context),
        featureKey: 'enableLifecycleManagement',
      ),
      FeatureCardModel(
        title: AppLocalizations.getString('typography_showcase'),
        subtitle: AppLocalizations.getString('font_rendering'),
        icon: Icons.text_fields,
        color: Colors.pink,
        onTap: () => AppRouteManager.navigateToTypographyShowcase(context),
        featureKey: 'enableTypographyShowcase',
      ),
      FeatureCardModel(
        title: AppLocalizations.getString('deep_link_test'),
        subtitle: AppLocalizations.getString('deep_link_test_description'),
        icon: Icons.link,
        color: Colors.deepPurple,
        onTap: () => AppRouteManager.navigateToDeepLinkTest(context),
        featureKey: 'enableDeepLinkTest',
      ),
    ];

    // Filter features based on config
    final filteredFeatures = allFeatures.where((feature) {
      final isEnabled = features[feature.featureKey] as bool? ?? true;
      return isEnabled;
    }).toList();
    return filteredFeatures;
  }
}
