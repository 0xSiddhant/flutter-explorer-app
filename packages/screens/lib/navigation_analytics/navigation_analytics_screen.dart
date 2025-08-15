import 'package:flutter/material.dart';
import 'package:core/core.dart';
import 'package:common/common.dart';
import 'data/analytics_data.dart';
import 'models/analytics_model.dart';
import 'widgets/overview_tab_widget.dart';
import 'widgets/performance_tab_widget.dart';
import 'widgets/user_behavior_tab_widget.dart';
import 'widgets/session_data_tab_widget.dart';
import 'widgets/errors_tab_widget.dart';

class NavigationAnalyticsScreen extends StatefulWidget {
  const NavigationAnalyticsScreen({super.key});

  @override
  State<NavigationAnalyticsScreen> createState() =>
      _NavigationAnalyticsScreenState();
}

class _NavigationAnalyticsScreenState extends State<NavigationAnalyticsScreen>
    with RouteAwareMixin, TickerProviderStateMixin {
  AnalyticsModel? _analytics;
  List<String> _navigationHistory = [];
  List<MapEntry<String, int>> _mostVisitedScreens = [];
  final String _currentRoute = 'navigation-analytics';
  DateTime? _screenEntryTime;
  late TabController _tabController;
  Map<String, dynamic>? _comprehensiveAnalytics;

  @override
  void initState() {
    super.initState();
    _screenEntryTime = DateTime.now();
    _tabController = TabController(length: 5, vsync: this);
    _loadAnalytics();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  void onScreenVisible() {
    super.onScreenVisible();
    _screenEntryTime = DateTime.now();
    _loadAnalytics();
  }

  @override
  void onScreenInvisible() {
    super.onScreenInvisible();
  }

  void _loadAnalytics() {
    setState(() {
      _analytics = AnalyticsData.getAnalytics();
      _navigationHistory = AnalyticsData.getNavigationHistory();
      _mostVisitedScreens = AnalyticsData.getMostVisitedScreens();
      _comprehensiveAnalytics = AnalyticsData.getComprehensiveAnalytics();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.getString('navigation_analytics', 'en')),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: [
            Tab(text: AppLocalizations.getString('overview', 'en')),
            Tab(text: AppLocalizations.getString('performance', 'en')),
            Tab(text: AppLocalizations.getString('user_behavior', 'en')),
            Tab(text: AppLocalizations.getString('session_data', 'en')),
            Tab(text: AppLocalizations.getString('errors', 'en')),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadAnalytics,
            tooltip: AppLocalizations.getString('refresh_analytics', 'en'),
          ),
          IconButton(
            icon: const Icon(Icons.clear_all),
            onPressed: _clearHistory,
            tooltip: AppLocalizations.getString('clear_analytics', 'en'),
          ),
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          OverviewTabWidget(
            analytics: _analytics,
            navigationHistory: _navigationHistory,
            mostVisitedScreens: _mostVisitedScreens,
            currentRoute: _currentRoute,
            screenEntryTime: _screenEntryTime,
          ),
          PerformanceTabWidget(comprehensiveAnalytics: _comprehensiveAnalytics),
          UserBehaviorTabWidget(
            comprehensiveAnalytics: _comprehensiveAnalytics,
          ),
          SessionDataTabWidget(comprehensiveAnalytics: _comprehensiveAnalytics),
          ErrorsTabWidget(comprehensiveAnalytics: _comprehensiveAnalytics),
        ],
      ),
    );
  }

  void _clearHistory() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppLocalizations.getString('clear_analytics', 'en')),
        content: Text(
          AppLocalizations.getString('clear_analytics_confirmation', 'en'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(AppLocalizations.getString('cancel', 'en')),
          ),
          TextButton(
            onPressed: () {
              AnalyticsData.clearHistory();
              AnalyticsData.clearComprehensiveData();
              Navigator.of(context).pop();
              _loadAnalytics();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    AppLocalizations.getString('analytics_cleared', 'en'),
                  ),
                ),
              );
            },
            child: Text(AppLocalizations.getString('clear', 'en')),
          ),
        ],
      ),
    );
  }
}
