import 'package:core/core.dart';
import 'package:flutter/material.dart';
import '../models/feature_card_model.dart';

/// Data provider for feature cards on the home screen
class FeatureCardsData {
  static List<FeatureCardModel> getFeatureCards(BuildContext context) {
    return [
      FeatureCardModel(
        title: AppLocalizations.getString('navigation'),
        subtitle: AppLocalizations.getString('route_management'),
        icon: Icons.navigation,
        color: Colors.blue,
        onTap: () => AppRouteManager.navigateToDetailScreen(context),
      ),
      FeatureCardModel(
        title: AppLocalizations.getString('theming'),
        subtitle: AppLocalizations.getString('dynamic_themes'),
        icon: Icons.palette,
        color: Colors.purple,
        onTap: () => AppRouteManager.navigateToTheming(context),
      ),
      FeatureCardModel(
        title: AppLocalizations.getString('native_communication'),
        subtitle: AppLocalizations.getString('platform_integration'),
        icon: Icons.phone_android,
        color: Colors.green,
        onTap: () => AppRouteManager.navigateToNativeCommunication(context),
      ),
      FeatureCardModel(
        title: AppLocalizations.getString('background_tasks'),
        subtitle: AppLocalizations.getString('isolate_processing'),
        icon: Icons.sync,
        color: Colors.orange,
        onTap: () => AppRouteManager.navigateToBackgroundTasks(context),
      ),
      FeatureCardModel(
        title: AppLocalizations.getString('internationalization'),
        subtitle: AppLocalizations.getString('multi_language_support'),
        icon: Icons.language,
        color: Colors.red,
        onTap: () => AppRouteManager.navigateToInternationalization(context),
      ),
      FeatureCardModel(
        title: AppLocalizations.getString('accessibility'),
        subtitle: AppLocalizations.getString('semantic_ui'),
        icon: Icons.accessibility,
        color: Colors.teal,
        onTap: () => AppRouteManager.navigateToAccessibility(context),
      ),
      FeatureCardModel(
        title: AppLocalizations.getString('file_management'),
        subtitle: AppLocalizations.getString('local_storage'),
        icon: Icons.folder,
        color: Colors.indigo,
        onTap: () => AppRouteManager.navigateToFileManagement(context),
      ),
      FeatureCardModel(
        title: AppLocalizations.getString('advanced_processing'),
        subtitle: AppLocalizations.getString('complex_operations'),
        icon: Icons.science,
        color: Colors.deepOrange,
        onTap: () => AppRouteManager.navigateToAdvancedProcessing(context),
      ),
      FeatureCardModel(
        title: AppLocalizations.getString('navigation_analytics'),
        subtitle: AppLocalizations.getString('route_tracking'),
        icon: Icons.analytics,
        color: Colors.cyan,
        onTap: () => AppRouteManager.navigateToNavigationAnalytics(context),
      ),
      FeatureCardModel(
        title: AppLocalizations.getString('lifecycle_management'),
        subtitle: AppLocalizations.getString('widget_states'),
        icon: Icons.auto_awesome,
        color: Colors.amber,
        onTap: () => AppRouteManager.navigateToLifecycleManagement(context),
      ),
      FeatureCardModel(
        title: AppLocalizations.getString('typography_showcase'),
        subtitle: AppLocalizations.getString('font_rendering'),
        icon: Icons.text_fields,
        color: Colors.pink,
        onTap: () => AppRouteManager.navigateToTypographyShowcase(context),
      ),
    ];
  }
}
