import 'package:flutter/material.dart';
import 'package:core/core.dart';
import 'package:common/common.dart';
import 'data/native_features_data.dart';
import 'widgets/native_feature_card.dart';
import 'models/native_feature_model.dart';

class NativeCommunicationScreen extends StatefulWidget {
  const NativeCommunicationScreen({super.key});

  @override
  State<NativeCommunicationScreen> createState() =>
      _NativeCommunicationScreenState();
}

class _NativeCommunicationScreenState extends State<NativeCommunicationScreen> {
  String _result = 'No operation performed yet';
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final nativeFeatures = NativeFeaturesData.getNativeFeatures(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.getString('native_communication', 'en')),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Platform Integration',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 1.1,
                  ),
                  itemCount: nativeFeatures.length,
                  itemBuilder: (context, index) {
                    final feature = nativeFeatures[index];
                    return NativeFeatureCard(
                      feature: NativeFeatureModel(
                        title: feature.title,
                        subtitle: feature.subtitle,
                        icon: feature.icon,
                        color: feature.color,
                        onTap: () => _handleFeatureTap(feature.title),
                      ),
                    );
                  },
                ),
              ),
            ),
            _buildResultSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildResultSection() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.getString('results', 'en'),
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          if (_isLoading) ...[
            const LinearProgressIndicator(),
            const SizedBox(height: 8),
            Text(AppLocalizations.getString('processing', 'en')),
          ],
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(_result, style: Theme.of(context).textTheme.bodyMedium),
          ),
        ],
      ),
    );
  }

  void _handleFeatureTap(String featureTitle) async {
    setState(() {
      _isLoading = true;
      _result = 'Processing $featureTitle...';
    });

    try {
      switch (featureTitle) {
        case 'Device Info':
          await _getDeviceInfo();
          break;
        case 'Battery Level':
          await _getBatteryLevel();
          break;
        case 'Native Dialog':
          await _showNativeDialog();
          break;
        case 'Vibration':
          await _triggerVibration();
          break;
        case 'Camera':
          await _accessCamera();
          break;
        case 'Location':
          await _getLocation();
          break;
        case 'Notifications':
          await _showNotification();
          break;
        case 'Storage':
          await _accessStorage();
          break;
        case 'Network API':
          await _makeApiCall();
          break;
      }
    } catch (e) {
      setState(() {
        _result = 'Error: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _getDeviceInfo() async {
    final deviceInfo = await MethodChannelManager.getDeviceInfo();
    setState(() {
      _result =
          'Device Info:\n'
          'Platform: ${deviceInfo['platform']}\n'
          'Version: ${deviceInfo['version']}';
    });
  }

  Future<void> _getBatteryLevel() async {
    final batteryLevel = await MethodChannelManager.getBatteryLevel();
    setState(() {
      if (batteryLevel >= 0) {
        _result = 'Battery Level: $batteryLevel%';
      } else {
        _result = 'Failed to get battery level';
      }
    });
  }

  Future<void> _showNativeDialog() async {
    final success = await MethodChannelManager.showNativeDialog(
      title: 'Native Dialog',
      message: 'This is a native platform dialog!',
    );
    setState(() {
      _result = success ? 'Dialog shown successfully' : 'Failed to show dialog';
    });
  }

  Future<void> _triggerVibration() async {
    final success = await MethodChannelManager.vibrate(duration: 500);
    setState(() {
      _result = success ? 'Vibration triggered' : 'Failed to trigger vibration';
    });
  }

  Future<void> _accessCamera() async {
    final hasPermission = await MethodChannelManager.checkCameraPermission();
    if (!hasPermission) {
      final granted = await MethodChannelManager.requestCameraPermission();
      if (!granted) {
        setState(() {
          _result = 'Camera permission denied';
        });
        return;
      }
    }

    final result = await MethodChannelManager.takePhoto();
    setState(() {
      if (result['success'] == true) {
        _result = 'Photo taken successfully!\nPath: ${result['path'] ?? 'N/A'}';
      } else {
        _result = 'Failed to take photo: ${result['error'] ?? 'Unknown error'}';
      }
    });
  }

  Future<void> _getLocation() async {
    final isEnabled = await MethodChannelManager.isLocationEnabled();
    if (!isEnabled) {
      setState(() {
        _result = 'Location services are disabled';
      });
      return;
    }

    final hasPermission = await MethodChannelManager.checkLocationPermission();
    if (!hasPermission) {
      final granted = await MethodChannelManager.requestLocationPermission();
      if (!granted) {
        setState(() {
          _result = 'Location permission denied';
        });
        return;
      }
    }

    final result = await MethodChannelManager.getCurrentLocation();
    setState(() {
      if (result['success'] == true) {
        final latitude = result['latitude'] ?? 'N/A';
        final longitude = result['longitude'] ?? 'N/A';
        _result =
            'Location obtained!\nLatitude: $latitude\nLongitude: $longitude';
      } else {
        _result =
            'Failed to get location: ${result['error'] ?? 'Unknown error'}';
      }
    });
  }

  Future<void> _showNotification() async {
    final hasPermission =
        await MethodChannelManager.checkNotificationPermission();
    if (!hasPermission) {
      final granted =
          await MethodChannelManager.requestNotificationPermission();
      if (!granted) {
        setState(() {
          _result = 'Notification permission denied';
        });
        return;
      }
    }

    final success = await MethodChannelManager.showNotification(
      title: 'Flutter Explorer',
      message: 'This is a native notification!',
      id: DateTime.now().millisecondsSinceEpoch,
    );

    setState(() {
      _result = success
          ? 'Notification sent successfully!'
          : 'Failed to send notification';
    });
  }

  Future<void> _accessStorage() async {
    // Save some test data
    final saveSuccess = await MethodChannelManager.saveData(
      key: 'test_key',
      value: 'Hello from Flutter! ${DateTime.now()}',
    );

    if (saveSuccess) {
      // Load the data back
      final loadedData = await MethodChannelManager.loadData('test_key');

      // Get storage info
      final storageInfo = await MethodChannelManager.getStorageInfo();

      setState(() {
        _result =
            'Storage Test Results:\n'
            'Save: ${saveSuccess ? "Success" : "Failed"}\n'
            'Load: ${loadedData ?? "Failed"}\n'
            'Storage Info: ${storageInfo['success'] == true ? "Available" : "Error"}';
      });
    } else {
      setState(() {
        _result = 'Failed to save data to storage';
      });
    }
  }

  Future<void> _makeApiCall() async {
    // Make a GET request to JSONPlaceholder API
    final result = await MethodChannelManager.getRequest(
      url: 'https://jsonplaceholder.typicode.com/posts/1',
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );

    setState(() {
      if (result['success'] == true) {
        final statusCode = result['statusCode'] ?? 'N/A';
        final body = result['body'] ?? 'No response body';
        _result =
            'API Call Successful!\n'
            'Status Code: $statusCode\n'
            'Response Body:\n$body';
      } else {
        _result = 'API Call Failed: ${result['error'] ?? 'Unknown error'}';
      }
    });
  }
}
