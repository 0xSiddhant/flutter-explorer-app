# Deep Linking System

A simplified and efficient deep linking system that allows external applications and URLs to navigate directly to specific screens within the Flutter app using the `frouter://` scheme.

## 🎯 Overview

The deep linking system provides:
- **Custom URL Scheme**: `frouter://` for deep link navigation
- **Parameter Support**: Query parameters for dynamic navigation
- **Cross-Platform**: Works on both Android and iOS
- **Validation**: Built-in validation for allowed deep links
- **Fallback Handling**: Graceful fallback to home screen for invalid links
- **Simplified Architecture**: Direct GoRouter integration with minimal overhead
- **Clean Navigation Flow**: Tab screen as base with proper stack management

## 🏗️ Simplified Architecture

```
RouteConstants (Unified Constants)
├── DeepLinkManager (Simplified Core Logic)
├── DeepLinkService (Streamlined Platform Integration)
├── AppRouteManager (Router Integration)
└── Platform-Specific Services
    ├── Android: DeepLinkService.kt
    └── iOS: DeepLinkService.swift
```

### Key Improvements:
- **50% Less Code**: Reduced from ~300 lines to ~150 lines
- **Direct GoRouter Integration**: No complex navigation abstractions
- **Simplified Parameter Handling**: Direct query string support
- **Better Performance**: No unnecessary stream controllers or complex state management
- **Easier Maintenance**: Single responsibility, clear flow

## 📁 File Structure

```
router/
├── DEEP_LINKING.md                     # This file
├── deep_link_manager.dart              # Simplified core deep link logic
├── services/
│   └── deep_link_service.dart          # Streamlined platform integration
├── app_router.dart                     # Router with deep link support
└── constants/
    └── route_constants.dart            # Route definitions and deep link constants

Platform Services:
├── android/app/src/main/kotlin/com/siddhant/the_router/
│   ├── MainActivity.kt                 # Main activity with deep link integration
│   └── DeepLinkService.kt              # Android deep link method channel service
└── ios/Runner/
    ├── AppDelegate.swift               # App delegate with deep link integration
    └── DeepLinkService.swift           # iOS deep link method channel service
```

## 🔧 How It Works

### 1. **Unified Constants Approach**
The deep linking system uses a unified constants approach where all route-related constants are centralized in `RouteConstants`. This ensures:
- **Single Source of Truth**: All route paths and deep link mappings are defined in one place
- **Consistency**: No duplication between normal navigation and deep link navigation
- **Maintainability**: Changes to routes only need to be made in one location
- **Error Prevention**: Eliminates the risk of mismatched route paths

### 2. **Deep Link Format**
```
frouter://[path]?[parameters]
```

**Examples:**
- `frouter://home` - Navigate to home tab
- `frouter://setting` - Navigate to settings tab
- `frouter://i10n?locale=jp` - Navigate to internationalization with Japanese locale
- `frouter://theme_preview?theme=2` - Navigate to theme preview with 2nd theme

### 2. **Simplified Navigation Flow**
```
Deep Link Received → Parse URL → Validate → Navigate Directly with GoRouter
├── If Tab Screen: router.go(targetRoute)
└── If Other Route: router.go(tabScreen) → router.push(targetRoute)
```

### 3. **Simplified Parameter Handling**
- **Direct Query Parameters**: Parameters are passed directly as query strings to GoRouter
- **Screen Access**: Screens access parameters via `GoRouterState.of(context).uri.queryParameters`
- **No Pre-processing**: Parameters are handled by individual screens as needed
- **Extensible**: Easy to add new parameter types for any screen

## 🚀 Supported Deep Links

### **Tab Navigation**
- `frouter://home` - Open home tab
- `frouter://setting` - Open settings tab
- `frouter://settings` - Open settings tab (alternative)

### **Feature Screens**
- `frouter://config` - Config viewer
- `frouter://i10n` - Internationalization
- `frouter://internationalization` - Internationalization (alternative)
- `frouter://theme_preview` - Theme component showcase
- `frouter://theme` - Theming screen
- `frouter://theming` - Theming screen (alternative)
- `frouter://accessibility` - Accessibility screen
- `frouter://file_management` - File management
- `frouter://file` - File management (alternative)
- `frouter://background_tasks` - Background tasks
- `frouter://background` - Background tasks (alternative)
- `frouter://native_communication` - Native communication
- `frouter://native` - Native communication (alternative)
- `frouter://navigation_analytics` - Navigation analytics
- `frouter://analytics` - Navigation analytics (alternative)
- `frouter://lifecycle_management` - Lifecycle management
- `frouter://lifecycle` - Lifecycle management (alternative)
- `frouter://advanced_processing` - Advanced processing
- `frouter://advanced` - Advanced processing (alternative)
- `frouter://typography_showcase` - Typography showcase
- `frouter://typography` - Typography showcase (alternative)

## 📱 Platform Configuration

### Android Configuration

#### AndroidManifest.xml
```xml
<activity
    android:name=".MainActivity"
    android:exported="true"
    android:launchMode="singleTop"
    android:theme="@style/LaunchTheme">
    
    <!-- Main intent filter -->
    <intent-filter>
        <action android:name="android.intent.action.MAIN"/>
        <category android:name="android.intent.category.LAUNCHER"/>
    </intent-filter>
    
    <!-- Deep link intent filter -->
    <intent-filter android:autoVerify="true">
        <action android:name="android.intent.action.VIEW" />
        <category android:name="android.intent.category.DEFAULT" />
        <category android:name="android.intent.category.BROWSABLE" />
        <data android:scheme="frouter" />
    </intent-filter>
</activity>
```

#### MainActivity.kt
```kotlin
class MainActivity: FlutterActivity() {
  private val deepLinkService = DeepLinkService()

  override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
    super.configureFlutterEngine(flutterEngine)
    
    // Deep link channel
    val deepLinkChannel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "deep_link_channel")
    deepLinkService.initialize(deepLinkChannel)
  }

  override fun onNewIntent(intent: Intent) {
    super.onNewIntent(intent)
    deepLinkService.handleDeepLink(intent)
  }

  override fun onResume() {
    super.onResume()
    deepLinkService.handleDeepLink(intent)
  }
}
```

#### DeepLinkService.kt
```kotlin
class DeepLinkService : MethodCallHandler {
  private var methodChannel: MethodChannel? = null
  private var initialDeepLink: String? = null

  fun initialize(methodChannel: MethodChannel) {
    this.methodChannel = methodChannel
    methodChannel.setMethodCallHandler(this)
  }

  override fun onMethodCall(call: MethodCall, result: Result) {
    when (call.method) {
      "getInitialLink" -> {
        result.success(initialDeepLink)
      }
      else -> {
        result.notImplemented()
      }
    }
  }

  fun handleDeepLink(intent: Intent) {
    val data = intent.data
    if (data != null && data.scheme == "frouter") {
      val deepLinkUrl = data.toString()
      if (initialDeepLink == null) {
        initialDeepLink = deepLinkUrl
      }
      methodChannel?.invokeMethod("handleDeepLink", deepLinkUrl)
    }
  }
}
```

### iOS Configuration

#### Info.plist
```xml
<key>CFBundleURLTypes</key>
<array>
    <dict>
        <key>CFBundleURLName</key>
        <string>frouter</string>
        <key>CFBundleURLSchemes</key>
        <array>
            <string>frouter</string>
        </array>
    </dict>
</array>
```

#### AppDelegate.swift
```swift
@main
@objc class AppDelegate: FlutterAppDelegate {
  private let deepLinkService = DeepLinkService()

  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    let controller: FlutterViewController = window?.rootViewController as! FlutterViewController

    // Register deep link service
    DeepLinkService.register(with: self.registrar(forPlugin: "DeepLinkService")!)

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  // Handle deep links when app is opened via URL
  override func application(
    _ app: UIApplication,
    open url: URL,
    options: [UIApplication.OpenURLOptionsKey: Any] = [:]
  ) -> Bool {
    deepLinkService.handleDeepLink(url: url)
    return true
  }

  // Handle deep links when app is already running
  override func application(
    _ application: UIApplication,
    continue userActivity: NSUserActivity,
    restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void
  ) -> Bool {
    if userActivity.activityType == NSUserActivityTypeBrowsingWeb,
       let url = userActivity.webpageURL {
      deepLinkService.handleDeepLink(url: url)
    }
    return true
  }
}
```

#### DeepLinkService.swift
```swift
class DeepLinkService: NSObject, FlutterPlugin {
  private var methodChannel: FlutterMethodChannel?
  private var initialDeepLink: String?
  
  static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(
      name: "deep_link_channel",
      binaryMessenger: registrar.messenger())
    let instance = DeepLinkService()
    registrar.addMethodCallDelegate(instance, channel: channel)
    instance.methodChannel = channel
  }
  
  func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "getInitialLink":
      result(initialDeepLink)
    default:
      result(FlutterMethodNotImplemented)
    }
  }
  
  func handleDeepLink(url: URL) {
    if url.scheme == "frouter" {
      let deepLinkUrl = url.absoluteString
      if initialDeepLink == nil {
        initialDeepLink = deepLinkUrl
      }
      methodChannel?.invokeMethod("handleDeepLink", arguments: deepLinkUrl)
    }
  }
}
```

## 🔧 Simplified Implementation

### Core Components

#### 1. **DeepLinkManager** (Simplified)
```dart
class DeepLinkManager {
  // Single method for handling deep links
  Future<void> handleDeepLink(String url, GoRouter router) async {
    // Parse URL, validate, and navigate directly with GoRouter
    if (routeModel.path == RouteConstants.tabScreen.path) {
      router.go(targetRoute);
    } else {
      router.go(RouteConstants.tabScreen.path);
      await Future.delayed(const Duration(milliseconds: 100));
      router.push(targetRoute);
    }
  }
}
```

#### 2. **DeepLinkService** (Streamlined)
```dart
class DeepLinkService {
  // Simple initialization and method channel handling
  Future<void> initialize(GoRouter router) async {
    _channel.setMethodCallHandler((call) async {
      if (call.method == 'handleDeepLink') {
        await DeepLinkManager.instance.handleDeepLink(url, router);
      }
    });
  }
}
```

#### 3. **Parameter Access in Screens**
```dart
// In any screen, access parameters directly
@override
void initState() {
  super.initState();
  
  final state = GoRouterState.of(context);
  final parameters = state.uri.queryParameters;
  
  final themeIndex = int.tryParse(parameters['theme'] ?? '');
  final locale = parameters['locale'];
}
```

## 🔧 Usage Examples

### Basic Deep Link Navigation

```dart
// Navigate to home tab
await AppRouteManager.handleDeepLink('frouter://home');

// Navigate to settings tab
await AppRouteManager.handleDeepLink('frouter://setting');

// Navigate to config viewer
await AppRouteManager.handleDeepLink('frouter://config');
```

### Deep Links with Parameters

```dart
// Navigate to internationalization with Japanese locale
await AppRouteManager.handleDeepLink('frouter://i10n?locale=jp');

// Navigate to theme preview with 2nd theme
await AppRouteManager.handleDeepLink('frouter://theme_preview?theme=2');

// Navigate to theming with specific theme
await AppRouteManager.handleDeepLink('frouter://theme?theme=3');

// Navigate with multiple parameters
await AppRouteManager.handleDeepLink('frouter://config?tab=1&section=advanced&enabled=true');
```

### Testing Deep Links

```dart
// Test if a deep link is allowed
bool isAllowed = AppRouteManager.isDeepLinkAllowed('home');

// Get all allowed deep links
Set<String> allowedLinks = AppRouteManager.getAllowedDeepLinks();

// Get deep link scheme
String scheme = AppRouteManager.getDeepLinkScheme(); // Returns 'frouter'
```

## 🧪 Testing

### Manual Testing

1. **Install the app** on a device or emulator
2. **Open terminal/command prompt** and use platform-specific commands:

#### Android Testing
```bash
# Test deep link navigation
adb shell am start -W -a android.intent.action.VIEW -d "frouter://home" com.siddhant.the_router

# Test deep link with parameters
adb shell am start -W -a android.intent.action.VIEW -d "frouter://i10n?locale=jp" com.siddhant.the_router
```

#### iOS Testing
```bash
# Test deep link navigation
xcrun simctl openurl booted "frouter://home"

# Test deep link with parameters
xcrun simctl openurl booted "frouter://i10n?locale=jp"
```

### In-App Testing

Use the **Deep Link Test** screen in the app:
1. Navigate to Home tab
2. Tap on "Deep Link Test" card
3. Use the test interface to try different deep links
4. View example deep links and their descriptions

### Browser Testing

1. **Open a web browser** on your device
2. **Enter a deep link URL** in the address bar:
   - `frouter://home`
   - `frouter://setting`
   - `frouter://i10n?locale=jp`
3. **Tap the link** to open the app

## 🔍 Debugging

### Enable Debug Logging

The system includes comprehensive debug logging:

```dart
// Deep link parsing logs
debugPrint('DeepLinkManager: Parsing deep link: frouter://home');

// Navigation flow logs
debugPrint('DeepLinkManager: Clearing navigation and navigating to: /tab-screen');

// Error handling logs
debugPrint('DeepLinkManager: Invalid deep link, navigating to home');
```

### Common Issues

1. **Deep link not working**
   - Check if the scheme is correct (`frouter://`)
   - Verify the deep link is in the allowed list
   - Ensure platform configuration is correct

2. **Parameters not working**
   - Check parameter format (`?key=value`)
   - Verify parameter handling in target screen
   - Ensure parameter validation logic

3. **Navigation stack issues**
   - Check if navigation stack is being cleared properly
   - Verify splash screen navigation
   - Ensure tab screen navigation

## 🎉 Benefits of Simplified Architecture

### **Performance Improvements**
- **50% Less Code**: Reduced complexity and maintenance overhead
- **Direct GoRouter Integration**: No unnecessary abstractions or middleware
- **Faster Navigation**: Direct router calls without complex state management
- **Lower Memory Usage**: No stream controllers or complex state tracking

### **Developer Experience**
- **Easier to Understand**: Clear, linear flow from deep link to navigation
- **Simpler Debugging**: Fewer moving parts, easier to trace issues
- **Standard Patterns**: Uses Flutter/GoRouter best practices
- **Better Maintainability**: Single responsibility, clear separation of concerns

### **Reliability**
- **Fewer Failure Points**: Less complex logic means fewer potential errors
- **Consistent Behavior**: Direct GoRouter integration ensures predictable navigation
- **Better Error Handling**: Simplified error paths with clear fallbacks
- **Cross-Platform Consistency**: Same logic works identically on both platforms

## 🚀 Best Practices

### 1. **URL Scheme Naming**
- Use descriptive, unique scheme names
- Avoid conflicts with other apps
- Follow platform conventions

### 2. **Parameter Handling**
- Access parameters directly in screens using `GoRouterState.of(context).uri.queryParameters`
- Validate parameters before use
- Provide fallback values
- Handle missing parameters gracefully

### 3. **Navigation Flow**
- Use tab screen as base for all deep link navigation
- Follow consistent navigation patterns
- Provide fallback navigation to home

### 4. **Error Handling**
- Validate deep links before processing
- Provide meaningful error messages
- Implement graceful fallbacks to home screen

### 5. **Testing**
- Test on both platforms
- Test with various parameter combinations
- Test edge cases and error scenarios
- Use the built-in Deep Link Test screen

## 📚 Related Documentation

- [Flutter Deep Linking](https://docs.flutter.dev/development/ui/navigation/deep-linking)
- [Android App Links](https://developer.android.com/training/app-links)
- [iOS Universal Links](https://developer.apple.com/ios/universal-links/)
- [GoRouter Documentation](https://pub.dev/packages/go_router)

## 🤝 Contributing

When contributing to the deep linking system:

1. **Add new deep links** to the `RouteConstants.deepLinkRoutes` map
2. **Update allowed deep links** in `RouteConstants.allowedDeepLinks` set
3. **Add parameter handling** for new features
4. **Update platform configurations** if needed
5. **Add comprehensive tests** for new functionality
6. **Update documentation** for new features

---

This deep linking system provides a robust, user-friendly way to navigate directly to specific screens within the app, enhancing the user experience and enabling external integrations.
