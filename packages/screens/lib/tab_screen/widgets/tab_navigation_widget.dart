import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:screens/tab_screen/widgets/tab_item_widget.dart';
import '../services/tab_service.dart';

/// Widget for tab navigation bar
class TabNavigationWidget extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTabSelected;

  const TabNavigationWidget({
    super.key,
    required this.currentIndex,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    final navigationItems = TabService.getCurrentNavigationItems();

    return Container(
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
            children: navigationItems.map((item) {
              return TabItemWidget(
                model: TabItemWidgetModel(
                  icon: item['icon'] as IconData,
                  label: item['label'] as String,
                  index: item['index'] as int,
                ),
                isSelected: currentIndex == item['index'],
                didSelect: onTabSelected,
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
