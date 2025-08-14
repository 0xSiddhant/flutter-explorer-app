import 'package:flutter/material.dart';

class AccessibilityScreen extends StatefulWidget {
  const AccessibilityScreen({super.key});

  @override
  State<AccessibilityScreen> createState() => _AccessibilityScreenState();
}

class _AccessibilityScreenState extends State<AccessibilityScreen> {
  bool _isScreenReaderEnabled = false;
  bool _isHighContrastEnabled = false;
  bool _isLargeTextEnabled = false;
  int _selectedTab = 0;
  String _lastAction = 'No action performed';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Accessibility'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildAccessibilityControls(),
              const SizedBox(height: 16),
              _buildSemanticExamples(),
              const SizedBox(height: 16),
              _buildActionFeedback(),
              const SizedBox(height: 24), // Add bottom padding
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAccessibilityControls() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Accessibility Controls',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            SwitchListTile(
              title: const Text('Screen Reader Mode'),
              subtitle: const Text('Enable voice feedback for UI elements'),
              value: _isScreenReaderEnabled,
              onChanged: (value) {
                setState(() {
                  _isScreenReaderEnabled = value;
                  _lastAction =
                      'Screen reader ${value ? 'enabled' : 'disabled'}';
                });
              },
            ),
            SwitchListTile(
              title: const Text('High Contrast'),
              subtitle: const Text('Increase contrast for better visibility'),
              value: _isHighContrastEnabled,
              onChanged: (value) {
                setState(() {
                  _isHighContrastEnabled = value;
                  _lastAction =
                      'High contrast ${value ? 'enabled' : 'disabled'}';
                });
              },
            ),
            SwitchListTile(
              title: const Text('Large Text'),
              subtitle: const Text('Increase text size for better readability'),
              value: _isLargeTextEnabled,
              onChanged: (value) {
                setState(() {
                  _isLargeTextEnabled = value;
                  _lastAction = 'Large text ${value ? 'enabled' : 'disabled'}';
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSemanticExamples() {
    return Expanded(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Semantic UI Examples',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _buildSemanticButton(),
                      const SizedBox(height: 16),
                      _buildSemanticImage(),
                      const SizedBox(height: 16),
                      _buildSemanticTabBar(),
                      const SizedBox(height: 16),
                      _buildSemanticForm(),
                      const SizedBox(height: 16),
                      _buildSemanticList(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSemanticButton() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Semantic Button',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        Semantics(
          label: 'Primary action button',
          hint: 'Double tap to perform the main action',
          button: true,
          child: ElevatedButton(
            onPressed: () {
              setState(() {
                _lastAction = 'Primary button pressed';
              });
            },
            child: const Text('Primary Action'),
          ),
        ),
      ],
    );
  }

  Widget _buildSemanticImage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Semantic Image',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        Semantics(
          label: 'Flutter logo showing the Flutter framework mascot',
          image: true,
          child: Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.flutter_dash, size: 60, color: Colors.blue),
          ),
        ),
      ],
    );
  }

  Widget _buildSemanticTabBar() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Semantic Tab Bar',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        Semantics(
          label: 'Tab navigation with $_selectedTab tabs',
          child: Row(
            children: [
              _buildSemanticTab('Home', 0, Icons.home),
              _buildSemanticTab('Profile', 1, Icons.person),
              _buildSemanticTab('Settings', 2, Icons.settings),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSemanticTab(String label, int index, IconData icon) {
    final isSelected = _selectedTab == index;
    return Expanded(
      child: Semantics(
        label: '$label tab',
        selected: isSelected,
        button: true,
        child: GestureDetector(
          onTap: () {
            setState(() {
              _selectedTab = index;
              _lastAction = '$label tab selected';
            });
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: isSelected
                  ? Theme.of(context).colorScheme.primaryContainer
                  : Colors.transparent,
              border: Border(
                bottom: BorderSide(
                  color: isSelected
                      ? Theme.of(context).colorScheme.primary
                      : Colors.transparent,
                  width: 2,
                ),
              ),
            ),
            child: Column(
              children: [
                Icon(
                  icon,
                  color: isSelected
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.onSurfaceVariant,
                ),
                const SizedBox(height: 4),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    color: isSelected
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSemanticForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Semantic Form',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        Semantics(
          label: 'Contact form',
          child: Column(
            children: [
              Semantics(
                label: 'Name input field',
                textField: true,
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _lastAction = 'Name field updated: $value';
                    });
                  },
                ),
              ),
              const SizedBox(height: 8),
              Semantics(
                label: 'Email input field',
                textField: true,
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _lastAction = 'Email field updated: $value';
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSemanticList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Semantic List',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        Semantics(
          label: 'List of items',
          child: Column(
            children: [
              _buildSemanticListItem(
                'First item',
                'This is the first item in the list',
              ),
              _buildSemanticListItem(
                'Second item',
                'This is the second item in the list',
              ),
              _buildSemanticListItem(
                'Third item',
                'This is the third item in the list',
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSemanticListItem(String title, String subtitle) {
    return Semantics(
      label: '$title, $subtitle',
      button: true,
      child: ListTile(
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {
          setState(() {
            _lastAction = '$title selected';
          });
        },
      ),
    );
  }

  Widget _buildActionFeedback() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Last Action',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                _lastAction,
                style: const TextStyle(fontFamily: 'monospace'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
