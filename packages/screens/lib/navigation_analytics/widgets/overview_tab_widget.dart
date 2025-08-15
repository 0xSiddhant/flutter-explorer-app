import 'package:flutter/material.dart';
import 'package:common/common.dart';
import '../data/analytics_data.dart';
import '../models/analytics_model.dart';

class OverviewTabWidget extends StatelessWidget {
  final AnalyticsModel? analytics;
  final List<String> navigationHistory;
  final List<MapEntry<String, int>> mostVisitedScreens;
  final String currentRoute;
  final DateTime? screenEntryTime;

  const OverviewTabWidget({
    super.key,
    required this.analytics,
    required this.navigationHistory,
    required this.mostVisitedScreens,
    required this.currentRoute,
    required this.screenEntryTime,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCurrentScreenInfo(context),
            const SizedBox(height: 16),
            _buildOverviewCard(context),
            const SizedBox(height: 16),
            _buildScreenVisitCard(context),
            const SizedBox(height: 16),
            _buildNavigationHistoryCard(context),
            const SizedBox(height: 16),
            _buildNavigationLogCard(context),
          ],
        ),
      ),
    );
  }

  Widget _buildCurrentScreenInfo(BuildContext context) {
    final timeSpent = screenEntryTime != null
        ? DateTime.now().difference(screenEntryTime!)
        : Duration.zero;

    return Card(
      elevation: 4,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Theme.of(context).colorScheme.primaryContainer,
              Theme.of(context).colorScheme.secondaryContainer,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.analytics,
                  color: Theme.of(context).colorScheme.primary,
                  size: 24,
                ),
                const SizedBox(width: 8),
                Text(
                  'Current Screen Analytics',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildStatRow(
              context,
              'Current Route',
              _formatRouteName(currentRoute),
              Icons.route,
            ),
            _buildStatRow(
              context,
              'Time Spent',
              '${timeSpent.inSeconds} seconds',
              Icons.timer,
            ),
            _buildStatRow(
              context,
              'Visit Count',
              _getCurrentScreenVisitCount().toString(),
              Icons.visibility,
            ),
            _buildStatRow(
              context,
              'Screen Status',
              'Active',
              Icons.check_circle,
              valueColor: Colors.green,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOverviewCard(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.dashboard,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Text(
                  'Navigation Overview',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
            const SizedBox(height: 12),
            if (analytics != null) ...[
              _buildStatRow(
                context,
                'Total Navigations',
                analytics!.totalNavigations.toString(),
                Icons.swap_horiz,
              ),
              _buildStatRow(
                context,
                'Unique Screens',
                analytics!.uniqueScreens.toString(),
                Icons.layers,
              ),
              _buildStatRow(
                context,
                'Most Visited',
                analytics!.mostVisitedScreen != null
                    ? _formatRouteName(analytics!.mostVisitedScreen!)
                    : 'None',
                Icons.star,
              ),
            ] else ...[
              Text(AppLocalizations.getString('no_analytics_available')),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildScreenVisitCard(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.visibility,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Text(
                  'Screen Visit Count',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
            const SizedBox(height: 12),
            if (mostVisitedScreens.isNotEmpty) ...[
              ...mostVisitedScreens.map(
                (entry) => _buildVisitCountRow(context, entry.key, entry.value),
              ),
            ] else ...[
              Text(AppLocalizations.getString('no_screen_visits')),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildNavigationHistoryCard(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.history,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Text(
                  'Navigation History',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
            const SizedBox(height: 12),
            if (navigationHistory.isNotEmpty) ...[
              SizedBox(
                height: 200,
                child: ListView.builder(
                  itemCount: navigationHistory.length,
                  itemBuilder: (context, index) {
                    final route = navigationHistory[index];
                    final isCurrentRoute = route == currentRoute;
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundColor: isCurrentRoute
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).colorScheme.secondary,
                        child: Text(
                          '${index + 1}',
                          style: TextStyle(
                            color: isCurrentRoute
                                ? Theme.of(context).colorScheme.onPrimary
                                : Theme.of(context).colorScheme.onSecondary,
                          ),
                        ),
                      ),
                      title: Text(
                        _formatRouteName(route),
                        style: TextStyle(
                          fontWeight: isCurrentRoute
                              ? FontWeight.bold
                              : FontWeight.normal,
                          color: isCurrentRoute
                              ? Theme.of(context).colorScheme.primary
                              : null,
                        ),
                      ),
                      subtitle: Text(
                        '${AppLocalizations.getString('navigation_number')} ${index + 1}',
                      ),
                      trailing: isCurrentRoute
                          ? Icon(
                              Icons.my_location,
                              color: Theme.of(context).colorScheme.primary,
                            )
                          : null,
                      dense: true,
                    );
                  },
                ),
              ),
            ] else ...[
              Text(AppLocalizations.getString('no_navigation_history')),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildNavigationLogCard(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.logout,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Text(
                  'Navigation Log',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: Theme.of(
                    context,
                  ).colorScheme.outline.withValues(alpha: 0.3),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '🔄 Navigation Analytics Screen: SCREEN_VISIBLE',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontFamily: 'monospace',
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  Text(
                    'Route: $currentRoute',
                    style: Theme.of(
                      context,
                    ).textTheme.bodySmall?.copyWith(fontFamily: 'monospace'),
                  ),
                  Text(
                    'Time: ${DateTime.now().toIso8601String()}',
                    style: Theme.of(
                      context,
                    ).textTheme.bodySmall?.copyWith(fontFamily: 'monospace'),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Check console for detailed navigation logs',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontStyle: FontStyle.italic,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
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

  Widget _buildStatRow(
    BuildContext context,
    String label,
    String value,
    IconData icon, {
    Color? valueColor,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(
            icon,
            size: 16,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(label, style: Theme.of(context).textTheme.bodyMedium),
          ),
          Text(
            value,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: valueColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVisitCountRow(
    BuildContext context,
    String routeName,
    int count,
  ) {
    final isCurrentRoute = routeName == currentRoute;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Expanded(
            child: Text(
              _formatRouteName(routeName),
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: isCurrentRoute
                    ? FontWeight.bold
                    : FontWeight.normal,
                color: isCurrentRoute
                    ? Theme.of(context).colorScheme.primary
                    : null,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: isCurrentRoute
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              count.toString(),
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: isCurrentRoute
                    ? Theme.of(context).colorScheme.onPrimary
                    : Theme.of(context).colorScheme.onPrimaryContainer,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatRouteName(String routeName) {
    return AnalyticsData.formatRouteName(routeName);
  }

  int _getCurrentScreenVisitCount() {
    final visitCounts = AnalyticsData.getScreenVisitCount();
    return visitCounts[currentRoute] ?? 0;
  }
}
