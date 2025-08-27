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

class _TabScreenState extends State<TabScreen>
    with TickerProviderStateMixin, AppTabRestorationMixin {
  late final TabController _tabController;
  int _currentIndex = 0; // Will be updated with restored index
  late List<TabItemModel> _tabItems;

  @override
  void initState() {
    super.initState();
    _initializeTabs();
    _setupTabController();
    _setupLanguageListener();
    _setupRestorationListener();

    // Listen for restoration completion to update UI
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _updateCurrentIndexAfterRestoration();

        // Add a delay to ensure restoration is complete
        Future.delayed(const Duration(milliseconds: 300), () {
          if (mounted) {
            _updateCurrentIndexAfterRestoration();
          }
        });
      }
    });
  }

  void _initializeTabs() {
    _tabItems = TabService.getCurrentTabItems();
    debugPrint('Tab screen initialized with ${_tabItems.length} tabs');
  }

  void _setupTabController() {
    // Initialize current index with restored value
    _currentIndex = currentTabIndex;

    _tabController = TabController(
      length: _tabItems.length,
      vsync: this,
      initialIndex: currentTabIndex, // Use restored tab index
    );
    _tabController.addListener(_onTabChanged);

    // Restore tab index and listen for changes
    restoreTabIndex(_tabController);
    listenToTabChanges(_tabController);

    // Register for tab index change notifications
    registerForTabIndexChanges(_tabController);

    // Force update the current index to match the restored tab index
    // Use multiple post-frame callbacks to ensure the tab controller is ready
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted && _tabController.index != currentTabIndex) {
        _tabController.animateTo(currentTabIndex);
        setState(() {
          _currentIndex = currentTabIndex;
        });

        // Add another post-frame callback to ensure the animation completes
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted && _currentIndex != currentTabIndex) {
            setState(() {
              _currentIndex = currentTabIndex;
            });
          }
        });
      }
    });
  }

  void _setupLanguageListener() {
    // Listen for language changes to update tab labels
    LanguageChangeListener.instance.addListener(_onLanguageChanged);
  }

  void _setupRestorationListener() {
    // Listen for restoration changes to update tab controller
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted && _tabController.index != currentTabIndex) {
        _tabController.animateTo(currentTabIndex);
        setState(() {
          _currentIndex = currentTabIndex;
        });
      }

      // Force update current index to match restored value
      if (mounted && _currentIndex != currentTabIndex) {
        setState(() {
          _currentIndex = currentTabIndex;
        });
      }
    });
  }

  void _onTabChanged() {
    setState(() {
      _currentIndex = _tabController.index;
    });

    // Don't save tab index during restoration to avoid conflicts
    if (!StateRestorationService.instance.isRestoring) {
      // Explicitly save the tab index
      saveTabIndex(_currentIndex);
    }
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

  void _updateCurrentIndexAfterRestoration() {
    if (_currentIndex != currentTabIndex) {
      setState(() {
        _currentIndex = currentTabIndex;
      });
    }
  }

  @override
  void dispose() {
    LanguageChangeListener.instance.removeListener(_onLanguageChanged);
    _tabController.removeListener(_onTabChanged);
    unregisterFromTabIndexChanges();
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
