import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MethodChannelDemo extends StatefulWidget {
  const MethodChannelDemo({super.key});

  @override
  State<MethodChannelDemo> createState() => _MethodChannelDemoState();
}

class _MethodChannelDemoState extends State<MethodChannelDemo> {
  static const MethodChannel _channel = MethodChannel('flutter_demo_channel');

  String _deviceInfo = 'Unknown';
  String _batteryLevel = 'Unknown';
  String _lastMethodCall = 'None';
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _getDeviceInfo();
  }

  Future<void> _getDeviceInfo() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final String result = await _channel.invokeMethod('getDeviceInfo');
      setState(() {
        _deviceInfo = result;
        _lastMethodCall = 'getDeviceInfo';
      });
    } on PlatformException catch (e) {
      setState(() {
        _deviceInfo = 'Failed to get device info: ${e.message}';
        _lastMethodCall = 'getDeviceInfo (failed)';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _getBatteryLevel() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final int result = await _channel.invokeMethod('getBatteryLevel');
      setState(() {
        _batteryLevel = '$result%';
        _lastMethodCall = 'getBatteryLevel';
      });
    } on PlatformException catch (e) {
      setState(() {
        _batteryLevel = 'Failed to get battery level: ${e.message}';
        _lastMethodCall = 'getBatteryLevel (failed)';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _showNativeDialog() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final String result = await _channel.invokeMethod('showNativeDialog', {
        'title': 'Flutter Demo',
        'message': 'This is a native dialog from Flutter!',
      });
      setState(() {
        _lastMethodCall = 'showNativeDialog - Result: $result';
      });
    } on PlatformException catch (e) {
      setState(() {
        _lastMethodCall = 'showNativeDialog (failed): ${e.message}';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _vibrate() async {
    setState(() {
      _isLoading = true;
    });

    try {
      await _channel.invokeMethod('vibrate', {'duration': 500});
      setState(() {
        _lastMethodCall = 'vibrate';
      });
    } on PlatformException catch (e) {
      setState(() {
        _lastMethodCall = 'vibrate (failed): ${e.message}';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Method Channel Demo'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildInfoCard(),
              const SizedBox(height: 16),
              _buildMethodButtons(),
              const SizedBox(height: 16),
              _buildLastCallInfo(),
              if (_isLoading) ...[
                const SizedBox(height: 16),
                const Center(child: CircularProgressIndicator()),
              ],
              const SizedBox(height: 24), // Add bottom padding
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Device Information',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            _buildInfoRow('Device Info:', _deviceInfo),
            _buildInfoRow('Battery Level:', _batteryLevel),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(
            child: Text(value, style: const TextStyle(fontFamily: 'monospace')),
          ),
        ],
      ),
    );
  }

  Widget _buildMethodButtons() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Native Method Calls',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ElevatedButton(
                  onPressed: _isLoading ? null : _getDeviceInfo,
                  child: const Text('Get Device Info'),
                ),
                ElevatedButton(
                  onPressed: _isLoading ? null : _getBatteryLevel,
                  child: const Text('Get Battery Level'),
                ),
                ElevatedButton(
                  onPressed: _isLoading ? null : _showNativeDialog,
                  child: const Text('Show Native Dialog'),
                ),
                ElevatedButton(
                  onPressed: _isLoading ? null : _vibrate,
                  child: const Text('Vibrate'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLastCallInfo() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Last Method Call',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceVariant,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                _lastMethodCall,
                style: const TextStyle(fontFamily: 'monospace'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
