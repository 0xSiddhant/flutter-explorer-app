import 'package:core/core.dart';
import 'package:flutter/material.dart';
import '../models/accessibility_feature_model.dart';

/// Widget for displaying accessibility controls
class AccessibilityControlsWidget extends StatelessWidget {
  final List<AccessibilityFeatureModel> features;

  const AccessibilityControlsWidget({super.key, required this.features});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.getString('accessibility_controls'),
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ...features.map((feature) => _buildFeatureTile(context, feature)),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureTile(
    BuildContext context,
    AccessibilityFeatureModel feature,
  ) {
    return Semantics(
      label: '${feature.title} toggle, ${feature.subtitle}',
      value: feature.isEnabled ? 'enabled' : 'disabled',
      button: true,
      child: SwitchListTile(
        title: Text(
          feature.title,
          style: TextStyle(
            fontWeight: feature.isEnabled ? FontWeight.bold : FontWeight.normal,
          ),
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          feature.subtitle,
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
        ),
        value: feature.isEnabled,
        onChanged: feature.onChanged,
        activeColor: Theme.of(context).colorScheme.primary,
        activeTrackColor: Theme.of(context).colorScheme.primaryContainer,
      ),
    );
  }
}
