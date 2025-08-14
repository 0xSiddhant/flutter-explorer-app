import 'package:flutter/material.dart';
import 'package:common/common.dart';
import '../data/internationalization_data.dart';

/// Widget for displaying feature list with navigation
class FeatureListWidget extends StatelessWidget {
  final String currentLanguage;
  final Function(String) onFeatureTap;

  const FeatureListWidget({
    super.key,
    required this.currentLanguage,
    required this.onFeatureTap,
  });

  @override
  Widget build(BuildContext context) {
    final features = InternationalizationData.getFeatureList();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.getString('core_features', currentLanguage),
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 300, // Increased height for better scrolling
              child: ListView.builder(
                itemCount: features.length,
                itemBuilder: (context, index) {
                  final feature = features[index];
                  return _buildFeatureItem(
                    feature['title'] as String,
                    feature['icon'] as IconData,
                    feature['route'] as String,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureItem(String title, IconData icon, String route) {
    return ListTile(
      leading: Icon(icon, color: Colors.blue),
      title: Text(title),
      subtitle: Text('Tap to navigate to $title'),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: () => onFeatureTap(route),
    );
  }
}
