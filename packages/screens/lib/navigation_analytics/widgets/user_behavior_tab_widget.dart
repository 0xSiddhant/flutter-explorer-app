import 'package:flutter/material.dart';
import 'package:common/common.dart';
import '../data/analytics_data.dart';

class UserBehaviorTabWidget extends StatelessWidget {
  final Map<String, dynamic>? comprehensiveAnalytics;

  const UserBehaviorTabWidget({
    super.key,
    required this.comprehensiveAnalytics,
  });

  @override
  Widget build(BuildContext context) {
    if (comprehensiveAnalytics == null) {
      return const Center(child: Text('No user behavior data available'));
    }

    final userBehavior =
        comprehensiveAnalytics!['userBehaviorMetrics'] as Map<String, dynamic>;
    final timeSpentData =
        comprehensiveAnalytics!['screensWithHighestTimeSpent'] as List<dynamic>;

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.getString('user_behavior_metrics'),
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            _buildMetricCard(
              context: context,
              title: AppLocalizations.getString('total_back_navigations'),
              value: '${userBehavior['totalBackNavigations']}',
              icon: Icons.arrow_back,
              color: Colors.blue,
            ),
            const SizedBox(height: 16),
            _buildMetricCard(
              context: context,
              title: AppLocalizations.getString('average_session_duration'),
              value: '${userBehavior['averageSessionDuration']} minutes',
              icon: Icons.access_time,
              color: Colors.orange,
            ),
            const SizedBox(height: 16),
            _buildMetricCard(
              context: context,
              title: AppLocalizations.getString('user_engagement_score'),
              value:
                  '${userBehavior['userEngagementScore'].toStringAsFixed(2)}',
              icon: Icons.trending_up,
              color: Colors.red,
            ),
            const SizedBox(height: 16),
            _buildMetricCard(
              context: context,
              title: AppLocalizations.getString('navigation_efficiency'),
              value:
                  '${(userBehavior['navigationEfficiency'] * 100).toStringAsFixed(1)}%',
              icon: Icons.speed,
              color: Colors.teal,
            ),
            const SizedBox(height: 16),
            Text(
              AppLocalizations.getString('screens_with_highest_time_spent'),
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            ...timeSpentData.map((data) {
              final screen = data['screen'] as String;
              final avgTime = data['avgTime'] as int;

              return Card(
                margin: const EdgeInsets.only(bottom: 8),
                child: ListTile(
                  leading: const Icon(Icons.timer),
                  title: Text(_formatRouteName(screen)),
                  subtitle: Text(
                    '${(avgTime / 60).toStringAsFixed(1)} minutes average',
                  ),
                  trailing: Text(
                    '${avgTime}s',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
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

  Widget _buildMetricCard({
    required BuildContext context,
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    value,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatRouteName(String routeName) {
    return AnalyticsData.formatRouteName(routeName);
  }
}
