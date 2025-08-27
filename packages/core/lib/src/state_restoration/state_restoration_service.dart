import 'package:flutter/material.dart';
import '../router/constants/route_constants.dart';
import '../config/app_config_service.dart';

/// Service for managing app state restoration
/// Handles route restoration, app state persistence, and state recovery
class StateRestorationService {
  static final StateRestorationService _instance =
      StateRestorationService._internal();
  factory StateRestorationService() => _instance;
  StateRestorationService._internal();

  // Callback for tab index changes
  VoidCallback? _onTabIndexChanged;

  static StateRestorationService get instance => _instance;

  // Restoration keys
  static const String _navigationStackKey = 'navigation_stack';
  static const String _currentRouteKey = 'current_route';
  static const String _tabIndexRestorationKey = 'tab_index';
  static const String _scrollPositionRestorationKey = 'scroll_position';
  static const String _appStateRestorationKey = 'app_state';

  // Current app state
  List<String> _navigationStack = [RouteConstants.splash.path];
  String _currentRoute = RouteConstants.splash.path;
  int _currentTabIndex = 0;
  Map<String, double> _scrollPositions = {};
  Map<String, dynamic> _appState = {};
  bool _isRestoring = false;

  /// Get current route for restoration
  String get currentRoute => _currentRoute;

  /// Get current tab index for restoration
  int get currentTabIndex => _currentTabIndex;

  /// Get scroll positions for restoration
  Map<String, double> get scrollPositions => Map.unmodifiable(_scrollPositions);

  /// Get app state for restoration
  Map<String, dynamic> get appState => Map.unmodifiable(_appState);

  /// Initialize state restoration service
  Future<void> initialize() async {
    try {
      // Load saved state from configuration
      await _loadSavedState();
      debugPrint('StateRestorationService: Initialized successfully');
    } catch (e) {
      debugPrint('StateRestorationService: Error initializing: $e');
      // Use default state if loading fails
      _setDefaultState();
    }
  }

  /// Get navigation stack
  List<String> get navigationStack => List.unmodifiable(_navigationStack);

  /// Update current route and navigation stack
  void updateRoute(String route) {
    _currentRoute = route;
    _saveState();
    debugPrint('StateRestorationService: Route updated to $route');
  }

  /// Push route to navigation stack
  void pushRoute(String route) {
    // Don't add routes during restoration to avoid duplicates
    if (!_isRestoring) {
      // Check if this is a new navigation (not a back navigation)
      if (_navigationStack.isNotEmpty && _navigationStack.last == route) {
        debugPrint(
          'StateRestorationService: Route already at top of stack: $route',
        );
        return;
      }

      _navigationStack.add(route);
      _currentRoute = route;
      _saveState();
      debugPrint('StateRestorationService: Route pushed to stack: $route');
    } else {
      debugPrint(
        'StateRestorationService: Skipping route push during restoration: $route',
      );
    }
  }

  /// Navigate to a new route (clears navigation stack)
  void navigateToRoute(String route) {
    if (!_isRestoring) {
      _navigationStack = [route];
      _currentRoute = route;
      _saveState();
      debugPrint('StateRestorationService: Navigated to route: $route');
    }
  }

  /// Pop route from navigation stack
  String? popRoute() {
    if (_navigationStack.length > 1) {
      final poppedRoute = _navigationStack.removeLast();
      _currentRoute = _navigationStack.last;
      _saveState();
      debugPrint(
        'StateRestorationService: Route popped from stack: $poppedRoute, current: $_currentRoute',
      );
      return poppedRoute;
    }
    return null;
  }

  /// Validate and fix navigation stack
  void validateNavigationStack() {
    // Remove any duplicate consecutive routes
    final cleanedStack = <String>[];
    String? lastRoute;

    for (final route in _navigationStack) {
      if (route != lastRoute) {
        cleanedStack.add(route);
        lastRoute = route;
      }
    }

    if (cleanedStack.length != _navigationStack.length) {
      _navigationStack = cleanedStack;
      _currentRoute = _navigationStack.last;
      _saveState();
      debugPrint(
        'StateRestorationService: Navigation stack cleaned: $_navigationStack',
      );
    }
  }

  /// Sync navigation stack with current route
  void syncNavigationStack(String currentRoute) {
    if (_currentRoute != currentRoute) {
      _currentRoute = currentRoute;

      // Update the last route in the stack if it's different
      if (_navigationStack.isNotEmpty &&
          _navigationStack.last != currentRoute) {
        _navigationStack[_navigationStack.length - 1] = currentRoute;
      }

      _saveState();
      debugPrint(
        'StateRestorationService: Navigation stack synced, current: $_currentRoute',
      );
    }
  }

  /// Replace current route in navigation stack
  void replaceRoute(String route) {
    if (_navigationStack.isNotEmpty) {
      _navigationStack[_navigationStack.length - 1] = route;
      _currentRoute = route;
      _saveState();
      debugPrint('StateRestorationService: Route replaced: $route');
    }
  }

  /// Clear navigation stack and set new route
  void clearAndSetRoute(String route) {
    _navigationStack = [route];
    _currentRoute = route;
    _saveState();
    debugPrint('StateRestorationService: Stack cleared and route set: $route');
  }

  /// Get the route to navigate back to
  String? getPreviousRoute() {
    if (_navigationStack.length > 1) {
      return _navigationStack[_navigationStack.length - 2];
    }
    return null;
  }

  /// Check if navigation stack has multiple routes
  bool get hasNavigationHistory => _navigationStack.length > 1;

  /// Set restoration mode
  void setRestoringMode(bool isRestoring) {
    _isRestoring = isRestoring;
    debugPrint('StateRestorationService: Restoration mode set to $isRestoring');
  }

  /// Restore navigation stack from saved data
  void restoreNavigationStack(List<String> savedStack) {
    if (savedStack.isNotEmpty) {
      _navigationStack = List<String>.from(savedStack);
      _currentRoute = _navigationStack.last;
      debugPrint(
        'StateRestorationService: Navigation stack restored: $_navigationStack',
      );
    }
  }

  /// Check if currently in restoration mode
  bool get isRestoring => _isRestoring;

  /// Update current tab index
  void updateTabIndex(int tabIndex) {
    if (_currentTabIndex != tabIndex) {
      _currentTabIndex = tabIndex;
      _saveState();
      debugPrint('StateRestorationService: Tab index updated to $tabIndex');

      // Notify listeners about tab index change
      _notifyTabIndexChanged(tabIndex);
    }
  }

  /// Update tab index during restoration (without saving state immediately)
  void updateTabIndexDuringRestoration(int tabIndex) {
    if (_currentTabIndex != tabIndex) {
      _currentTabIndex = tabIndex;
      debugPrint(
        'StateRestorationService: Tab index updated during restoration to $tabIndex',
      );

      // Notify listeners about tab index change
      _notifyTabIndexChanged(tabIndex);
    }
  }

  /// Save state after restoration is complete
  Future<void> saveStateAfterRestoration() async {
    await _saveState();
    debugPrint('StateRestorationService: State saved after restoration');
  }

  /// Update tab index after restoration is complete
  void updateTabIndexAfterRestoration(int tabIndex) {
    if (_currentTabIndex != tabIndex) {
      _currentTabIndex = tabIndex;
      _saveState();
      debugPrint(
        'StateRestorationService: Tab index updated after restoration to $tabIndex',
      );

      // Notify listeners about tab index change
      _notifyTabIndexChanged(tabIndex);
    }
  }

  /// Register callback for tab index changes
  void registerTabIndexCallback(VoidCallback callback) {
    _onTabIndexChanged = callback;
  }

  /// Unregister callback for tab index changes
  void unregisterTabIndexCallback() {
    _onTabIndexChanged = null;
  }

  /// Notify listeners about tab index change
  void _notifyTabIndexChanged(int tabIndex) {
    if (_onTabIndexChanged != null) {
      _onTabIndexChanged!();
    }
  }

  /// Update scroll position for a specific screen
  void updateScrollPosition(String screenKey, double position) {
    _scrollPositions[screenKey] = position;
    _saveState();
    debugPrint(
      'StateRestorationService: Scroll position updated for $screenKey: $position',
    );
  }

  /// Get scroll position for a specific screen
  double getScrollPosition(String screenKey) {
    return _scrollPositions[screenKey] ?? 0.0;
  }

  /// Update app state for a specific key
  void updateAppState(String key, dynamic value) {
    _appState[key] = value;
    _saveState();
    debugPrint('StateRestorationService: App state updated for $key: $value');
  }

  /// Get app state for a specific key
  dynamic getAppState(String key) {
    return _appState[key];
  }

  /// Clear all saved state
  Future<void> clearState() async {
    _navigationStack = [RouteConstants.splash.path];
    _currentRoute = RouteConstants.splash.path;
    _currentTabIndex = 0;
    _scrollPositions.clear();
    _appState.clear();
    await _saveState();
    debugPrint('StateRestorationService: State cleared');
  }

  /// Get restoration data for Flutter's restoration system
  Map<String, dynamic> getRestorationData() {
    return {
      _navigationStackKey: _navigationStack,
      _currentRouteKey: _currentRoute,
      _tabIndexRestorationKey: _currentTabIndex,
      _scrollPositionRestorationKey: _scrollPositions,
      _appStateRestorationKey: _appState,
    };
  }

  /// Restore state from Flutter's restoration system
  void restoreFromData(Map<String, dynamic> data) {
    _navigationStack = List<String>.from(
      data[_navigationStackKey] ?? [RouteConstants.splash.path],
    );
    _currentRoute = data[_currentRouteKey] ?? RouteConstants.splash.path;
    _currentTabIndex = data[_tabIndexRestorationKey] ?? 0;
    _scrollPositions = Map<String, double>.from(
      data[_scrollPositionRestorationKey] ?? {},
    );
    _appState = Map<String, dynamic>.from(data[_appStateRestorationKey] ?? {});
    debugPrint('StateRestorationService: State restored from data');
  }

  /// Load saved state from configuration
  Future<void> _loadSavedState() async {
    try {
      final config = AppConfigService.instance.getAllConfig();
      final stateData =
          config['state_restoration'] as Map<String, dynamic>? ?? {};

      _navigationStack = List<String>.from(
        stateData['navigation_stack'] ?? [RouteConstants.splash.path],
      );
      _currentRoute = stateData['current_route'] ?? RouteConstants.splash.path;
      _currentTabIndex = stateData['current_tab_index'] ?? 0;
      _scrollPositions = Map<String, double>.from(
        stateData['scroll_positions'] ?? {},
      );
      _appState = Map<String, dynamic>.from(stateData['app_state'] ?? {});

      debugPrint('StateRestorationService: State loaded from config');
    } catch (e) {
      debugPrint('StateRestorationService: Error loading state: $e');
      _setDefaultState();
    }
  }

  /// Save current state to configuration
  Future<void> _saveState() async {
    try {
      final stateData = {
        'navigation_stack': _navigationStack,
        'current_route': _currentRoute,
        'current_tab_index': _currentTabIndex,
        'scroll_positions': _scrollPositions,
        'app_state': _appState,
      };

      await AppConfigService.instance.setValue('state_restoration', stateData);
      debugPrint('StateRestorationService: State saved to config');
    } catch (e) {
      debugPrint('StateRestorationService: Error saving state: $e');
    }
  }

  /// Set default state
  void _setDefaultState() {
    _navigationStack = [RouteConstants.splash.path];
    _currentRoute = RouteConstants.splash.path;
    _currentTabIndex = 0;
    _scrollPositions = {};
    _appState = {};
    debugPrint('StateRestorationService: Default state set');
  }

  /// Validate if a route is valid for restoration
  bool isValidRestorationRoute(String route) {
    return RouteConstants.isPathValid(route);
  }

  /// Get restoration key for a specific screen
  static String getRestorationKey(String screenName) {
    return '${screenName}_restoration';
  }

  /// Get scroll restoration key for a specific screen
  static String getScrollRestorationKey(String screenName) {
    return '${screenName}_scroll';
  }
}
