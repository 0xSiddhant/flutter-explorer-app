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
}
