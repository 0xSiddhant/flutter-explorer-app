import 'package:flutter/material.dart';
import 'package:common/common.dart';
import 'data/internationalization_data.dart';
import 'models/formatting_example_model.dart';
import 'widgets/language_selector_widget.dart';
import 'widgets/rtl_toggle_widget.dart';
import 'widgets/formatting_examples_widget.dart';
import 'widgets/feature_list_widget.dart';

class InternationalizationScreen extends StatefulWidget {
  const InternationalizationScreen({super.key});

  @override
  State<InternationalizationScreen> createState() =>
      _InternationalizationScreenState();
}

class _InternationalizationScreenState
    extends State<InternationalizationScreen> {
  String _currentLanguage = InternationalizationData.currentLanguage;
  bool _isRTLEnabled = InternationalizationData.isRTLEnabled;
  FormattingDataModel? _formattingData;

  @override
  void initState() {
    super.initState();
    _loadFormattingData();
  }

  void _loadFormattingData() {
    setState(() {
      _formattingData = InternationalizationData.getFormattingData();
    });
  }

  void _onLanguageChanged(String languageCode) {
    setState(() {
      _currentLanguage = languageCode;
      InternationalizationData.setLanguage(languageCode);
      _isRTLEnabled = InternationalizationData.isRTLEnabled;
      _loadFormattingData();
    });
  }

  void _onRTLChanged(bool enabled) {
    setState(() {
      _isRTLEnabled = enabled;
      InternationalizationData.setRTL(enabled);
    });
  }

  void _onFeatureTap(String route) {
    // TODO: Implement navigation to respective features
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '${AppLocalizations.getString('navigating_to', 'en')} $route',
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: _isRTLEnabled ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            AppLocalizations.getString(
              'internationalization',
              _currentLanguage,
            ),
          ),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                LanguageSelectorWidget(
                  currentLanguage: _currentLanguage,
                  onLanguageChanged: _onLanguageChanged,
                ),
                const SizedBox(height: 16),
                RTLToggleWidget(
                  isRTLEnabled: _isRTLEnabled,
                  onRTLChanged: _onRTLChanged,
                ),
                const SizedBox(height: 16),
                _buildWelcomeSection(),
                const SizedBox(height: 16),
                if (_formattingData != null)
                  FormattingExamplesWidget(
                    currentLanguage: _currentLanguage,
                    examples: _formattingData!.examples,
                  ),
                const SizedBox(height: 16),
                FeatureListWidget(
                  currentLanguage: _currentLanguage,
                  onFeatureTap: _onFeatureTap,
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWelcomeSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              InternationalizationData.getWelcomeMessage(),
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              InternationalizationData.getDescription(),
              style: const TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
