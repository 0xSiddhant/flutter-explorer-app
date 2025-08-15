import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'models/tab_item_model.dart';
import 'services/tab_service.dart';
import 'widgets/tab_navigation_widget.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({super.key});

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> with TickerProviderStateMixin {
  late final TabController _tabController;
  int _currentIndex = 0;
  late List<TabItemModel> _tabItems;

  @override
  void initState() {
    super.initState();
    _initializeTabs();
    _setupTabController();
    _setupLanguageListener();
  }

  void _initializeTabs() {
    _tabItems = TabService.getCurrentTabItems();
    debugPrint('Tab screen initialized with ${_tabItems.length} tabs');
  }

  void _setupTabController() {
    _tabController = TabController(
      length: _tabItems.length,
      vsync: this,
      initialIndex: _currentIndex,
    );
    _tabController.addListener(_onTabChanged);
  }

  void _setupLanguageListener() {
    // Listen for language changes to update tab labels
    LanguageChangeListener.instance.addListener(_onLanguageChanged);
  }

  void _onTabChanged() {
    setState(() {
      _currentIndex = _tabController.index;
    });
  }

  void _onLanguageChanged() {
    setState(() {
      _tabItems = TabService.getCurrentTabItems();
      // Update tab controller length if needed
      if (_tabController.length != _tabItems.length) {
        _tabController.dispose();
        _setupTabController();
      }
    });
  }

  void _onTabSelected(int index) {
    _tabController.animateTo(index);
  }

  @override
  void dispose() {
    LanguageChangeListener.instance.removeListener(_onLanguageChanged);
    _tabController.removeListener(_onTabChanged);
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        controller: _tabController,
        children: _tabItems.asMap().entries.map((entry) {
          final index = entry.key;
          final tab = entry.value;
          return KeyedSubtree(
            key: PageStorageKey<String>('tab_$index'),
            child: tab.screen,
          );
        }).toList(),
      ),
      bottomNavigationBar: TabNavigationWidget(
        currentIndex: _currentIndex,
        onTabSelected: _onTabSelected,
      ),
    );
  }
}
