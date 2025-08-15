import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:common/common.dart';
import 'data/lifecycle_data.dart';
import 'widgets/lifecycle_card.dart';
import 'models/lifecycle_event_model.dart';

class LifecycleManagementScreen extends StatefulWidget {
  const LifecycleManagementScreen({super.key});

  @override
  State<LifecycleManagementScreen> createState() =>
      _LifecycleManagementScreenState();
}

class _LifecycleManagementScreenState extends State<LifecycleManagementScreen>
    with RouteAwareMixin, WidgetsBindingObserver, TickerProviderStateMixin {
  final List<LifecycleEventModel> _lifecycleEvents = [];
  bool _isAppInForeground = true;
  bool _isScreenVisible = true;
  DateTime? _screenEntryTime;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _screenEntryTime = DateTime.now();
    _tabController = TabController(length: 3, vsync: this);
    _addEvent('initState', 'Widget initialized');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _addEvent('didChangeDependencies', 'Dependencies changed');
  }

  @override
  void didUpdateWidget(covariant LifecycleManagementScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    _addEvent('didUpdateWidget', 'Widget updated');
  }

  @override
  void reassemble() {
    super.reassemble();
    _addEvent('reassemble', 'Widget reassembled (hot reload)');
  }

  @override
  void deactivate() {
    super.deactivate();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _tabController.dispose();
    super.dispose();
  }

  // App lifecycle methods
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    String description;
    switch (state) {
      case AppLifecycleState.resumed:
        description = 'App resumed (foreground)';
        _isAppInForeground = true;
        break;
      case AppLifecycleState.inactive:
        description = 'App inactive (transitioning)';
        break;
      case AppLifecycleState.paused:
        description = 'App paused (background)';
        _isAppInForeground = false;
        break;
      case AppLifecycleState.detached:
        description = 'App detached (terminated)';
        break;
      case AppLifecycleState.hidden:
        description = 'App hidden';
        break;
    }
    _addEvent('AppLifecycle: ${state.name}', description);
  }

  // RouteAware methods
  @override
  void onScreenVisible() {
    super.onScreenVisible();
    _isScreenVisible = true;
    _addEvent('onScreenVisible', 'Screen became visible');
  }

  @override
  void onScreenInvisible() {
    super.onScreenInvisible();
    _isScreenVisible = false;
    _addEvent('onScreenInvisible', 'Screen became invisible');
  }

  @override
  void onScreenPushed() {
    super.onScreenPushed();
    _addEvent('onScreenPushed', 'Screen was pushed');
  }

  @override
  void onScreenPopped() {
    super.onScreenPopped();
    _addEvent('onScreenPopped', 'Screen was popped');
  }

  void _addEvent(String event, String description) {
    if (mounted) {
      setState(() {
        _lifecycleEvents.insert(
          0,
          LifecycleEventModel(
            event: event,
            description: description,
            timestamp: DateTime.now(),
            isAppForeground: _isAppInForeground,
            isScreenVisible: _isScreenVisible,
          ),
        );
      });
    }
  }

  void _clearEvents() {
    setState(() {
      _lifecycleEvents.clear();
    });
  }

  void _simulateLifecycleEvent() {
    _addEvent('Manual Event', 'User triggered lifecycle event');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.getString('lifecycle_management')),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(icon: Icon(Icons.dashboard), text: 'Overview'),
            Tab(icon: Icon(Icons.auto_awesome), text: 'Phases'),
            Tab(icon: Icon(Icons.history), text: 'Events'),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _simulateLifecycleEvent,
            tooltip: 'Simulate Event',
          ),
          IconButton(
            icon: const Icon(Icons.clear_all),
            onPressed: _clearEvents,
            tooltip: 'Clear Events',
          ),
        ],
      ),
      body: Column(
        children: [
          _buildStatusBar(),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildOverviewTab(),
                _buildPhasesTab(),
                _buildEventsTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBar() {
    return Container(
      padding: const EdgeInsets.all(12.0),
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
      child: Row(
        children: [
          Expanded(
            child: _buildStatusChip(
              'App State',
              _isAppInForeground ? 'Foreground' : 'Background',
              _isAppInForeground ? Colors.green : Colors.orange,
              Icons.apps,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: _buildStatusChip(
              'Screen State',
              _isScreenVisible ? 'Visible' : 'Hidden',
              _isScreenVisible ? Colors.blue : Colors.red,
              Icons.visibility,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: _buildStatusChip(
              'Time on Screen',
              _screenEntryTime != null
                  ? '${DateTime.now().difference(_screenEntryTime!).inSeconds}s'
                  : '0s',
              Colors.purple,
              Icons.timer,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: _buildStatusChip(
              'Total Events',
              '${_lifecycleEvents.length}',
              Colors.teal,
              Icons.event_note,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusChip(
    String label,
    String value,
    Color color,
    IconData icon,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(height: 2),
          Text(
            value,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: color,
              fontWeight: FontWeight.bold,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Lifecycle Overview',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),
                  _buildOverviewItem(
                    'Widget Lifecycle',
                    'Track widget creation, updates, and disposal',
                  ),
                  _buildOverviewItem(
                    'App Lifecycle',
                    'Monitor app foreground/background states',
                  ),
                  _buildOverviewItem(
                    'Navigation Lifecycle',
                    'Track screen visibility and navigation',
                  ),
                  _buildOverviewItem(
                    'Event Logging',
                    'Real-time event tracking with timestamps',
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Recent Events',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),
                  if (_lifecycleEvents.isEmpty)
                    const Text(
                      'No events recorded yet. Navigate to other tabs or interact with the app.',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    )
                  else
                    ..._lifecycleEvents
                        .take(5)
                        .map((event) => _buildRecentEventItem(event)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOverviewItem(String title, String description) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: const BoxDecoration(
              color: Colors.blue,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(
                    context,
                  ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                ),
                Text(description, style: Theme.of(context).textTheme.bodySmall),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentEventItem(LifecycleEventModel event) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: _getEventColor(event.event),
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              event.event,
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w500),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Text(
            TimeUtils.formatTimestamp(event.timestamp),
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPhasesTab() {
    final lifecycleCards = LifecycleData.getLifecycleCards(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Lifecycle Phases',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 0.85,
            ),
            itemCount: lifecycleCards.length,
            itemBuilder: (context, index) {
              return LifecycleCard(lifecycle: lifecycleCards[index]);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildEventsTab() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Text(
                'Lifecycle Events',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const Spacer(),
              if (_lifecycleEvents.isNotEmpty)
                TextButton.icon(
                  onPressed: _clearEvents,
                  icon: const Icon(Icons.clear_all, size: 16),
                  label: Text(AppLocalizations.getString('clear_all')),
                ),
            ],
          ),
        ),
        Expanded(
          child: _lifecycleEvents.isEmpty
              ? const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.event_note, size: 64, color: Colors.grey),
                      SizedBox(height: 16),
                      Text(
                        'No lifecycle events recorded yet',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Navigate or interact with the app to see events',
                        style: TextStyle(
                          color: Colors.grey,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  itemCount: _lifecycleEvents.length,
                  itemBuilder: (context, index) {
                    final event = _lifecycleEvents[index];
                    return _buildEventItem(event, index);
                  },
                ),
        ),
      ],
    );
  }

  Widget _buildEventItem(LifecycleEventModel event, int index) {
    final isRecent = DateTime.now().difference(event.timestamp).inSeconds < 5;

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 8.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: isRecent
            ? Theme.of(
                context,
              ).colorScheme.primaryContainer.withValues(alpha: 0.3)
            : Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(
          color: isRecent
              ? Theme.of(context).colorScheme.primary.withValues(alpha: 0.3)
              : Theme.of(context).colorScheme.outline.withValues(alpha: 0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: _getEventColor(event.event),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                flex: 3,
                child: Text(
                  event.event,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                flex: 1,
                child: Text(
                  TimeUtils.formatTimestamp(event.timestamp),
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                  textAlign: TextAlign.end,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            event.description,
            style: Theme.of(context).textTheme.bodySmall,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Wrap(
            spacing: 8,
            runSpacing: 4,
            children: [
              _buildEventStatusChip('App', event.isAppForeground),
              _buildEventStatusChip('Screen', event.isScreenVisible),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEventStatusChip(String label, bool isActive) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: isActive
            ? Colors.green.withValues(alpha: 0.1)
            : Colors.red.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        '$label: ${isActive ? "ON" : "OFF"}',
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
          color: isActive ? Colors.green : Colors.red,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Color _getEventColor(String event) {
    if (event.contains('AppLifecycle')) return Colors.blue;
    if (event.contains('Screen')) return Colors.green;
    if (event.contains('initState') || event.contains('dispose')) {
      return Colors.red;
    }
    if (event.contains('Manual')) return Colors.purple;
    return Colors.grey;
  }
}
