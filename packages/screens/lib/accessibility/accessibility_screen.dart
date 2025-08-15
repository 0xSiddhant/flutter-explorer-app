import 'package:flutter/material.dart';
import 'package:common/common.dart';
import 'data/accessibility_data.dart';
import 'widgets/accessibility_controls_widget.dart';
import 'widgets/semantic_examples_widget.dart';
import 'widgets/action_feedback_widget.dart';

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
    // Apply accessibility features to the theme
    final theme = Theme.of(context).copyWith(
      textTheme: _isLargeTextEnabled
          ? Theme.of(context).textTheme.apply(fontSizeFactor: 1.2)
          : Theme.of(context).textTheme,
      colorScheme: _isHighContrastEnabled
          ? Theme.of(context).colorScheme.copyWith(
              primary: Colors.yellow,
              onPrimary: Colors.black,
              surface: Colors.black,
              onSurface: Colors.yellow,
              background: Colors.black,
              onBackground: Colors.yellow,
              surfaceContainerHighest: Colors.grey[900]!,
            )
          : Theme.of(context).colorScheme,
    );

    final accessibilityFeatures = AccessibilityData.getAccessibilityFeatures(
      isScreenReaderEnabled: _isScreenReaderEnabled,
      isHighContrastEnabled: _isHighContrastEnabled,
      isLargeTextEnabled: _isLargeTextEnabled,
      onScreenReaderChanged: (value) {
        setState(() {
          _isScreenReaderEnabled = value;
          _lastAction = 'Screen reader ${value ? 'enabled' : 'disabled'}';
        });
        // Show screen reader demo message
        if (value) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Screen reader mode enabled. Use your device\'s accessibility features to navigate.',
              ),
              duration: const Duration(seconds: 3),
            ),
          );
        }
      },
      onHighContrastChanged: (value) {
        setState(() {
          _isHighContrastEnabled = value;
          _lastAction = 'High contrast ${value ? 'enabled' : 'disabled'}';
        });
      },
      onLargeTextChanged: (value) {
        setState(() {
          _isLargeTextEnabled = value;
          _lastAction = 'Large text ${value ? 'enabled' : 'disabled'}';
        });
      },
    );

    return Theme(
      data: theme,
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.getString('accessibility', 'en')),
          backgroundColor: theme.colorScheme.inversePrimary,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                AccessibilityControlsWidget(features: accessibilityFeatures),
                const SizedBox(height: 16),
                // Show accessibility status
                if (_isScreenReaderEnabled ||
                    _isHighContrastEnabled ||
                    _isLargeTextEnabled) ...[
                  _buildAccessibilityStatus(),
                  const SizedBox(height: 16),
                ],
                // Show screen reader demo when enabled
                if (_isScreenReaderEnabled) ...[
                  _buildScreenReaderDemo(),
                  const SizedBox(height: 16),
                ],
                SemanticExamplesWidget(
                  selectedTab: _selectedTab,
                  onTabChanged: (index) {
                    setState(() {
                      _selectedTab = index;
                    });
                  },
                  onActionPerformed: (action) {
                    setState(() {
                      _lastAction = action;
                    });
                  },
                ),
                const SizedBox(height: 16),
                ActionFeedbackWidget(lastAction: _lastAction),
                const SizedBox(height: 24), // Add bottom padding
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAccessibilityStatus() {
    final List<String> activeFeatures = [];
    if (_isScreenReaderEnabled) {
      activeFeatures.add(AppLocalizations.getString('screen_reader', 'en'));
    }
    if (_isHighContrastEnabled) {
      activeFeatures.add(AppLocalizations.getString('high_contrast', 'en'));
    }
    if (_isLargeTextEnabled) {
      activeFeatures.add(AppLocalizations.getString('large_text', 'en'));
    }

    return Semantics(
      label:
          '${AppLocalizations.getString('active_accessibility_features', 'en')}: ${activeFeatures.join(', ')}',
      child: Card(
        color: Theme.of(context).colorScheme.primaryContainer,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.accessibility_new,
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      AppLocalizations.getString(
                        'active_accessibility_features',
                        'en',
                      ),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                activeFeatures.join(', '),
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildScreenReaderDemo() {
    return Container(
      key: const ValueKey('screen_reader_demo'),
      child: Semantics(
        label:
            'Screen reader demo section. This section demonstrates how screen readers interpret different UI elements.',
        child: Card(
          color: Theme.of(context).colorScheme.secondaryContainer,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.hearing,
                      color: Theme.of(context).colorScheme.onSecondaryContainer,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Screen Reader Demo',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Theme.of(
                            context,
                          ).colorScheme.onSecondaryContainer,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Semantics(
                  label: 'Demo button. Double tap to activate.',
                  button: true,
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _lastAction = 'Screen reader demo button pressed';
                        });
                      },
                      child: const Text('Demo Button'),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Semantics(
                  label: 'Demo text field. Enter your name.',
                  textField: true,
                  child: TextField(
                    decoration: const InputDecoration(
                      labelText: 'Enter your name',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _lastAction = 'Text field updated: $value';
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
