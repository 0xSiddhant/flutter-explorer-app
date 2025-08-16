import 'package:flutter/material.dart';
import 'package:common/common.dart';
import '../data/analytics_data.dart';

class ErrorsTabWidget extends StatelessWidget {
  final Map<String, dynamic>? comprehensiveAnalytics;

  const ErrorsTabWidget({super.key, required this.comprehensiveAnalytics});

  @override
  Widget build(BuildContext context) {
    if (comprehensiveAnalytics == null) {
      return const Center(child: Text('No error data available'));
    }

    final errors =
        comprehensiveAnalytics!['navigationErrors'] as Map<String, dynamic>;

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.getString('navigation_errors'),
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            if (errors.isEmpty)
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Icon(Icons.check_circle, color: Colors.green, size: 24),
                      const SizedBox(width: 8),
                      Text(
                        AppLocalizations.getString('no_errors_found'),
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
                ),
              )
            else
              ...errors.entries.map((entry) {
                final screen = entry.key;
                final errorCount = entry.value as int;

                return Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    leading: Icon(Icons.error, color: Colors.red),
                    title: Text(_formatRouteName(screen)),
                    subtitle: Text(
                      '${AppLocalizations.getString('error_count')}: $errorCount',
                    ),
                    trailing: Text(
                      '$errorCount',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                  ),
                );
              }).toList(),
          ],
        ),
      ),
    );
  }

  String _formatRouteName(String routeName) {
    return AnalyticsData.formatRouteName(routeName);
  }
}
