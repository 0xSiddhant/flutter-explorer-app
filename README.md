# Flutter Explorer

A comprehensive Flutter project designed to explore and understand core Flutter features through a modular package architecture. This project demonstrates various Flutter capabilities including navigation, theme switching, native communication, isolates, localization, semantic UI, lifecycle management, navigation analytics, custom page transitions, and advanced accessibility features.

## 🏗️ Project Structure

The project is organized into modular packages for better maintainability and separation of concerns:

```
the_router/
├── lib/
│   └── main.dart                 # App entry point
├── packages/
│   ├── core/                     # Core features and utilities
│   │   ├── lib/
│   │   │   ├── core.dart
│   │   │   └── src/
│   │   │       ├── router/       # Navigation logic and analytics
│   │   │       ├── theme/        # Theme management
│   │   │       ├── isolate/      # Background processing
│   │   │       ├── method_channel/ # Native communication
│   │   │       └── page_transitions/ # Custom page animations
│   ├── screens/                  # UI screens and components
│   │   ├── lib/
│   │   │   ├── screens.dart
│   │   │   ├── splash_screen/    # Animated splash screen
│   │   │   ├── home_screen/      # Main feature hub
│   │   │   ├── theming/          # Theme management
│   │   │   ├── native_communication/ # Platform integration
│   │   │   ├── background_tasks/ # Isolate processing
│   │   │   ├── internationalization/ # Multi-language support
│   │   │   ├── accessibility/    # Semantic UI & accessibility
│   │   │   ├── file_management/  # Local storage
│   │   │   ├── advanced_processing/ # Complex operations
│   │   │   ├── navigation_analytics/ # Comprehensive route tracking & analytics
│   │   │   ├── lifecycle_management/ # Widget lifecycle
│   │   │   └── settings_screen/  # App settings & preferences
│   └── common/                   # Shared utilities
└── README.md
```

## 🚀 Core Features Demonstrated

### 1. **Route Management & Custom Page Transitions** 🆕

- **Technology**: `go_router` package with `CustomTransitionPage`
- **Features**:
  - Declarative routing with nested routes
  - Tab-based navigation
  - Deep linking support
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

### 4. **Advanced Internationalization** 🆕

- **Technology**: Custom localization system with RTL support and Noto Sans fonts
- **Features**:
  - **Multi-language Support**: English, Spanish, French, German, Arabic, Japanese
  - **RTL/LTR Support**: Right-to-left text direction for Arabic
  - **Dynamic Language Switching**: Real-time language changes
  - **Locale-specific Formatting**: Date, time, number, and currency
  - **App-level Direction Control**: Toggle between RTL and LTR
  - **Complete String Localization**: All UI strings internationalized
  - **Cultural Adaptations**: Proper formatting for each locale
  - **Language-specific Fonts**: Noto Sans fonts for optimal rendering
    - Noto Sans (Latin scripts: English, Spanish, French, German)
    - Noto Sans Arabic (Arabic script)
    - Noto Sans Japanese (Japanese script: Hiragana, Katakana, Kanji)
  - **FontUtils Class**: Centralized font management with language-specific styling
  - **JSON-based Localization**: Separate JSON files for each language
  - **Font Demo Widget**: Visual demonstration of language-specific font rendering

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

### Main Screens

1. **Splash Screen** - Animated welcome screen with beautiful transitions
2. **Flutter Explorer** - Feature hub with professional navigation cards
3. **Settings** - App configuration and accessibility settings

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

### Advanced Features

- **Dual RouteObserver System**: Basic and comprehensive navigation analytics
- **RouteAware**: Screen lifecycle monitoring
- **Method Channels**: Modular native communication
- **Isolates**: Advanced background processing
- **Analytics**: Real-time navigation insights
- **Lifecycle Tracking**: Complete app state monitoring
- **Page Transitions**: Custom animations for each screen
- **Internationalization**: Multi-language with RTL support

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

### Adding New Features

1. Create feature in appropriate package
2. Add navigation route in `app_router.dart`
3. Update home screen with navigation card
4. Add proper error handling
5. Test on multiple devices
6. Include analytics tracking if applicable
7. Add custom page transition animation
8. Implement accessibility features

### Modular Architecture Guidelines

- **Models**: Data structures and business logic
- **Data**: Data providers and API calls
- **Widgets**: UI components organized by functionality
- **Separation of Concerns**: Each widget has a single responsibility
- **Reusability**: Create reusable components
- **Maintainability**: Keep files under 200 lines when possible

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

### Enhanced Method Channels

```dart
// Centralized method channel management
final deviceInfo = await MethodChannelManager.getDeviceInfo();
final batteryLevel = await MethodChannelManager.getBatteryLevel();
final cameraPermission = await MethodChannelManager.requestCameraPermission();
final locationPermission = await MethodChannelManager.requestLocationPermission();
final apiResponse = await MethodChannelManager.makeApiCall(url, method, data);
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

### Internationalization

```dart
// Multi-language support with RTL
final localizedString = AppLocalizations.getString('welcome_message');
final isRTL = AppLocalizations.isCurrentLocaleRTL;

// Dynamic language switching
await AppLocalizations.changeLanguage('ja');

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
```

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

**Note**: This project demonstrates enterprise-level Flutter development with comprehensive navigation analytics (dual observer system), lifecycle management, advanced background processing, custom page transitions, enhanced native communication, animated splash screen, advanced internationalization, comprehensive accessibility features, and modular architecture. It serves as a reference for building production-ready Flutter applications with professional architecture and best practices.
