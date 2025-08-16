import 'package:core/core.dart';
import 'package:flutter/material.dart';
import '../models/tab_item_model.dart';
import '../../home_screen/home_screen.dart';
import '../../settings_screen/settings_screen.dart';

/// Data class for managing tab configuration
class TabData {
  /// Get all tab items based on current language
  static List<TabItemModel> getTabItems() {
    return [
      TabItemModel(
        icon: Icons.home,
        label: AppLocalizations.getString('home'),
        index: 0,
        screen: const HomeScreen(),
      ),
      TabItemModel(
        icon: Icons.settings,
        label: AppLocalizations.getString('settings'),
        index: 1,
        screen: const SettingsScreen(),
      ),
    ];
  }

  /// Get tab items for navigation (without screens)
  static List<Map<String, dynamic>> getTabNavigationItems() {
    return [
      {
        'icon': Icons.home,
        'label': AppLocalizations.getString('home'),
        'index': 0,
      },
      {
        'icon': Icons.settings,
        'label': AppLocalizations.getString('settings'),
        'index': 1,
      },
    ];
  }
}
