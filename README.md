# Flutter Explorer

A comprehensive Flutter project designed to explore and understand core Flutter features through a modular package architecture. This project demonstrates various Flutter capabilities including navigation, theme switching, native communication, isolates, localization, semantic UI, lifecycle management, navigation analytics, custom page transitions, and advanced accessibility features.

## 🏗️ Project Structure

The project is organized into modular packages for better maintainability and separation of concerns:

```
the_router/
├── lib/
│   ├── main.dart                 # Clean app entry point
│   ├── flutter_explorer_app.dart # Main app widget with RTL support
│   └── utils/
│       ├── utils.dart            # Barrel file for utilities
│       └── initialization_error_handler.dart # Error handling
├── assets/
│   └── config/
│       └── default_config.json   # Asset-based configuration
├── packages/
│   ├── core/                     # Core features and utilities
│   │   ├── lib/
│   │   │   ├── core.dart         # Optimized exports
│   │   │   └── src/
│   │   │       ├── router/       # Navigation logic and analytics
│   │   │       │   ├── constants/ # Route constants and models
│   │   │       │   ├── services/  # Navigation services
│   │   │       │   ├── generators/ # Route generation
│   │   │       │   └── observers/ # Navigation analytics
│   │   │       ├── theme/        # Theme management
│   │   │       ├── isolate/      # Background processing
│   │   │       ├── method_channel/ # Native communication
│   │   │       ├── localization/ # Complete localization system
│   │   │       │   ├── app_localizations.dart # Central localization logic
│   │   │       │   ├── localization_service.dart # Business logic
│   │   │       │   ├── language_change_listener.dart # Global listener
│   │   │       │   └── models/   # Language models
│   │   │       └── page_transitions/ # Custom page animations
│   ├── screens/                  # UI screens and components
│   │   ├── lib/
│   │   │   ├── screens.dart      # Organized exports
│   │   │   ├── splash_screen/    # Animated splash screen
│   │   │   ├── tab_screen/       # Main tab navigation
│   │   │   ├── home_screen/      # Feature hub (Tab 1)
│   │   │   ├── settings_screen/  # App settings (Tab 2)
│   │   │   ├── theming/          # Theme management
│   │   │   ├── native_communication/ # Platform integration
│   │   │   ├── background_tasks/ # Isolate processing
│   │   │   ├── internationalization/ # Multi-language support
│   │   │   ├── accessibility/    # Semantic UI & accessibility
│   │   │   ├── file_management/  # Local storage
│   │   │   ├── advanced_processing/ # Complex operations
│   │   │   ├── navigation_analytics/ # Comprehensive route tracking & analytics
│   │   │   ├── lifecycle_management/ # Widget lifecycle
│   │   │   └── typography_showcase/ # Font rendering demo
│   └── common/                   # Shared utilities and models
│       ├── lib/
│       │   ├── common.dart       # Optimized exports
│       │   └── src/
│       │       ├── utils/        # Utility functions
│       │       └── widgets/      # Shared widgets
└── README.md
```

## 🚀 Core Features Demonstrated

### 1. **Route Management & Custom Page Transitions** 🆕

- **Technology**: `go_router` package with `CustomTransitionPage`
- **Features**:
  - **Optimized Navigation Flow**: Splash → TabScreen → Feature Screens
  - **Tab-based Navigation**: Home (Tab 1) and Settings (Tab 2)
  - **Proper Back Button Support**: All feature screens show back button
  - **RouteModel Architecture**: Type-safe route constants with path/name grouping
  - **Modular Router Structure**: Constants, services, generators, observers
  - **Dual RouteObserver System**: 
    - `AppRouteObserver`: Basic navigation tracking
    - `ComprehensiveNavigationObserver`: Advanced analytics and performance
  - **RouteAware**: Screen lifecycle monitoring
  - **Navigation Analytics**: Comprehensive dashboard with 5 specialized tabs
  - **Custom Page Transitions**: 10 unique animations for each screen
    - Slide Up Animation (Details Screen)
    - Slide Right Animation (Theming Screen)
    - Scale Animation with Elastic Effect (Native Communication)
    - Rotation Animation (Background Tasks)
    - Fade Scale Animation (Internationalization)
    - Diagonal Slide Animation (Accessibility)
    - Bounce Animation (File Management)
    - Flip Animation (Advanced Processing)
    - Slide Up with Fade (Navigation Analytics)
    - Slide from Right (Lifecycle Management)

### 2. **Enhanced Native Communication** 🆕

- **Technology**: Flutter Platform Channels with modular architecture
- **Features**:
  - **MethodChannelManager**: Centralized channel management
  - **DeviceService**: Device information retrieval
  - **BatteryService**: Battery level monitoring
  - **DialogService**: Native dialog display
  - **VibrationService**: Device vibration
  - **CameraService**: Camera permission and access
  - **LocationService**: Location permission and access
  - **NotificationService**: Push notification management
  - **StorageService**: File storage operations
  - **APIService**: HTTP requests using URLSession (iOS) and OkHttp (Android)
  - **Permission Handling**: Automatic permission requests
  - Robust error handling and type safety
  - **Cross-platform API**: Unified interface for iOS and Android

### 3. **Animated Splash Screen** 🆕

- **Technology**: Custom animations with `AnimationController`
- **Features**:
  - **Beautiful Animations**: Multiple animated elements
  - **Gradient Background**: Dynamic color transitions
  - **Logo Animation**: Scale and fade effects
  - **Progress Indicator**: Animated loading progress
  - **Smooth Transitions**: Seamless app launch experience
  - **Native Launch Screens**: Matching colors for iOS and Android
  - **Dynamic Version Info**: App version fetched via method channels

### 4. **Advanced Internationalization with RTL Support** 🆕

- **Technology**: Custom localization system with complete RTL support
- **Features**:
  - **Multi-language Support**: English, Spanish, French, German, Arabic, Japanese
  - **Complete RTL/LTR Support**: 
    - **Arabic**: Full Right-to-Left text direction with automatic UI flipping
    - **All other languages**: Left-to-Right text direction
    - **Real-time Direction Changes**: App automatically rebuilds when language changes
    - **Global Directionality Control**: Entire app responds to language direction
  - **Dynamic Language Switching**: Real-time language changes with immediate UI updates
  - **Locale-specific Formatting**: Date, time, number, and currency
  - **Complete String Localization**: All UI strings internationalized
  - **Cultural Adaptations**: Proper formatting for each locale
  - **Language-specific Fonts**: Noto Sans fonts for optimal rendering
    - Noto Sans (Latin scripts: English, Spanish, French, German)
    - Noto Sans Arabic (Arabic script)
    - Noto Sans Japanese (Japanese script: Hiragana, Katakana, Kanji)
  - **FontUtils Class**: Centralized font management with language-specific styling
  - **JSON-based Localization**: Separate JSON files for each language
  - **Typography Showcase**: Professional font rendering demonstration
  - **LanguageModel Architecture**: Structured language data with font associations
  - **Clean Architecture**: 
    - **Core Package**: Contains all localization business logic and services
    - **Common Package**: Contains only language models and shared utilities
    - **Screens Package**: UI components that import from core package
  - **Optimized Dependencies**: No circular dependencies, clean import structure

### 5. **Enhanced Accessibility Features** 🆕

- **Technology**: Flutter Semantics with comprehensive support
- **Features**:
  - **Screen Reader Support**: Complete semantic tree
  - **High Contrast Mode**: Enhanced visibility
  - **Large Text Support**: Scalable typography
  - **Semantic Labels**: Proper accessibility labels
  - **Interactive Controls**: Toggle switches for accessibility features
  - **Live Demo**: Real-time accessibility feature demonstration
  - **Modular Architecture**: Organized into models, data, and widgets
  - **Performance Optimized**: Smooth animations with accessibility

### 6. **Theming System**

- **Technology**: Material 3 theming with custom provider
- **Features**:
  - Light/Dark theme switching
  - High contrast mode
  - Dynamic color schemes
  - Custom theme configurations
  - Real-time theme preview
  - Theme persistence

### 7. **Background Processing**

- **Technology**: Dart Isolates with comprehensive examples
- **Features**:
  - **IsolateManager**: Centralized isolate management
  - **Fibonacci Calculator**: Performance comparison
  - **Prime Calculator**: Large number processing
  - **Matrix Calculator**: Complex mathematical operations
  - **Image Downloader**: Network operations in isolates
  - **Data Processor**: File and data analysis
  - Progress tracking and performance benchmarking

### 8. **File Management**

- **Technology**: `path_provider` and `dart:io`
- **Features**:
  - Local file operations
  - Save, load, and delete files
  - File listing and management
  - Error handling and user feedback
  - Sample file creation and processing

### 9. **Lifecycle Management**

- **Technology**: Widget lifecycle tracking with RouteAware
- **Features**:
  - **Widget Lifecycle**: Complete widget state tracking
  - **App Lifecycle**: Foreground/background state monitoring
  - **Navigation Lifecycle**: Screen visibility tracking
  - **Real-time Event Logging**: Timestamped lifecycle events
  - **Performance Metrics**: Screen-specific performance data
  - **Memory Management**: Resource allocation tracking

### 10. **Comprehensive Navigation Analytics** 🆕

- **Technology**: Dual RouteObserver system with modular architecture
- **Features**:
  - **Basic Analytics** (`AppRouteObserver`):
    - Navigation history tracking
    - Screen visit counts
    - Pattern analysis
    - Time spent per screen
    - Most visited screens
  - **Advanced Analytics** (`ComprehensiveNavigationObserver`):
    - Performance tracking (load times, fastest/slowest loads)
    - User behavior analysis (engagement scores, navigation efficiency)
    - Session management (duration, patterns, last visited)
    - Error tracking and monitoring
    - Back navigation frequency
    - Real-time session analytics
  - **Modular Dashboard**:
    - 5 specialized tabs (Overview, Performance, User Behavior, Session Data, Errors)
    - Beautiful metric cards with icons and colors
    - Real-time data updates
    - Comprehensive analytics visualization
    - Error-free status indicators
  - **Architecture**:
    - Modular widget structure (models, data, widgets)
    - Separate observer instances for different analytics
    - Centralized data management
    - Clean separation of concerns

### 11. **Main.dart Refactoring & Asset-Based Configuration** 🆕

- **Technology**: Modular architecture with asset-based configuration system
- **Features**:
  - **Clean Main Entry Point**: Simplified `main.dart` with focused initialization
  - **Separated App Widget**: `FlutterExplorerApp` in dedicated file
  - **Error Handling Utilities**: `InitializationErrorHandler` for robust startup
  - **Asset-Based Configuration**: JSON configuration loaded from assets
  - **Package Asset Access**: Sub-packages can access main project assets
  - **Fallback Mechanisms**: Graceful degradation if asset loading fails
  - **Configuration Viewer**: UI to display and manage app configuration
  - **Robust Initialization**: Multi-layer error handling for critical services
  - **Professional Structure**: Organized file structure with barrel exports

## 🛠️ Getting Started

### Prerequisites

- Flutter SDK (3.0 or higher)
- Dart SDK
- Android Studio / VS Code
- Android/iOS device or emulator

### Installation

1. **Clone the repository**

   ```bash
   git clone <repository-url>
   cd the_router
   ```

2. **Install dependencies**

   ```bash
   flutter pub get
   ```

3. **Setup Fonts (Optional but Recommended)**

   ```bash
   # Download Noto Sans fonts for internationalization support
   ./download_fonts.sh
   
   # Or manually download from Google Fonts:
   # https://fonts.google.com/noto
   ```

4. **Run the app**
   ```bash
   flutter run
   ```

## 📱 App Navigation

### Navigation Flow

1. **Splash Screen** → **TabScreen** (initial screen after splash)
2. **TabScreen** contains:
   - **HomeScreen** (Tab 1) - Feature hub with professional navigation cards
   - **SettingsScreen** (Tab 2) - App configuration and accessibility settings
3. **Feature Screens** - All accessible from HomeScreen with proper back button support

### Main Screens

1. **Splash Screen** - Animated welcome screen with beautiful transitions
2. **TabScreen** - Main navigation container with bottom tab bar
3. **HomeScreen** - Feature hub with professional navigation cards (Tab 1)
4. **SettingsScreen** - App configuration and accessibility settings (Tab 2)

### Feature Screens

1. **Route Management** - Navigation and routing examples
2. **Theming** - Interactive theme switching and preview
3. **Native Communication** - Platform integration examples
4. **Background Tasks** - Isolate processing and performance comparison
5. **Internationalization** - Multi-language support and formatting
6. **Accessibility** - Semantic UI and accessibility features
7. **File Management** - Local file operations and management
8. **Advanced Processing** - Complex isolate operations
9. **Navigation Analytics** - Route tracking and analytics dashboard
10. **Lifecycle Management** - Widget and app lifecycle monitoring

## 🎯 Key Learning Points

### Package Architecture

- **Separation of Concerns**: Each package has a specific responsibility
- **Dependency Management**: Clear dependency flow between packages
- **Modularity**: Easy to add, remove, or modify features
- **Professional Structure**: Models, data, and widgets organization
- **Optimized Exports**: Only necessary exports for reduced package size
- **Clean Public APIs**: Focused exports for better maintainability
- **Clean Dependencies**: No circular dependencies, optimized import structure

### Flutter Best Practices

- **State Management**: Using setState for simple state
- **Widget Composition**: Breaking down complex UIs into smaller widgets
- **Error Handling**: Graceful error handling with user feedback
- **Performance**: Using isolates for heavy computations
- **Navigation Analytics**: Dual observer system with comprehensive dashboard
- **Modular Architecture**: Clean separation with models, data, and widgets
- **Lifecycle Management**: Complete widget and app state monitoring
- **Custom Animations**: Professional page transitions
- **Accessibility**: Comprehensive semantic support
- **Navigation Flow**: Proper back button support with optimized routing
- **Package Optimization**: Reduced exports for better performance
- **Asset Management**: Proper asset access across packages
- **Configuration Management**: Asset-based configuration with fallback mechanisms
- **Error Handling**: Robust initialization with graceful degradation
- **Code Organization**: Separated concerns with dedicated utility files
- **Internationalization**: Complete RTL support with clean architecture
- **Import Management**: Optimized imports with no unused dependencies

### Advanced Features

- **Dual RouteObserver System**: Basic and comprehensive navigation analytics
- **RouteAware**: Screen lifecycle monitoring
- **Method Channels**: Modular native communication
- **Isolates**: Advanced background processing
- **Analytics**: Real-time navigation insights
- **Lifecycle Tracking**: Complete app state monitoring
- **Page Transitions**: Custom animations for each screen
- **Internationalization**: Multi-language with complete RTL support
- **RouteModel Architecture**: Type-safe route constants with path/name grouping
- **Typography Showcase**: Professional font rendering demonstration
- **Optimized Navigation**: Proper back button support with tab-based navigation
- **Asset-Based Configuration**: JSON configuration loaded from assets with fallback
- **Package Asset Access**: Cross-package asset sharing with proper declarations
- **Robust Initialization**: Multi-layer error handling for critical services
- **Modular Main Entry**: Clean separation of app initialization and widget logic
- **RTL Support**: Complete Right-to-Left text direction with automatic UI adaptation

### Accessibility

- **Semantic Labels**: Proper labeling for screen readers
- **Keyboard Navigation**: Support for keyboard-only navigation
- **Visual Accessibility**: High contrast and large text support
- **Screen Reader**: Comprehensive accessibility support
- **Interactive Controls**: Toggle switches for accessibility features

## 🔧 Development Guidelines

### Code Organization

- Follow the established package structure
- Place new features in appropriate packages
- Use consistent naming conventions
- Add proper documentation
- Implement modular architecture (models, data, widgets)
- Use FontUtils for language-specific font styling
- Follow internationalization best practices
- Maintain clean import structure with no unused dependencies

### Adding New Features

1. Create feature in appropriate package
2. Add navigation route in `app_router.dart`
3. Update home screen with navigation card
4. Add proper error handling
5. Test on multiple devices
6. Include analytics tracking if applicable
7. Add custom page transition animation
8. Implement accessibility features
9. Update route constants with RouteModel
10. Ensure proper back button support
11. Add configuration settings if needed
12. Update asset declarations if using new assets
13. Test asset access across packages
14. Ensure RTL compatibility for internationalization features
15. Test import dependencies and remove unused imports

### Modular Architecture Guidelines

- **Models**: Data structures and business logic
- **Data**: Data providers and API calls
- **Widgets**: UI components organized by functionality
- **Separation of Concerns**: Each widget has a single responsibility
- **Reusability**: Create reusable components
- **Maintainability**: Keep files under 200 lines when possible
- **Clean Dependencies**: Avoid circular dependencies and unused imports

### Testing

- Test on both Android and iOS
- Verify accessibility features
- Test with screen readers
- Performance testing for isolates
- Navigation analytics validation
- Lifecycle tracking verification
- Custom animations testing
- Internationalization testing
- Font rendering across languages
- RTL/LTR text direction testing
- Navigation flow testing (back button functionality)
- Tab navigation testing
- Package export optimization validation
- Asset access testing across packages
- Configuration system testing (asset loading, fallback, persistence)
- Initialization error handling testing
- Configuration viewer functionality testing
- Import dependency testing (no unused imports)
- RTL UI adaptation testing for Arabic language

## 📚 Dependencies

### Core Dependencies

- `flutter`: Core Flutter framework
- `go_router`: Navigation and routing
- `material`: Material Design components
- `path_provider`: File system access
- `http`: HTTP requests for API calls
- `shared_preferences`: Local storage
- `google_fonts`: Dynamic font loading (optional)

### Development Dependencies

- `flutter_test`: Testing framework
- `flutter_lints`: Code linting

## 🚀 Advanced Features

### Navigation Architecture

The project implements a sophisticated navigation system with proper back button support:

#### Navigation Flow
```
Splash Screen → TabScreen → Feature Screens
```

#### RouteModel Architecture
```dart
// Type-safe route constants with path/name grouping
class RouteModel {
  final String path;
  final String name;
  const RouteModel({required this.path, required this.name});
}

// Usage in route constants
static const RouteModel home = RouteModel(path: '/', name: 'home');
static const RouteModel theming = RouteModel(path: '/theming', name: 'theming');
```

#### Tab-based Navigation
- **TabScreen**: Main navigation container
- **HomeScreen**: Feature hub (Tab 1)
- **SettingsScreen**: App settings (Tab 2)
- **Custom Tab Bar**: Professional bottom navigation

### Configuration Management

The project includes a comprehensive asset-based configuration system as an alternative to SharedPreferences:

#### Configuration File Locations
- **Default Config**: `assets/config/default_config.json` (version controlled)
- **User Config**: App Documents Directory (`app_config.json`) (runtime)
- **Access**: Through `AppConfigService.instance`

#### Asset Access Architecture
- **Main Project**: Declares assets in `pubspec.yaml`
- **Sub-Packages**: Access assets via relative paths in their `pubspec.yaml`
- **Package Isolation**: Each package must declare its asset dependencies
- **Relative Paths**: `../../assets/config/` for cross-package asset access

#### Configuration Categories
- **App**: Name, version, environment
- **Theme**: Dark mode, high contrast, text scale
- **Navigation**: Analytics, tracking, performance
- **Internationalization**: Languages, RTL, formatting
- **Accessibility**: Screen reader, high contrast, large text
- **Performance**: Isolates, caching, image compression
- **Storage**: Local storage, backup, encryption
- **Network**: Offline mode, timeouts, retries
- **Notifications**: Push, local, sound, vibration
- **Privacy**: Analytics, tracking, data retention
- **Features**: Feature toggles for all app features
- **Debug**: Logging, profiling, error reporting
- **Experimental**: Beta features, new UI, animations

#### Configuration Flow
```dart
// 1. App startup loads from documents directory
final configFile = File('${documentsDir.path}/app_config.json');

// 2. If no user config exists, load from assets
if (!await configFile.exists()) {
  _config = await _getDefaultConfig(); // Loads from assets
  await _saveConfig(); // Saves to documents directory
}

// 3. Asset loading with fallback
Future<Map<String, dynamic>> _getDefaultConfig() async {
  try {
    final jsonString = await rootBundle.loadString('assets/config/default_config.json');
    return json.decode(jsonString);
  } catch (e) {
    return _getFallbackConfig(); // Hardcoded fallback
  }
}
```

#### Usage Examples
```dart
// Service is automatically initialized in main.dart
// No manual initialization needed

// Get a setting
bool isDarkMode = AppConfigService.instance.getValue<bool>('theme.isDarkMode');

// Set a setting
await AppConfigService.instance.setValue('theme.isDarkMode', true);

// Check feature toggle
bool isThemingEnabled = AppConfigService.instance.isFeatureEnabled('enableTheming');

// View configuration
// Navigate to Settings → Configuration → Configuration Viewer

// Reset to default
await AppConfigService.instance.resetToDefault();

// Reload configuration
await AppConfigService.instance.reload();
```

### Font Setup and Management

The project includes comprehensive font support for internationalization using Noto Sans fonts:

#### Font Files
- **Noto Sans**: Latin scripts (English, Spanish, French, German)
- **Noto Sans Arabic**: Arabic script with RTL support
- **Noto Sans Japanese**: Japanese script (Hiragana, Katakana, Kanji)

#### Directory Structure
```
assets/
└── fonts/
    ├── NotoSans-Regular.ttf
    ├── NotoSans-Bold.ttf
    ├── NotoSans-Italic.ttf
    ├── NotoSans-BoldItalic.ttf
    ├── NotoSansArabic-Regular.ttf
    ├── NotoSansArabic-Bold.ttf
    ├── NotoSansJP-Regular.ttf
    └── NotoSansJP-Bold.ttf
```

#### Setup Instructions
1. Run the download script: `./download_fonts.sh`
2. Or manually download from [Google Fonts](https://fonts.google.com/noto)
3. Fonts are automatically available to all subprojects

### Font Management

```dart
// FontUtils provides language-specific font management
import 'package:common/common.dart';

// Get font family for specific language
String fontFamily = FontUtils.getFontFamilyForLanguage('ar'); // 'NotoSansArabic'

// Create text style with language-appropriate font
TextStyle style = FontUtils.getTextStyleForLanguage(
  'ja',
  fontSize: 18.0,
  fontWeight: FontWeight.bold,
);

// Predefined styles for common use cases
Text(
  'Hello World',
  style: FontUtils.heading1, // Uses default font
)

// Language-specific predefined styles
Text(
  'مرحبا بالعالم',
  style: FontUtils.getHeading1ForLanguage('ar'),
)
```

### Custom Page Transitions

```dart
// Each screen has a unique animation
CustomTransitionPage(
  key: state.pageKey,
  child: const MyScreen(),
  transitionsBuilder: (context, animation, secondaryAnimation, child) {
    // Custom animation logic
    return SlideTransition(
      position: offsetAnimation,
      child: child,
    );
  },
  transitionDuration: const Duration(milliseconds: 600),
)
```

### Navigation Service

```dart
// Centralized navigation with proper back button support
AppRouteManager.navigateToTheming(context); // usePush: true by default
AppRouteManager.navigateToTabScreen(context); // Navigate to main tab screen

// Navigation with custom push behavior
AppRouteManager.navigateToTheming(context, usePush: false); // Replace current route
```

### Enhanced Method Channels

```dart
// Centralized method channel management
final deviceInfo = await MethodChannelManager.getDeviceInfo();
final batteryLevel = await MethodChannelManager.getBatteryLevel();
final cameraPermission = await MethodChannelManager.requestCameraPermission();
final locationPermission = await MethodChannelManager.requestLocationPermission();
final apiResponse = await MethodChannelManager.makeApiCall(url, method, data);
```

### Main.dart Refactoring & Asset Access

```dart
// Clean main.dart with focused initialization
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize critical services with error handling
  try {
    await AppConfigService.instance.initialize();
    await AppLocalizations.initialize();
    await ThemeProvider.instance.loadFromConfig();
  } catch (e) {
    await InitializationErrorHandler.showErrorDialogAndExit('Service', e.toString());
    return;
  }

  runApp(const FlutterExplorerApp());
}

// Separated app widget
class FlutterExplorerApp extends StatefulWidget {
  // Main app widget with theme provider integration
}

// Asset access across packages
// packages/core/pubspec.yaml
flutter:
  assets:
    - ../../assets/config/  # Access main project assets

// AppConfigService loads from assets
Future<Map<String, dynamic>> _getDefaultConfig() async {
  try {
    final jsonString = await rootBundle.loadString('assets/config/default_config.json');
    return json.decode(jsonString);
  } catch (e) {
    return _getFallbackConfig(); // Graceful fallback
  }
}
```

### Comprehensive Navigation Analytics

```dart
// Basic analytics from AppRouteObserver
Map<String, dynamic> basicAnalytics = AppRouteManager.getNavigationAnalytics();
List<String> history = AppRouteManager.getNavigationHistory();
Map<String, int> visitCounts = AppRouteManager.getScreenVisitCount();

// Advanced analytics from ComprehensiveNavigationObserver
Map<String, dynamic> comprehensiveAnalytics = AnalyticsData.getComprehensiveAnalytics();
Map<String, List<Duration>> performanceData = AnalyticsData.getScreenPerformanceData();
Map<String, int> navigationErrors = AnalyticsData.getNavigationErrors();
List<MapEntry<String, Duration>> timeSpentData = AnalyticsData.getScreensWithHighestTimeSpent();

// Session management
Duration? sessionDuration = AnalyticsData.getSessionDuration();
AnalyticsData.startSession();
AnalyticsData.endSession();

// Error tracking
AnalyticsData.recordNavigationError('screen_name', 'error_description');
```

### Lifecycle Management

```dart
// Use RouteAware mixin for lifecycle tracking
class MyScreen extends StatefulWidget {
  @override
  State<MyScreen> createState() => _MyScreenState();
}

class _MyScreenState extends State<MyScreen> with RouteAwareMixin {
  @override
  void onScreenVisible() {
    // Screen became visible
  }

  @override
  void onScreenInvisible() {
    // Screen became invisible
  }
}
```

### Isolates

```dart
// Advanced isolate processing
final result = await IsolateManager.computeFibonacci(45);
final primes = await IsolateManager.generatePrimes(1000000);
final imageData = await IsolateManager.downloadImage(url);
```

### Internationalization with RTL Support

```dart
// Multi-language support with complete RTL support
final localizedString = AppLocalizations.getString('welcome_message');
final isRTL = AppLocalizations.isCurrentLocaleRTL;

// Dynamic language switching with automatic UI updates
await AppLocalizations.changeLanguage('ar'); // Automatically switches to RTL

// Language-specific fonts
TextStyle style = FontUtils.getTextStyleForLanguage(
  'ar', // Arabic
  fontSize: 16.0,
  fontWeight: FontWeight.bold,
);

// Predefined language-specific styles
Text(
  'こんにちは',
  style: FontUtils.getBody1ForLanguage('ja'),
)

// RTL support is automatic - the entire app adapts when Arabic is selected
// No manual RTL handling needed in individual widgets
```

### Localization Architecture

The project implements a clean localization architecture:

#### Package Structure
```
packages/
├── core/
│   └── src/localization/
│       ├── app_localizations.dart      # Central localization logic
│       ├── localization_service.dart   # Business logic & state management
│       ├── language_change_listener.dart # Global listener
│       └── models/
│           └── language_model.dart     # Language models
└── common/
    └── src/
        ├── utils/                      # Shared utilities
        └── widgets/                    # Shared widgets
```

#### Key Features
- **Clean Dependencies**: Core package contains all business logic
- **Shared Models**: Common package contains only language models
- **Global Listener**: LanguageChangeListener for real-time UI updates
- **RTL Support**: Automatic text direction changes
- **Optimized Imports**: No unused dependencies or circular imports

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests if applicable
5. Submit a pull request

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- Material Design team for design guidelines
- Open source community for various packages

---

**Note**: This project demonstrates enterprise-level Flutter development with comprehensive navigation analytics (dual observer system), lifecycle management, advanced background processing, custom page transitions, enhanced native communication, animated splash screen, advanced internationalization with complete RTL support, comprehensive accessibility features, optimized package exports, RouteModel architecture, tab-based navigation with proper back button support, modular architecture, asset-based configuration system, robust initialization with error handling, cross-package asset access, and clean dependency management with no unused imports. It serves as a reference for building production-ready Flutter applications with professional architecture and best practices.
