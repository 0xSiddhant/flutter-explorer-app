import 'package:flutter/material.dart';
import 'package:common/common.dart';
import '../data/analytics_data.dart';

class SessionDataTabWidget extends StatelessWidget {
  final Map<String, dynamic>? comprehensiveAnalytics;

  const SessionDataTabWidget({super.key, required this.comprehensiveAnalytics});

  @override
  Widget build(BuildContext context) {
    if (comprehensiveAnalytics == null) {
      return const Center(child: Text('No session data available'));
    }

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.getString('session_data', 'en'),
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            _buildMetricCard(
              context: context,
              title: AppLocalizations.getString('session_duration', 'en'),
              value: _formatDuration(
                comprehensiveAnalytics!['sessionDuration'],
              ),
              icon: Icons.timer,
              color: Colors.blue,
            ),
            const SizedBox(height: 16),
            _buildMetricCard(
              context: context,
              title: AppLocalizations.getString(
                'total_session_navigations',
                'en',
              ),
              value: '${comprehensiveAnalytics!['totalSessionNavigations']}',
              icon: Icons.navigation,
              color: Colors.green,
            ),
            const SizedBox(height: 16),
            _buildMetricCard(
              context: context,
              title: AppLocalizations.getString('last_visited_screen', 'en'),
              value: comprehensiveAnalytics!['lastVisitedScreen'] ?? 'None',
              icon: Icons.my_location,
              color: Colors.orange,
            ),
            const SizedBox(height: 16),
            Text(
              AppLocalizations.getString('navigation_patterns', 'en'),
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            ...(comprehensiveAnalytics!['navigationPatterns'] as List<dynamic>)
                .map((pattern) {
                  return Card(
                    margin: const EdgeInsets.only(bottom: 8),
                    child: ListTile(
                      leading: const Icon(Icons.route),
                      title: Text(pattern),
                      subtitle: Text(
                        AppLocalizations.getString('navigation_pattern', 'en'),
                      ),
                    ),
                  );
                })
                .toList(),
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
                color: color.withOpacity(0.1),
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

  String _formatDuration(dynamic duration) {
    if (duration == null) return 'N/A';
    if (duration is Duration) {
      if (duration.inMinutes > 0) {
        return '${duration.inMinutes}m ${duration.inSeconds % 60}s';
      }
      return '${duration.inSeconds}s';
    }
    return duration.toString();
  }
}
