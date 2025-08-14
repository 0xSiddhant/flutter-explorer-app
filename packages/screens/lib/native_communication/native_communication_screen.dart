import 'package:flutter/material.dart';
import 'package:core/core.dart';
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
        title: const Text('Native Communication'),
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
          Text('Results', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          if (_isLoading) ...[
            const LinearProgressIndicator(),
            const SizedBox(height: 8),
            const Text('Processing...'),
          ],
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceVariant,
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
}
