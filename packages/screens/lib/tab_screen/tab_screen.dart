import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:screens/tab_screen/tab_item_widget.dart';

import '../home_screen/home_screen.dart';
import '../settings_screen/settings_screen.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({super.key});

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> with TickerProviderStateMixin {
  late final TabController _tabController;
  int _currentIndex = 0;
  final List<TabItemWidgetModel> tabList = [
    TabItemWidgetModel(icon: Icons.home, label: 'Home', index: 0),
    TabItemWidgetModel(icon: Icons.settings, label: 'Settings', index: 1),
  ];

  @override
  void initState() {
    _tabController = TabController(
      length: tabList.length,
      vsync: this,
      initialIndex: _currentIndex,
    );
    _tabController.addListener(() {
      setState(() {
        _currentIndex = _tabController.index;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        controller: _tabController,
        children: [HomeScreen(), SettingsScreen()],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 20,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: tabList.map((e) {
                return TabItemWidget(
                  model: e,
                  isSelected: _currentIndex == e.index,
                  didSelect: (index) {
                    _tabController.animateTo(index);
                  },
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}
