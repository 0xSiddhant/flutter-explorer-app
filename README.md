# Flutter Explorer

A comprehensive Flutter project designed to explore and understand core Flutter features through a modular package architecture. This project demonstrates various Flutter capabilities including navigation, dynamic theme switching, native communication, isolates, localization, semantic UI, lifecycle management, navigation analytics, custom page transitions, advanced accessibility features, and dynamic feature toggles.

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
│   │   │       ├── theme/        # Theme management
│   │   │       ├── isolate/      # Background processing
│   │   │       ├── method_channel/ # Native communication & platform observers
│   │   │       ├── localization/ # Complete localization system
│   │   │       ├── page_transitions/ # Custom page animations
│   │   │       └── state_restoration/ # Complete state restoration system
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

### 1. **Route Management & Custom Page Transitions**

- **Technology**: `go_router` package with `CustomTransitionPage`
- **Features**: Optimized navigation flow, tab-based navigation, proper back button support, route analytics, custom page transitions

### 2. **Enhanced Native Communication**

- **Technology**: Flutter Platform Channels with modular architecture
- **Features**: Device info, battery level, native dialogs, vibration, camera, location, notifications, storage, API calls

### 3. **Animated Splash Screen**

- **Technology**: Custom animations with `AnimationController`
- **Features**: Beautiful animations, gradient background, logo animation, progress indicator, smooth transitions

### 4. **Advanced Internationalization with RTL Support**

- **Technology**: Custom localization system with complete RTL support
- **Features**: Multi-language support (English, Spanish, French, German, Arabic, Japanese, Egyptian Arabic), complete RTL/LTR support, dynamic language switching, locale-specific formatting

### 5. **Enhanced Accessibility Features**

- **Technology**: Flutter Semantics with comprehensive support
- **Features**: Screen reader support, high contrast mode, large text support, semantic labels, interactive controls

### 6. **Scroll State Preservation**

- **Technology**: `AutomaticKeepAliveClientMixin` with `PageStorageKey`
- **Features**: Tab scroll preservation, automatic widget lifecycle management, scroll position restoration

### 7. **Dynamic Theming System**

- **Technology**: Material 3 theming with dynamic theme registration
- **Features**: Dynamic theme registration, multiple themes (Harry Potter, Dark Blue, One Piece, Studio Ghibli), real-time theme preview, theme component showcase

### 8. **Background Processing**

- **Technology**: Dart Isolates with comprehensive examples
- **Features**: IsolateManager, Fibonacci calculator, prime calculator, matrix calculator, image downloader, data processor

### 9. **File Management**

- **Technology**: `path_provider` and `dart:io`
- **Features**: Local file operations, save/load/delete files, file listing, error handling

### 10. **Lifecycle Management**

- **Technology**: Widget lifecycle tracking with RouteAware
- **Features**: Widget lifecycle, app lifecycle, navigation lifecycle, real-time event logging

### 11. **Comprehensive Navigation Analytics**

- **Technology**: Dual RouteObserver system with modular architecture
- **Features**: Basic analytics, advanced analytics, modular dashboard, performance tracking, user behavior analysis

### 12. **Device Date Change Observer**

- **Technology**: Method Channels with platform-specific implementations
- **Features**: Cross-platform monitoring, automatic notifications, memory leak prevention, platform-specific implementation

### 13. **Feature Toggle System**

- **Technology**: Configuration-driven feature management
- **Features**: Dynamic feature control, real-time updates, settings integration, configuration persistence

### 14. **State Restoration System**

- **Technology**: Custom state restoration with navigation stack preservation
- **Features**: Complete app state restoration, tab index preservation, navigation stack rebuilding, scroll position restoration, robust error handling

### 15. **Deep Linking System**

- **Technology**: Custom URL scheme with GoRouter integration
- **Features**: `frouter://` scheme support, parameter passing, cross-platform compatibility, navigation stack management, validation and fallback handling
- **Documentation**: See [Deep Linking Guide](packages/core/lib/src/router/DEEP_LINKING.md) for complete implementation details

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
11. **Deep Link Test** - Test deep linking functionality with various URLs

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
- **Scroll State Management**: AutomaticKeepAliveClientMixin for preserving tab scroll positions
- **State Restoration**: Complete app state restoration with navigation stack preservation
- **Deep Linking**: Custom URL scheme with parameter passing and cross-platform support

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
- **Scroll State Preservation**: AutomaticKeepAliveClientMixin with PageStorageKey for tab scroll preservation
- **State Restoration**: Complete app state restoration with navigation stack rebuilding and tab index preservation
- **Deep Linking**: Custom `frouter://` scheme with parameter support, cross-platform compatibility, and navigation stack management

### Accessibility

- **Semantic Labels**: Proper labeling for screen readers
- **Keyboard Navigation**: Support for keyboard-only navigation
- **Visual Accessibility**: High contrast and large text support
- **Screen Reader**: Comprehensive accessibility support
- **Interactive Controls**: Toggle switches for accessibility features

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

## 🔧 Code Examples

### Scroll State Preservation with AutomaticKeepAliveClientMixin

```dart
// Tab screens with AutomaticKeepAliveClientMixin
class _HomeScreenState extends State<HomeScreen> with AutomaticKeepAliveClientMixin {
  late ScrollController _scrollController;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // Required for AutomaticKeepAliveClientMixin
    return GridView.builder(
      controller: _scrollController,
      key: const PageStorageKey<String>('home_screen_grid'),
      // ... rest of implementation
    );
  }
}

// TabBarView with PageStorageKey
TabBarView(
  controller: _tabController,
  children: _tabItems.asMap().entries.map((entry) {
    final index = entry.key;
    final tab = entry.value;
    return KeyedSubtree(
      key: PageStorageKey<String>('tab_$index'),
      child: tab.screen,
    );
  }).toList(),
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
