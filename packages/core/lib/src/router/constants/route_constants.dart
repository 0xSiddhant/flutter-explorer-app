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
    path: '/tab-screen',
    name: 'tab-screen',
  );
  static const RouteModel detail = RouteModel(path: '/detail', name: 'detail');
  static const RouteModel theming = RouteModel(
    path: '/theming',
    name: 'theming',
  );
  static const RouteModel nativeCommunication = RouteModel(
    path: '/native-communication',
    name: 'native-communication',
  );
  static const RouteModel backgroundTasks = RouteModel(
    path: '/background-tasks',
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
    path: '/file-management',
    name: 'file-management',
  );
  static const RouteModel advancedProcessing = RouteModel(
    path: '/advanced-processing',
    name: 'advanced-processing',
  );
  static const RouteModel navigationAnalytics = RouteModel(
    path: '/navigation-analytics',
    name: 'navigation-analytics',
  );
  static const RouteModel lifecycleManagement = RouteModel(
    path: '/lifecycle-management',
    name: 'lifecycle-management',
  );
  static const RouteModel typographyShowcase = RouteModel(
    path: '/typography-showcase',
    name: 'typography-showcase',
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
}
