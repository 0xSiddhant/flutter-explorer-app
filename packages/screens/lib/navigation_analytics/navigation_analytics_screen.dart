import 'package:flutter/material.dart';
import 'package:core/core.dart';
import 'data/analytics_data.dart';
import 'models/analytics_model.dart';

class NavigationAnalyticsScreen extends StatefulWidget {
  const NavigationAnalyticsScreen({super.key});

  @override
  State<NavigationAnalyticsScreen> createState() =>
      _NavigationAnalyticsScreenState();
}

class _NavigationAnalyticsScreenState extends State<NavigationAnalyticsScreen>
    with RouteAwareMixin {
  AnalyticsModel? _analytics;
  List<String> _navigationHistory = [];
  List<MapEntry<String, int>> _mostVisitedScreens = [];

  @override
  void initState() {
    super.initState();
    _loadAnalytics();
  }

  @override
  void onScreenVisible() {
    super.onScreenVisible();
    _loadAnalytics();
  }

  void _loadAnalytics() {
    setState(() {
      _analytics = AnalyticsData.getAnalytics();
      _navigationHistory = AnalyticsData.getNavigationHistory();
      _mostVisitedScreens = AnalyticsData.getMostVisitedScreens();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Navigation Analytics'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadAnalytics,
            tooltip: 'Refresh Analytics',
          ),
          IconButton(
            icon: const Icon(Icons.clear_all),
            onPressed: _clearHistory,
            tooltip: 'Clear History',
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildOverviewCard(),
              const SizedBox(height: 16),
              _buildScreenVisitCard(),
              const SizedBox(height: 16),
              _buildNavigationHistoryCard(),
              const SizedBox(height: 16),
              _buildCurrentScreenInfo(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOverviewCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Navigation Overview',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 12),
            if (_analytics != null) ...[
              _buildStatRow(
                'Total Navigations',
                _analytics!.totalNavigations.toString(),
              ),
              _buildStatRow(
                'Unique Screens',
                _analytics!.uniqueScreens.toString(),
              ),
              _buildStatRow(
                'Most Visited',
                _analytics!.mostVisitedScreen ?? 'None',
              ),
            ] else ...[
              const Text('No analytics available'),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildScreenVisitCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Screen Visit Count',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 12),
            if (_mostVisitedScreens.isNotEmpty) ...[
              ..._mostVisitedScreens.map(
                (entry) => _buildVisitCountRow(entry.key, entry.value),
              ),
            ] else ...[
              const Text('No screen visits recorded'),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildNavigationHistoryCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Navigation History',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 12),
            if (_navigationHistory.isNotEmpty) ...[
              SizedBox(
                height: 200,
                child: ListView.builder(
                  itemCount: _navigationHistory.length,
                  itemBuilder: (context, index) {
                    final route = _navigationHistory[index];
                    return ListTile(
                      leading: CircleAvatar(child: Text('${index + 1}')),
                      title: Text(_formatRouteName(route)),
                      subtitle: Text('Navigation ${index + 1}'),
                      dense: true,
                    );
                  },
                ),
              ),
            ] else ...[
              const Text('No navigation history'),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildCurrentScreenInfo() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Current Screen Info',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 12),
            _buildStatRow('Current Route', currentRouteName ?? 'Unknown'),
            if (timeSpentOnScreen != null) ...[
              _buildStatRow(
                'Time Spent',
                '${timeSpentOnScreen!.inSeconds} seconds',
              ),
            ],
            _buildStatRow(
              'Visit Count',
              getScreenVisitCount(currentRouteName ?? '').toString(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: Theme.of(context).textTheme.bodyMedium),
          Text(
            value,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildVisitCountRow(String routeName, int count) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              _formatRouteName(routeName),
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              count.toString(),
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  String _formatRouteName(String routeName) {
    return AnalyticsData.formatRouteName(routeName);
  }

  void _clearHistory() {
    AnalyticsData.clearHistory();
    _loadAnalytics();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Navigation history cleared'),
        duration: Duration(seconds: 2),
      ),
    );
  }
}
