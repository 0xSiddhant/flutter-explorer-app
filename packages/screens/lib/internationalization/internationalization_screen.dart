import 'package:flutter/material.dart';
import 'package:common/common.dart';

class InternationalizationScreen extends StatefulWidget {
  const InternationalizationScreen({super.key});

  @override
  State<InternationalizationScreen> createState() =>
      _InternationalizationScreenState();
}

class _InternationalizationScreenState
    extends State<InternationalizationScreen> {
  String _currentLanguage = 'en';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Internationalization'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildLanguageSelector(),
              const SizedBox(height: 16),
              _buildWelcomeSection(),
              const SizedBox(height: 16),
              _buildFormattingExamples(),
              const SizedBox(height: 16),
              _buildFeatureList(),
              const SizedBox(height: 24), // Add bottom padding
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLanguageSelector() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.getString('select_language', _currentLanguage),
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: AppLocalizations.supportedLanguages.asMap().entries.map(
                (entry) {
                  final languageCode = entry.value;
                  final languageName =
                      AppLocalizations.supportedLanguageNames[entry.key];
                  return ChoiceChip(
                    label: Text(languageName),
                    selected: _currentLanguage == languageCode,
                    onSelected: (selected) {
                      if (selected) {
                        setState(() {
                          _currentLanguage = languageCode;
                        });
                      }
                    },
                  );
                },
              ).toList(),
            ),
          ],
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
              AppLocalizations.getString('app_title', _currentLanguage),
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'This app demonstrates various Flutter core features including localization support.',
              style: const TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFormattingExamples() {
    final now = DateTime.now();
    final number = 1234567.89;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.getString(
                'formatting_examples',
                _currentLanguage,
              ),
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildFormatRow(
              AppLocalizations.getString('current_time', _currentLanguage),
              AppLocalizations.formatTime(now, _currentLanguage),
            ),
            _buildFormatRow(
              AppLocalizations.getString('date_format', _currentLanguage),
              AppLocalizations.formatDate(now, _currentLanguage),
            ),
            _buildFormatRow(
              AppLocalizations.getString('number_format', _currentLanguage),
              AppLocalizations.formatNumber(number, _currentLanguage),
            ),
            _buildFormatRow(
              AppLocalizations.getString('currency_format', _currentLanguage),
              AppLocalizations.formatCurrency(number, _currentLanguage),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFormatRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
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

  Widget _buildFeatureList() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.getString('core_features', _currentLanguage),
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 200, // Fixed height for feature list
              child: ListView(
                children: [
                  _buildFeatureItem(
                    AppLocalizations.getString('navigation', _currentLanguage),
                    Icons.navigation,
                  ),
                  _buildFeatureItem(
                    AppLocalizations.getString('theme', _currentLanguage),
                    Icons.palette,
                  ),
                  _buildFeatureItem(
                    AppLocalizations.getString(
                      'method_channel',
                      _currentLanguage,
                    ),
                    Icons.phone_android,
                  ),
                  _buildFeatureItem(
                    AppLocalizations.getString('isolates', _currentLanguage),
                    Icons.sync,
                  ),
                  _buildFeatureItem(
                    AppLocalizations.getString('semantic_ui', _currentLanguage),
                    Icons.accessibility,
                  ),
                  _buildFeatureItem(
                    AppLocalizations.getString('settings', _currentLanguage),
                    Icons.settings,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureItem(String title, IconData icon) {
    return ListTile(
      leading: Icon(icon, color: Theme.of(context).colorScheme.primary),
      title: Text(title),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: () {
        // TODO: Navigate to respective feature demo
      },
    );
  }
}
