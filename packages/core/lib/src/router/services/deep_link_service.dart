import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import '../deep_link_manager.dart';

/// Simplified service for handling platform-specific deep link initialization
class DeepLinkService {
  static final DeepLinkService _instance = DeepLinkService._internal();
  factory DeepLinkService() => _instance;
  DeepLinkService._internal();

  static DeepLinkService get instance => _instance;

  // Method channel for handling deep links
  static const MethodChannel _channel = MethodChannel('deep_link_channel');

  /// Initialize deep link handling
  Future<void> initialize(GoRouter router) async {
    try {
      debugPrint('DeepLinkService: Initializing deep link handling');

      // Debug deep link mappings
      DeepLinkManager.instance.debugDeepLinkMappings();

      // Set up method channel handler
      _channel.setMethodCallHandler((call) async {
        if (call.method == 'handleDeepLink') {
          final url = call.arguments as String;
          debugPrint('DeepLinkService: Received deep link: $url');
          await DeepLinkManager.instance.handleDeepLink(url, router);
        }
      });

      // Listen for initial deep link (if app was opened via deep link)
      final initialLink = await _getInitialLink();
      if (initialLink != null) {
        debugPrint('DeepLinkService: Initial deep link found: $initialLink');
        await DeepLinkManager.instance.handleDeepLink(initialLink, router);
      }

      debugPrint(
        'DeepLinkService: Deep link handling initialized successfully',
      );
    } catch (e) {
      debugPrint('DeepLinkService: Error initializing deep link handling: $e');
    }
  }

  /// Get initial deep link (if app was opened via deep link)
  Future<String?> _getInitialLink() async {
    try {
      final result = await _channel.invokeMethod<String>('getInitialLink');
      return result;
    } catch (e) {
      debugPrint('DeepLinkService: Error getting initial link: $e');
      return null;
    }
  }

  /// Handle deep link manually (for testing)
  Future<void> handleDeepLink(String url, GoRouter router) async {
    await DeepLinkManager.instance.handleDeepLink(url, router);
  }
}
