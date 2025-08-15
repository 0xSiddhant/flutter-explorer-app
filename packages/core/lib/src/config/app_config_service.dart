import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import '../method_channel/method_channel.dart';

/// Service for managing app configuration from JSON file
/// Acts as an alternative to SharedPreferences for complex configuration
class AppConfigService {
  static const String _configFileName = 'app_config.json';

  static AppConfigService? _instance;
  static AppConfigService get instance => _instance ??= AppConfigService._();

  AppConfigService._();

  Map<String, dynamic> _config = {};
  bool _isInitialized = false;

  /// Initialize the configuration service
  Future<void> initialize() async {
    if (_isInitialized) return;

    try {
      await _loadConfig();
      _isInitialized = true;
    } catch (e) {
      debugPrint('Error initializing AppConfigService: $e');
      try {
        // Load default config if file doesn't exist
        _config = await _getDefaultConfig();
        debugPrint("AppConfigService initialized with default config");
        await _saveConfig();
        _isInitialized = true;
      } catch (saveError) {
        throw Exception(
          'Failed to initialize AppConfigService: $e. Also failed to save default config: $saveError',
        );
      }
    }
  }

  /// Load configuration from JSON file
  Future<void> _loadConfig() async {
    try {
      // Load from app documents directory
      final documentsDir = await getApplicationDocumentsDirectory();
      final configFile = File('${documentsDir.path}/$_configFileName');

      if (await configFile.exists()) {
        final jsonString = await configFile.readAsString();
        _config = json.decode(jsonString) as Map<String, dynamic>;
      } else {
        throw Exception('Config file not found');
      }
    } catch (e) {
      rethrow;
    }
  }

  /// Save configuration to JSON file
  Future<void> _saveConfig() async {
    try {
      // Save to app documents directory
      final documentsDir = await getApplicationDocumentsDirectory();
      final configFile = File('${documentsDir.path}/$_configFileName');

      final jsonString = json.encode(_config);
      await configFile.writeAsString(jsonString);
    } catch (e) {
      debugPrint('Error saving config: $e');
    }
  }

  /// Get default configuration from assets
  Future<Map<String, dynamic>> _getDefaultConfig() async {
    try {
      // Load default config from assets
      final jsonString = await rootBundle.loadString(
        'assets/config/default_config.json',
      );
      final config = json.decode(jsonString) as Map<String, dynamic>;

      // Update timestamp to current time
      config['lastUpdated'] = DateTime.now().toIso8601String();

      return config;
    } catch (e) {
      rethrow;
    }
  }

  /// Get app information from platform (via method channel)
  Future<Map<String, dynamic>> getAppInfo() async {
    try {
      final appVersionInfo = await MethodChannelManager.getAppVersion();

      return {
        'name': appVersionInfo['appName'] ?? 'Flutter Explorer',
        'version': appVersionInfo['version'] ?? '1.0.0',
        'buildNumber': appVersionInfo['buildNumber'] ?? '1',
        'environment': 'development', // Could be made configurable
      };
    } catch (e) {
      debugPrint('Error getting app info: $e');
      return {
        'name': 'Flutter Explorer',
        'version': '1.0.0',
        'buildNumber': '1',
        'environment': 'development',
      };
    }
  }

  /// Get a value from configuration
  T? getValue<T>(String key, {T? defaultValue}) {
    if (!_isInitialized) {
      debugPrint('AppConfigService not initialized. Call initialize() first.');
      return defaultValue;
    }

    final keys = key.split('.');
    dynamic current = _config;

    for (final k in keys) {
      if (current is Map && current.containsKey(k)) {
        current = current[k];
      } else {
        return defaultValue;
      }
    }

    return current is T ? current : defaultValue;
  }

  /// Set a value in configuration
  Future<void> setValue<T>(String key, T value) async {
    if (!_isInitialized) {
      debugPrint('AppConfigService not initialized. Call initialize() first.');
      return;
    }

    final keys = key.split('.');
    Map<String, dynamic> current = _config;

    // Navigate to the parent of the target key
    for (int i = 0; i < keys.length - 1; i++) {
      final k = keys[i];
      if (!current.containsKey(k) || current[k] is! Map) {
        current[k] = <String, dynamic>{};
      }
      current = current[k] as Map<String, dynamic>;
    }

    // Set the value
    current[keys.last] = value;

    // Update timestamp
    _config['lastUpdated'] = DateTime.now().toIso8601String();

    // Save to file
    await _saveConfig();
  }

  /// Get the entire configuration as a map
  Map<String, dynamic> getAllConfig() {
    if (!_isInitialized) {
      debugPrint('AppConfigService not initialized. Call initialize() first.');
      return {};
    }
    return Map.unmodifiable(_config);
  }

  /// Get configuration as formatted JSON string
  String getConfigAsJson() {
    if (!_isInitialized) {
      debugPrint('AppConfigService not initialized. Call initialize() first.');
      return '{}';
    }
    return const JsonEncoder.withIndent('  ').convert(_config);
  }

  /// Reset configuration to default
  Future<void> resetToDefault() async {
    try {
      _config = await _getDefaultConfig();
      await _saveConfig();
    } catch (e) {
      debugPrint('Error resetting config to default: $e');
    }
  }

  /// Reload configuration from file
  Future<void> reload() async {
    await _loadConfig();
  }

  /// Check if a feature is enabled
  bool isFeatureEnabled(String featureName) {
    return getValue<bool>('features.$featureName', defaultValue: false) ??
        false;
  }

  /// Enable/disable a feature
  Future<void> setFeatureEnabled(String featureName, bool enabled) async {
    await setValue('features.$featureName', enabled);
  }

  /// Get theme configuration
  Map<String, dynamic> getThemeConfig() {
    return getValue<Map<String, dynamic>>('theme', defaultValue: {}) ?? {};
  }

  /// Get accessibility configuration
  Map<String, dynamic> getAccessibilityConfig() {
    return getValue<Map<String, dynamic>>('accessibility', defaultValue: {}) ??
        {};
  }

  /// Get navigation configuration
  Map<String, dynamic> getNavigationConfig() {
    return getValue<Map<String, dynamic>>('navigation', defaultValue: {}) ?? {};
  }
}
