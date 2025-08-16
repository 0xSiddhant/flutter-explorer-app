import 'package:flutter/material.dart';
import '../data/tab_data.dart';
import '../models/tab_item_model.dart';

/// Service for managing tab operations
class TabService {
  /// Get current tab items
  static List<TabItemModel> getCurrentTabItems() {
    return TabData.getTabItems();
  }

  /// Get current navigation items
  static List<Map<String, dynamic>> getCurrentNavigationItems() {
    return TabData.getTabNavigationItems();
  }

  /// Update tab items when language changes
  static void updateTabItems(VoidCallback onUpdate) {
    // This method will be called when language changes
    // The actual update is handled by the listener in TabScreen
    onUpdate();
  }

  /// Get tab screen by index
  static Widget getTabScreen(int index) {
    final tabItems = getCurrentTabItems();
    if (index >= 0 && index < tabItems.length) {
      return tabItems[index].screen;
    }
    // Fallback to first tab
    return tabItems.isNotEmpty
        ? tabItems.first.screen
        : const SizedBox.shrink();
  }

  /// Get tab label by index
  static String getTabLabel(int index) {
    final tabItems = getCurrentTabItems();
    if (index >= 0 && index < tabItems.length) {
      return tabItems[index].label;
    }
    return '';
  }

  /// Get tab icon by index
  static IconData getTabIcon(int index) {
    final tabItems = getCurrentTabItems();
    if (index >= 0 && index < tabItems.length) {
      return tabItems[index].icon;
    }
    return Icons.home;
  }
}
