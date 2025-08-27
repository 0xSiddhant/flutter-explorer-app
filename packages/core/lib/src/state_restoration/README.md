# State Restoration System

A comprehensive state restoration system that preserves and restores the complete app state when the app is reopened. This system handles navigation stack restoration, tab index preservation, scroll position restoration, and app state persistence.

## 🎯 What is State Restoration?

State restoration ensures that when users close and reopen your app, they return to exactly where they left off. This includes:

- **Navigation Stack**: The complete path of screens they were on
- **Tab Index**: Which tab was selected (Home or Settings)
- **Scroll Positions**: Where they were scrolled on each screen
- **App State**: Any custom data or settings

## 🏗️ System Architecture

```
StateRestorationService (Core Service)
├── NavigationRestorationService (Navigation Logic)
├── AppRestorationMixin (General Restoration)
└── AppTabRestorationMixin (Tab-Specific Restoration)
```

## 📁 File Structure

```
state_restoration/
├── README.md                           # This file
├── state_restoration_service.dart      # Core state management
├── navigation_restoration_service.dart # Navigation stack restoration
├── restoration_mixin.dart              # Mixins for easy integration
└── state_restoration.dart              # Main exports
```

## 🔧 How It Works (Step by Step)

### 1. **State Saving Process**

When users navigate through the app:

```dart
// 1. User navigates to a screen
router.push('/accessibility');

// 2. StateRestorationService automatically saves:
//    - Current route: '/accessibility'
//    - Navigation stack: ['/splash', '/tab-screen', '/accessibility']
//    - Tab index: 0 (Home tab)
//    - Scroll positions: { 'accessibility_screen_scroll': 150.0 }
//    - App state: { 'user_preferences': {...} }
```

### 2. **Tab Index Management**

When users switch tabs:

```dart
// 1. User taps Settings tab
// 2. TabController changes to index 1
// 3. _onTabChanged() is called
// 4. Tab index is saved: currentTabIndex = 1
// 5. State is persisted to configuration
```

### 3. **App Closure and Restoration**

When the app is closed and reopened:

```dart
// 1. App starts and loads saved state
// 2. NavigationRestorationService checks for saved navigation stack
// 3. If found, restores the complete navigation flow:
//    - Navigate to first route in stack
//    - Push remaining routes
//    - Update tab index based on route mapping
//    - Restore scroll positions
//    - Load app state
```

## 🚀 Key Components

### StateRestorationService

The core service that manages all state persistence:

```dart
class StateRestorationService {
  // Current app state
  List<String> _navigationStack = ['/splash'];
  String _currentRoute = '/splash';
  int _currentTabIndex = 0;
  Map<String, double> _scrollPositions = {};
  Map<String, dynamic> _appState = {};

  // Key methods
  void updateRoute(String route)           // Save current route
  void pushRoute(String route)            // Add route to stack
  void updateTabIndex(int tabIndex)       // Save tab selection
  void updateScrollPosition(String key, double position) // Save scroll
  void updateAppState(String key, dynamic value) // Save custom data
}
```

### NavigationRestorationService

Handles the complex navigation stack restoration:

```dart
class NavigationRestorationService {
  // Route to tab mapping
  Future<void> restoreNavigationStack(GoRouter router) async {
    // 1. Load saved navigation stack
    // 2. Set restoration mode to prevent conflicts
    // 3. Navigate through each route in the stack
    // 4. Update tab index based on final route
    // 5. Save final state
    // 6. Clear restoration mode
  }
}
```

### Restoration Mixins

Easy-to-use mixins for screens:

```dart
// For general screens
mixin AppRestorationMixin<T extends StatefulWidget> on State<T> {
  double get currentScrollPosition;           // Get saved scroll position
  void saveScrollPosition(double position);   // Save scroll position
  void saveAppState(String key, dynamic value); // Save custom data
  dynamic getAppState(String key);            // Get saved data
}

// For tab screens
mixin AppTabRestorationMixin<T extends StatefulWidget> on State<T> {
  int get currentTabIndex;                    // Get saved tab index
  void saveTabIndex(int index);               // Save tab index
  void restoreTabIndex(TabController controller); // Restore to controller
}
```

## 📱 Usage Examples

### Basic Screen Integration

```dart
class MyScreen extends StatefulWidget {
  @override
  State<MyScreen> createState() => _MyScreenState();
}

class _MyScreenState extends State<MyScreen> with AppRestorationMixin {
  // Define restoration key
  @override
  String get restorationKey => 'my_screen';

  @override
  void initState() {
    super.initState();

    // Restore scroll position
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final savedPosition = currentScrollPosition;
      if (savedPosition > 0) {
        _scrollController.jumpTo(savedPosition);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: _scrollController,
      key: scrollPageStorageKey, // Automatic scroll restoration
      onScroll: (position) {
        saveScrollPosition(position); // Save scroll position
      },
      // ... rest of implementation
    );
  }
}
```

### Tab Screen Integration

```dart
class TabScreen extends StatefulWidget {
  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen>
    with TickerProviderStateMixin, AppTabRestorationMixin {

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _setupTabController();
  }

  void _setupTabController() {
    _tabController = TabController(
      length: 2,
      vsync: this,
      initialIndex: currentTabIndex, // Use restored tab index
    );

    // Restore tab index and listen for changes
    restoreTabIndex(_tabController);
    listenToTabChanges(_tabController);
  }

  void _onTabChanged() {
    if (!StateRestorationService.instance.isRestoring) {
      saveTabIndex(_tabController.index); // Save tab index
    }
  }
}
```

## 🗺️ Route-to-Tab Mapping

The system automatically maps routes to the correct tab:

```dart
// Route Mapping Logic
if (route == '/settings' || route == '/config-viewer') {
  targetTabIndex = 1; // Settings tab
} else if (route == '/tab-screen') {
  targetTabIndex = savedTabIndex; // Use saved tab index
} else {
  targetTabIndex = 0; // Home tab (default)
}
```

**Mapping Rules:**

- **Settings tab (index 1)**: `/settings`, `/config-viewer`
- **Home tab (index 0)**: All other routes (`/`, `/tab-screen`, `/accessibility`, etc.)

## 🔄 Restoration Process Flow

### 1. **App Startup**

```
App starts → Load saved state → Check for navigation history → Begin restoration
```

### 2. **Navigation Stack Restoration**

```
Load navigation stack → Set restoration mode → Navigate to first route →
Push remaining routes → Update tab index → Save final state → Clear restoration mode
```

### 3. **Tab Index Restoration**

```
Check route mapping → Determine target tab → Update tab controller →
Update UI state → Save tab index
```

### 4. **Scroll Position Restoration**

```
Load saved scroll positions → Apply to scroll controllers →
Listen for new scroll changes → Save updated positions
```

## 🛡️ Error Handling

The system includes robust error handling:

```dart
// Fallback mechanisms
try {
  await restoreNavigationStack(router);
} catch (e) {
  // Fallback to current route only
  await _navigateToRoute(router, restorationService.currentRoute);
} finally {
  // Always clear restoration mode
  restorationService.setRestoringMode(false);
}
```

## 📊 State Persistence

All state is persisted using the `AppConfigService`:

```dart
// State structure
{
  "state_restoration": {
    "navigation_stack": ["/splash", "/tab-screen", "/accessibility"],
    "current_route": "/accessibility",
    "current_tab_index": 0,
    "scroll_positions": {
      "accessibility_screen_scroll": 150.0,
      "settings_screen_scroll": 300.0
    },
    "app_state": {
      "user_preferences": {...},
      "feature_flags": {...}
    }
  }
}
```

## 🎯 Key Features

### ✅ **Complete Navigation Restoration**

- Preserves the entire navigation stack
- Rebuilds navigation hierarchy on app restart
- Handles complex navigation scenarios

### ✅ **Tab Index Preservation**

- Remembers which tab was selected
- Correctly restores tab selection on app restart
- Handles manual tab switching

### ✅ **Scroll Position Restoration**

- Saves scroll positions for each screen
- Automatically restores scroll positions
- Works with PageStorageKey for automatic restoration

### ✅ **App State Persistence**

- Saves custom data for each screen
- Restores app state on restart
- Flexible key-value storage

### ✅ **Robust Error Handling**

- Graceful fallbacks on restoration failure
- Prevents conflicts during restoration
- Comprehensive error logging

### ✅ **Performance Optimized**

- Minimal overhead during normal operation
- Efficient state saving and loading
- Smart restoration mode management
- Automatic navigation stack cleaning

## 🔧 Configuration

### Initialization

```dart
// In main.dart or app initialization
await StateRestorationService.instance.initialize();
```

### Navigation Integration

```dart
// In router configuration
final router = GoRouter(
  routes: $appRoutes,
  observers: [
    RouteObserver(), // For analytics
    // State restoration is handled automatically
  ],
);
```

## 🧪 Testing

### Manual Testing

1. **Navigate through the app** to different screens
2. **Switch between tabs** (Home and Settings)
3. **Scroll on different screens** to save scroll positions
4. **Force close the app** (not just background it)
5. **Reopen the app** and verify:
   - Navigation stack is restored
   - Correct tab is selected
   - Scroll positions are restored
   - App state is preserved

### Debug Logging

The system includes comprehensive debug logging:

```dart
// Enable debug logging to see restoration process
debugPrint('StateRestorationService: State saved to config');
debugPrint('NavigationRestorationService: Navigation stack restored');
debugPrint('TabScreen: Tab index restored to: 1');
```

## 🚀 Best Practices

### 1. **Use Restoration Mixins**

Always use the provided mixins for easy integration:

```dart
// ✅ Good
class MyScreen extends StatefulWidget {
  @override
  State<MyScreen> createState() => _MyScreenState();
}

class _MyScreenState extends State<MyScreen> with AppRestorationMixin {
  @override
  String get restorationKey => 'my_screen';
}

// ❌ Avoid manual state management
```

### 2. **Define Unique Restoration Keys**

Use unique, descriptive restoration keys:

```dart
// ✅ Good
String get restorationKey => 'accessibility_screen';
String get restorationKey => 'settings_screen';

// ❌ Avoid
String get restorationKey => 'screen';
String get restorationKey => 'page';
```

### 3. **Handle Restoration Mode**

Always check restoration mode to avoid conflicts:

```dart
// ✅ Good
if (!StateRestorationService.instance.isRestoring) {
  saveTabIndex(_tabController.index);
}

// ❌ Avoid
saveTabIndex(_tabController.index); // May cause conflicts
```

### 4. **Use PageStorageKey for Scroll**

Leverage Flutter's built-in scroll restoration:

```dart
// ✅ Good
ListView.builder(
  key: scrollPageStorageKey, // Automatic scroll restoration
  // ...
)

// ❌ Avoid manual scroll management
```

## 🔍 Troubleshooting

### Common Issues

1. **Tab index not restoring correctly**

   - Check if tab index is being saved during manual switching
   - Verify route-to-tab mapping logic
   - Ensure restoration mode is not interfering

2. **Navigation stack not restoring**

   - Check if routes are being pushed to the stack
   - Verify navigation stack validation
   - Ensure restoration mode is properly managed

3. **Scroll positions not restoring**
   - Use PageStorageKey for automatic restoration
   - Check if scroll positions are being saved
   - Verify scroll controller initialization

### Debug Commands

```dart
// Check current state
print(StateRestorationService.instance.navigationStack);
print(StateRestorationService.instance.currentTabIndex);
print(StateRestorationService.instance.scrollPositions);

// Clear state for testing
await StateRestorationService.instance.clearState();
```

## 📚 Related Documentation

- [Flutter State Restoration](https://docs.flutter.dev/development/ui/advanced/state-restoration)
- [PageStorageKey Documentation](https://api.flutter.dev/flutter/widgets/PageStorageKey-class.html)
- [AutomaticKeepAliveClientMixin](https://api.flutter.dev/flutter/widgets/AutomaticKeepAliveClientMixin-mixin.html)

## 🤝 Contributing

When contributing to the state restoration system:

1. **Test thoroughly** with different navigation scenarios
2. **Add debug logging** for new features
3. **Update this documentation** for any changes
4. **Follow the existing patterns** for consistency
5. **Handle edge cases** and error scenarios

---

This state restoration system provides a robust, user-friendly experience that ensures users can seamlessly continue where they left off when reopening the app.
