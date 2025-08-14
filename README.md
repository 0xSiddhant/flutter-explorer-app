# Flutter Core Features Demo

A comprehensive Flutter project designed to explore and understand core Flutter features through a modular package architecture. This project demonstrates various Flutter capabilities including navigation, theme switching, native communication, isolates, localization, and semantic UI.

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
│   │   │       ├── router/       # Navigation logic
│   │   │       └── theme/        # Theme management
│   ├── screens/                  # UI screens and components
│   │   ├── lib/
│   │   │   ├── screens.dart
│   │   │   ├── home_screen/      # Main demo hub
│   │   │   ├── settings_screen/  # App settings
│   │   │   ├── theme_demo_screen/
│   │   │   ├── method_channel_demo/
│   │   │   ├── isolate_demo/
│   │   │   ├── localization_demo/
│   │   │   └── semantic_demo/
│   └── common/                   # Shared utilities
└── README.md
```

## 🚀 Core Features Demonstrated

### 1. **Navigation & Routing**

- **Technology**: `go_router` package
- **Features**:
  - Declarative routing with nested routes
  - Tab-based navigation
  - Deep linking support
  - Navigation observers for analytics

### 2. **Theme Management**

- **Technology**: Material 3 theming
- **Features**:
  - Light/Dark theme switching
  - High contrast mode
  - Dynamic color schemes
  - Custom theme configurations

### 3. **Method Channels (Native Communication)**

- **Technology**: Flutter Platform Channels
- **Features**:
  - Device information retrieval
  - Battery level monitoring
  - Native dialog display
  - Device vibration
  - Error handling and fallbacks

### 4. **Isolates (Background Processing)**

- **Technology**: Dart Isolates
- **Features**:
  - Fibonacci calculation (UI vs Isolate comparison)
  - Prime number generation
  - Pi calculation
  - Progress tracking
  - Performance benchmarking

### 5. **Localization**

- **Technology**: Custom localization system
- **Features**:
  - Multi-language support (English, Spanish, French, German)
  - Dynamic language switching
  - Locale-specific formatting
  - Date, time, number, and currency formatting

### 6. **Semantic UI & Accessibility**

- **Technology**: Flutter Semantics
- **Features**:
  - Screen reader support
  - Semantic labels and hints
  - Accessibility controls
  - High contrast mode
  - Large text support

### 7. **File Storage**

- **Technology**: `path_provider` and `dart:io`
- **Features**:
  - Local file operations
  - Save, load, and delete files
  - File listing and management
  - Error handling and user feedback
  - Sample file creation

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

1. **Home Screen** - Feature demo hub with navigation cards
2. **Settings Screen** - App configuration and accessibility settings

### Demo Screens

1. **Theme Demo** - Interactive theme switching and preview
2. **Method Channel Demo** - Native platform communication examples
3. **Isolate Demo** - Background processing and performance comparison
4. **Localization Demo** - Multi-language support and formatting
5. **Semantic Demo** - Accessibility features and semantic UI
6. **File Storage Demo** - Local file operations and management

## 🎯 Key Learning Points

### Package Architecture

- **Separation of Concerns**: Each package has a specific responsibility
- **Dependency Management**: Clear dependency flow between packages
- **Modularity**: Easy to add, remove, or modify features

### Flutter Best Practices

- **State Management**: Using setState for simple state
- **Widget Composition**: Breaking down complex UIs into smaller widgets
- **Error Handling**: Graceful error handling with user feedback
- **Performance**: Using isolates for heavy computations

### Accessibility

- **Semantic Labels**: Proper labeling for screen readers
- **Keyboard Navigation**: Support for keyboard-only navigation
- **Visual Accessibility**: High contrast and large text support

## 🔧 Development Guidelines

### Code Organization

- Follow the established package structure
- Place new features in appropriate packages
- Use consistent naming conventions
- Add proper documentation

### Adding New Features

1. Create feature in appropriate package
2. Add navigation route in `app_router.dart`
3. Update home screen with navigation card
4. Add proper error handling
5. Test on multiple devices

### Testing

- Test on both Android and iOS
- Verify accessibility features
- Test with screen readers
- Performance testing for isolates

## 📚 Dependencies

### Core Dependencies

- `flutter`: Core Flutter framework
- `go_router`: Navigation and routing
- `material`: Material Design components
- `path_provider`: File system access

### Development Dependencies

- `flutter_test`: Testing framework
- `flutter_lints`: Code linting

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

**Note**: This project is designed for educational purposes to understand Flutter core features. Some features (like method channels) require platform-specific implementations that are not included in this demo.
