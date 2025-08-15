import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'widgets/typography_showcase_widget.dart';

/// Professional typography showcase screen
class TypographyShowcaseScreen extends StatefulWidget {
  const TypographyShowcaseScreen({super.key});

  @override
  State<TypographyShowcaseScreen> createState() =>
      _TypographyShowcaseScreenState();
}

class _TypographyShowcaseScreenState extends State<TypographyShowcaseScreen> {
  String _currentLanguage = AppLocalizations.currentLanguageCode;

  @override
  void initState() {
    super.initState();
    _currentLanguage = AppLocalizations.currentLanguageCode;
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: AppLocalizations.textDirection,
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.getString('typography_showcase')),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildWelcomeSection(),
                const SizedBox(height: 16),
                TypographyShowcaseWidget(currentLanguage: _currentLanguage),
                const SizedBox(height: 16),
                _buildLanguageSelector(),
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
              AppLocalizations.getString('typography_showcase'),
              style: AppLocalizations.getTextStyleForCurrentLanguage(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              AppLocalizations.getString('typography_description'),
              style: AppLocalizations.getTextStyleForCurrentLanguage(
                fontSize: 14,
              ),
            ),
          ],
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
              AppLocalizations.getString('select_language'),
              style: AppLocalizations.getTextStyleForCurrentLanguage(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: AppLocalizations.supportedLanguages.map((language) {
                return ChoiceChip(
                  label: Text(language.nativeName),
                  selected: _currentLanguage == language.code,
                  onSelected: (selected) {
                    if (selected) {
                      setState(() {
                        _currentLanguage = language.code;
                      });
                    }
                  },
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
