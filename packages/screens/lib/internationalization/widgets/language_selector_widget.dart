import 'package:flutter/material.dart';
import 'package:common/common.dart';

/// Widget for selecting languages with RTL support
class LanguageSelectorWidget extends StatelessWidget {
  final String currentLanguage;
  final Function(String) onLanguageChanged;

  const LanguageSelectorWidget({
    super.key,
    required this.currentLanguage,
    required this.onLanguageChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.getString('select_language'),
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: AppLocalizations.supportedLanguages.map((language) {
                return ChoiceChip(
                  label: Text(language.nativeName),
                  selected: currentLanguage == language.code,
                  onSelected: (selected) {
                    if (selected) {
                      onLanguageChanged(language.code);
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
