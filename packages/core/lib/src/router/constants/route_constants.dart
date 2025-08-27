/// Model representing a route with its path and name
class RouteModel {
  final String path;
  final String name;

  const RouteModel({required this.path, required this.name});

  @override
  String toString() => 'RouteModel(path: $path, name: $name)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is RouteModel && other.path == path && other.name == name;
  }

  @override
  int get hashCode => path.hashCode ^ name.hashCode;
}

/// Constants for all application routes
class RouteConstants {
  // Private constructor to prevent instantiation
  RouteConstants._();

  // Route models
  static const RouteModel home = RouteModel(path: '/', name: 'home');
  static const RouteModel splash = RouteModel(path: '/splash', name: 'splash');
  static const RouteModel settings = RouteModel(
    path: '/settings',
    name: 'settings',
  );
  static const RouteModel tabScreen = RouteModel(
    path: '/tab_screen',
    name: 'tab-screen',
  );
  static const RouteModel detail = RouteModel(path: '/detail', name: 'detail');
  static const RouteModel theming = RouteModel(
    path: '/theming',
    name: 'theming',
  );
  static const RouteModel nativeCommunication = RouteModel(
    path: '/native_communication',
    name: 'native-communication',
  );
  static const RouteModel backgroundTasks = RouteModel(
    path: '/background_tasks',
    name: 'background-tasks',
  );
  static const RouteModel internationalization = RouteModel(
    path: '/internationalization',
    name: 'internationalization',
  );
  static const RouteModel accessibility = RouteModel(
    path: '/accessibility',
    name: 'accessibility',
  );
  static const RouteModel fileManagement = RouteModel(
    path: '/file_management',
    name: 'file-management',
  );
  static const RouteModel advancedProcessing = RouteModel(
    path: '/advanced_processing',
    name: 'advanced-processing',
  );
  static const RouteModel navigationAnalytics = RouteModel(
    path: '/navigation_analytics',
    name: 'navigation-analytics',
  );
  static const RouteModel lifecycleManagement = RouteModel(
    path: '/lifecycle_management',
    name: 'lifecycle-management',
  );
  static const RouteModel typographyShowcase = RouteModel(
    path: '/typography_showcase',
    name: 'typography-showcase',
  );
  static const RouteModel themeComponentShowcase = RouteModel(
    path: '/theme_component_showcase',
    name: 'theme-component-showcase',
  );
  static const RouteModel configViewer = RouteModel(
    path: '/config_viewer',
    name: 'config-viewer',
  );
  static const RouteModel deepLinkTest = RouteModel(
    path: '/deep_link_test',
    name: 'deep-link-test',
  );

  // List of all routes
  static const List<RouteModel> allRoutes = [
    home,
    splash,
    settings,
    tabScreen,
    detail,
    theming,
    nativeCommunication,
    backgroundTasks,
    internationalization,
    accessibility,
    fileManagement,
    advancedProcessing,
    navigationAnalytics,
    lifecycleManagement,
    typographyShowcase,
    themeComponentShowcase,
    configViewer,
    deepLinkTest,
  ];

  /// Get route model from path
  static RouteModel? getRouteFromPath(String path) {
    try {
      return allRoutes.firstWhere((route) => route.path == path);
    } catch (e) {
      return null;
    }
  }

  /// Get route model from name
  static RouteModel? getRouteFromName(String name) {
    try {
      return allRoutes.firstWhere((route) => route.name == name);
    } catch (e) {
      return null;
    }
  }

  /// Get route name from path
  static String getRouteNameFromPath(String path) {
    final route = getRouteFromPath(path);
    return route?.name ?? 'unknown';
  }

  /// Get path from route name
  static String getPathFromRouteName(String routeName) {
    final route = getRouteFromName(routeName);
    return route?.path ?? home.path;
  }

  /// Check if a path exists
  static bool isPathValid(String path) {
    return getRouteFromPath(path) != null;
  }

  /// Check if a route name exists
  static bool isRouteNameValid(String routeName) {
    return getRouteFromName(routeName) != null;
  }

  // Deep link constants
  static const String deepLinkScheme = 'frouter';

  // Deep link path mappings
  static const Map<String, RouteModel> deepLinkRoutes = {
    'home': tabScreen,
    'setting': settings,
    'settings': settings,
    'config': configViewer,
    'i10n': internationalization,
    'internationalization': internationalization,
    'theme_preview': themeComponentShowcase,
    'theme': theming,
    'theming': theming,
    'accessibility': accessibility,
    'file_management': fileManagement,
    'file': fileManagement,
    'background_tasks': backgroundTasks,
    'background': backgroundTasks,
    'native_communication': nativeCommunication,
    'native': nativeCommunication,
    'navigation_analytics': navigationAnalytics,
    'analytics': navigationAnalytics,
    'lifecycle_management': lifecycleManagement,
    'lifecycle': lifecycleManagement,
    'advanced_processing': advancedProcessing,
    'advanced': advancedProcessing,
    'typography_showcase': typographyShowcase,
    'typography': typographyShowcase,
    'deep_link_test': deepLinkTest,
  };

  // Allowed deep link paths (for validation)
  static const Set<String> allowedDeepLinks = {
    'home',
    'setting',
    'settings',
    'config',
    'i10n',
    'internationalization',
    'theme_preview',
    'theme',
    'theming',
    'accessibility',
    'file_management',
    'file',
    'background_tasks',
    'background',
    'native_communication',
    'native',
    'navigation_analytics',
    'analytics',
    'lifecycle_management',
    'lifecycle',
    'advanced_processing',
    'advanced',
    'typography_showcase',
    'typography',
    'deep_link_test',
  };

  /// Get route model for a deep link path
  static RouteModel? getRouteForDeepLink(String deepLinkPath) {
    return deepLinkRoutes[deepLinkPath];
  }

  /// Check if a deep link path is allowed
  static bool isDeepLinkAllowed(String deepLinkPath) {
    return allowedDeepLinks.contains(deepLinkPath);
  }

  /// Get all allowed deep link paths
  static Set<String> getAllowedDeepLinks() {
    return Set.unmodifiable(allowedDeepLinks);
  }

  /// Get deep link scheme
  static String getDeepLinkScheme() {
    return deepLinkScheme;
  }
}
