# Flutter Explorer

A comprehensive Flutter project designed to explore and understand core Flutter features through a modular package architecture. This project demonstrates various Flutter capabilities including navigation, theme switching, native communication, isolates, localization, semantic UI, lifecycle management, and navigation analytics.

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
│   │   │       └── method_channel/ # Native communication
│   ├── screens/                  # UI screens and components
│   │   ├── lib/
│   │   │   ├── screens.dart
│   │   │   ├── home_screen/      # Main feature hub
│   │   │   ├── theming/          # Theme management
│   │   │   ├── native_communication/ # Platform integration
│   │   │   ├── background_tasks/ # Isolate processing
│   │   │   ├── internationalization/ # Multi-language support
│   │   │   ├── accessibility/    # Semantic UI
│   │   │   ├── file_management/  # Local storage
│   │   │   ├── advanced_processing/ # Complex operations
│   │   │   ├── navigation_analytics/ # Route tracking
│   │   │   └── lifecycle_management/ # Widget lifecycle
│   └── common/                   # Shared utilities
└── README.md
```

## 🚀 Core Features Demonstrated

### 1. **Route Management**

- **Technology**: `go_router` package with custom observers
- **Features**:
  - Declarative routing with nested routes
  - Tab-based navigation
  - Deep linking support
  - **RouteObserver**: Comprehensive navigation tracking
  - **RouteAware**: Screen lifecycle monitoring
  - Navigation analytics and pattern analysis

### 2. **Theming System**

- **Technology**: Material 3 theming with custom provider
- **Features**:
  - Light/Dark theme switching
  - High contrast mode
  - Dynamic color schemes
  - Custom theme configurations
  - Real-time theme preview
  - Theme persistence

### 3. **Native Communication**

- **Technology**: Flutter Platform Channels with modular architecture
- **Features**:
  - **MethodChannelManager**: Centralized channel management
  - **DeviceService**: Device information retrieval
  - **BatteryService**: Battery level monitoring
  - **DialogService**: Native dialog display
  - **VibrationService**: Device vibration
  - Robust error handling and type safety

### 4. **Background Processing**

- **Technology**: Dart Isolates with comprehensive examples
- **Features**:
  - **IsolateManager**: Centralized isolate management
  - **Fibonacci Calculator**: Performance comparison
  - **Prime Calculator**: Large number processing
  - **Matrix Calculator**: Complex mathematical operations
  - **Image Downloader**: Network operations in isolates
  - **Data Processor**: File and data analysis
  - Progress tracking and performance benchmarking

### 5. **Internationalization**

- **Technology**: Custom localization system
- **Features**:
  - Multi-language support (English, Spanish, French, German)
  - Dynamic language switching
  - Locale-specific formatting
  - Date, time, number, and currency formatting
  - Localization constants in common package

### 6. **Accessibility & Semantic UI**

- **Technology**: Flutter Semantics with comprehensive support
- **Features**:
  - Screen reader support
  - Semantic labels and hints
  - Accessibility controls
  - High contrast mode
  - Large text support
  - Keyboard navigation

### 7. **File Management**

- **Technology**: `path_provider` and `dart:io`
- **Features**:
  - Local file operations
  - Save, load, and delete files
  - File listing and management
  - Error handling and user feedback
  - Sample file creation and processing

### 8. **Lifecycle Management** 🆕

- **Technology**: Widget lifecycle tracking with RouteAware
- **Features**:
  - **Widget Lifecycle**: Complete widget state tracking
  - **App Lifecycle**: Foreground/background state monitoring
  - **Navigation Lifecycle**: Screen visibility tracking
  - **Real-time Event Logging**: Timestamped lifecycle events
  - **Performance Metrics**: Screen-specific performance data
  - **Memory Management**: Resource allocation tracking

### 9. **Navigation Analytics** 🆕

- **Technology**: Custom RouteObserver with advanced analytics
- **Features**:
  - **Navigation Tracking**: Complete navigation history
  - **Pattern Analysis**: Most common navigation sequences
  - **Time Analytics**: Average time per screen
  - **Session Tracking**: Session duration and patterns
  - **Performance Insights**: Screen visit counts and metrics
  - **Real-time Updates**: Live analytics dashboard

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

3. **Run the app**
   ```bash
   flutter run
   ```

## 📱 App Navigation

### Main Screens

1. **Flutter Explorer** - Feature hub with professional navigation cards
2. **Settings** - App configuration and accessibility settings

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
- **Navigation Analytics**: Comprehensive route tracking
- **Lifecycle Management**: Complete widget and app state monitoring

### Advanced Features

- **RouteObserver**: Custom navigation tracking and analytics
- **RouteAware**: Screen lifecycle monitoring
- **Method Channels**: Modular native communication
- **Isolates**: Advanced background processing
- **Analytics**: Real-time navigation insights
- **Lifecycle Tracking**: Complete app state monitoring

### Accessibility

- **Semantic Labels**: Proper labeling for screen readers
- **Keyboard Navigation**: Support for keyboard-only navigation
- **Visual Accessibility**: High contrast and large text support
- **Screen Reader**: Comprehensive accessibility support

## 🔧 Development Guidelines

### Code Organization

- Follow the established package structure
- Place new features in appropriate packages
- Use consistent naming conventions
- Add proper documentation
- Implement modular architecture (models, data, widgets)

### Adding New Features

1. Create feature in appropriate package
2. Add navigation route in `app_router.dart`
3. Update home screen with navigation card
4. Add proper error handling
5. Test on multiple devices
6. Include analytics tracking if applicable

### Testing

- Test on both Android and iOS
- Verify accessibility features
- Test with screen readers
- Performance testing for isolates
- Navigation analytics validation
- Lifecycle tracking verification

## 📚 Dependencies

### Core Dependencies

- `flutter`: Core Flutter framework
- `go_router`: Navigation and routing
- `material`: Material Design components
- `path_provider`: File system access

### Development Dependencies

- `flutter_test`: Testing framework
- `flutter_lints`: Code linting

## 🚀 Advanced Features

### Navigation Analytics

```dart
// Get comprehensive navigation analytics
Map<String, dynamic> analytics = AppRouteManager.getNavigationAnalytics();

// Track navigation patterns
List<String> history = AppRouteManager.getNavigationHistory();

// Monitor screen performance
Map<String, int> visitCounts = AppRouteManager.getScreenVisitCount();
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

### Method Channels

```dart
// Centralized method channel management
final deviceInfo = await MethodChannelManager.getDeviceInfo();
final batteryLevel = await MethodChannelManager.getBatteryLevel();
final success = await MethodChannelManager.vibrate(duration: 500);
```

### Isolates

```dart
// Advanced isolate processing
final result = await IsolateManager.computeFibonacci(45);
final primes = await IsolateManager.generatePrimes(1000000);
final imageData = await IsolateManager.downloadImage(url);
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

**Note**: This project demonstrates enterprise-level Flutter development with comprehensive navigation analytics, lifecycle management, and advanced background processing capabilities. It serves as a reference for building production-ready Flutter applications with professional architecture and best practices.
