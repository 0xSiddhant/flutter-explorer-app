import 'package:core/core.dart';
import 'package:flutter/material.dart';
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
  bool _hasHandledParams = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_hasHandledParams) {
      _handleDeepLinkParams();
      _hasHandledParams = true;
    }
  }

  void _handleDeepLinkParams() {
    // Get query parameters using core package utility
    if (!RouteParamsUtils.hasQueryParameters(context)) return;

    // Collect all changes before calling setState once
    bool? newScreenReaderEnabled;
    bool? newHighContrastEnabled;
    bool? newLargeTextEnabled;
    int? newSelectedTab;

    // Handle screen reader parameter
    final screenReaderParam = RouteParamsUtils.getBooleanParameter(
      context,
      'screen_reader',
    );
    if (screenReaderParam != null) {
      newScreenReaderEnabled = screenReaderParam;
      debugPrint('Accessibility: Screen reader set to $newScreenReaderEnabled');
    }

    // Handle high contrast parameter
    final highContrastParam = RouteParamsUtils.getBooleanParameter(
      context,
      'high_contrast',
    );
    if (highContrastParam != null) {
      newHighContrastEnabled = highContrastParam;
      debugPrint('Accessibility: High contrast set to $newHighContrastEnabled');
    }

    // Handle large text parameter
    final largeTextParam = RouteParamsUtils.getBooleanParameter(
      context,
      'large_text',
    );
    if (largeTextParam != null) {
      newLargeTextEnabled = largeTextParam;
      debugPrint('Accessibility: Large text set to $newLargeTextEnabled');
    }

    // Handle tab parameter
    final tabParam = RouteParamsUtils.getIntParameter(context, 'tab');
    if (tabParam != null && tabParam >= 0 && tabParam <= 2) {
      newSelectedTab = tabParam;
      debugPrint('Accessibility: Tab set to $tabParam');
    } else if (tabParam != null) {
      debugPrint('Accessibility: Invalid tab index $tabParam, using default');
    }

    // Apply all changes in a single setState call
    if (newScreenReaderEnabled != null ||
        newHighContrastEnabled != null ||
        newLargeTextEnabled != null ||
        newSelectedTab != null) {
      setState(() {
        if (newScreenReaderEnabled != null) {
          _isScreenReaderEnabled = newScreenReaderEnabled;
        }
        if (newHighContrastEnabled != null) {
          _isHighContrastEnabled = newHighContrastEnabled;
        }
        if (newLargeTextEnabled != null) {
          _isLargeTextEnabled = newLargeTextEnabled;
        }
        if (newSelectedTab != null) {
          _selectedTab = newSelectedTab;
        }
      });
    }

    // Debug all parameters
    debugPrint(
      'Accessibility: Deep link parameters: ${RouteParamsUtils.getParametersDebugString(context)}',
    );
  }

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
          title: Text(AppLocalizations.getString('accessibility')),
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
      activeFeatures.add(AppLocalizations.getString('screen_reader'));
    }
    if (_isHighContrastEnabled) {
      activeFeatures.add(AppLocalizations.getString('high_contrast'));
    }
    if (_isLargeTextEnabled) {
      activeFeatures.add(AppLocalizations.getString('large_text'));
    }

    return Semantics(
      label:
          '${AppLocalizations.getString('active_accessibility_features')}: ${activeFeatures.join(', ')}',
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
