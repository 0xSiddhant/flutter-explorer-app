import 'package:flutter/material.dart';
import 'package:common/common.dart';
import '../data/analytics_data.dart';

class PerformanceTabWidget extends StatelessWidget {
  final Map<String, dynamic>? comprehensiveAnalytics;

  const PerformanceTabWidget({super.key, required this.comprehensiveAnalytics});

  @override
  Widget build(BuildContext context) {
    if (comprehensiveAnalytics == null) {
      return const Center(child: Text('No performance data available'));
    }

    final performanceMetrics =
        comprehensiveAnalytics!['performanceMetrics'] as Map<String, dynamic>;

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.getString('screen_performance'),
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            if (performanceMetrics.isEmpty)
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    AppLocalizations.getString('no_performance_data'),
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
              )
            else
              ...performanceMetrics.entries.map((entry) {
                final screen = entry.key;
                final metrics = entry.value as Map<String, dynamic>;

                return Card(
                  margin: const EdgeInsets.only(bottom: 16),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _formatRouteName(screen),
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        _buildPerformanceRow(
                          context,
                          'Average Load Time',
                          _formatDuration(metrics['averageLoadTime']),
                          Icons.timer,
                        ),
                        _buildPerformanceRow(
                          context,
                          'Total Loads',
                          '${metrics['totalLoads']}',
                          Icons.repeat,
                        ),
                        _buildPerformanceRow(
                          context,
                          'Fastest Load',
                          _formatDuration(metrics['fastestLoad']),
                          Icons.flash_on,
                          color: Colors.green,
                        ),
                        _buildPerformanceRow(
                          context,
                          'Slowest Load',
                          _formatDuration(metrics['slowestLoad']),
                          Icons.slow_motion_video,
                          color: Colors.red,
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildPerformanceRow(
    BuildContext context,
    String label,
    String value,
    IconData icon, {
    Color? color,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(
            icon,
            size: 16,
            color: color ?? Theme.of(context).colorScheme.onSurfaceVariant,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(label, style: Theme.of(context).textTheme.bodyMedium),
          ),
          Text(
            value,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
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

  String _formatRouteName(String routeName) {
    return AnalyticsData.formatRouteName(routeName);
  }
}
