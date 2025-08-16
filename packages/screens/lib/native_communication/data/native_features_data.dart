import 'package:flutter/material.dart';
import '../models/native_feature_model.dart';

/// Data provider for native communication features
class NativeFeaturesData {
  static List<NativeFeatureModel> getNativeFeatures(BuildContext context) {
    return [
      NativeFeatureModel(
        title: 'Device Info',
        subtitle: 'Get device information',
        icon: Icons.phone_android,
        color: Colors.blue,
        onTap: () => _getDeviceInfo(context),
      ),
      NativeFeatureModel(
        title: 'Battery Level',
        subtitle: 'Check battery status',
        icon: Icons.battery_full,
        color: Colors.green,
        onTap: () => _getBatteryLevel(context),
      ),
      NativeFeatureModel(
        title: 'Native Dialog',
        subtitle: 'Show platform dialog',
        icon: Icons.message,
        color: Colors.orange,
        onTap: () => _showNativeDialog(context),
      ),
      NativeFeatureModel(
        title: 'Vibration',
        subtitle: 'Trigger device vibration',
        icon: Icons.vibration,
        color: Colors.purple,
        onTap: () => _triggerVibration(context),
      ),
      NativeFeatureModel(
        title: 'Camera',
        subtitle: 'Access device camera',
        icon: Icons.camera_alt,
        color: Colors.teal,
        onTap: () => _accessCamera(context),
      ),
      NativeFeatureModel(
        title: 'Location',
        subtitle: 'Get current location',
        icon: Icons.location_on,
        color: Colors.red,
        onTap: () => _getLocation(context),
      ),
      NativeFeatureModel(
        title: 'Notifications',
        subtitle: 'Show local notifications',
        icon: Icons.notifications,
        color: Colors.amber,
        onTap: () => _showNotification(context),
      ),
      NativeFeatureModel(
        title: 'Storage',
        subtitle: 'Native data storage',
        icon: Icons.storage,
        color: Colors.indigo,
        onTap: () => _accessStorage(context),
      ),
      NativeFeatureModel(
        title: 'Network API',
        subtitle: 'Make HTTP requests',
        icon: Icons.cloud,
        color: Colors.cyan,
        onTap: () => _makeApiCall(context),
      ),
    ];
  }

  static void _getDeviceInfo(BuildContext context) {
    // This will be implemented in the screen
  }

  static void _getBatteryLevel(BuildContext context) {
    // This will be implemented in the screen
  }

  static void _showNativeDialog(BuildContext context) {
    // This will be implemented in the screen
  }

  static void _triggerVibration(BuildContext context) {
    // This will be implemented in the screen
  }

  static void _accessCamera(BuildContext context) {
    // This will be implemented in the screen
  }

  static void _getLocation(BuildContext context) {
    // This will be implemented in the screen
  }

  static void _showNotification(BuildContext context) {
    // This will be implemented in the screen
  }

  static void _accessStorage(BuildContext context) {
    // This will be implemented in the screen
  }

  static void _makeApiCall(BuildContext context) {
    // This will be implemented in the screen
  }
}
