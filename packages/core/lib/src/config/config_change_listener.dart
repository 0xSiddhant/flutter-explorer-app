import 'package:flutter/material.dart';

/// Global listener for configuration changes
class ConfigChangeListener extends ChangeNotifier {
  static final ConfigChangeListener _instance =
      ConfigChangeListener._internal();

  factory ConfigChangeListener() {
    return _instance;
  }

  ConfigChangeListener._internal();

  /// Notify all listeners that configuration has changed
  void notifyConfigChanged() {
    notifyListeners();
  }

  static ConfigChangeListener get instance => _instance;
}
