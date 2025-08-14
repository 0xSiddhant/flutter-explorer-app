import 'package:flutter/material.dart';
import 'package:common/common.dart';
import '../models/formatting_example_model.dart';

/// Widget for displaying formatting examples
class FormattingExamplesWidget extends StatelessWidget {
  final String currentLanguage;
  final List<FormattingExampleModel> examples;

  const FormattingExamplesWidget({
    super.key,
    required this.currentLanguage,
    required this.examples,
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
              AppLocalizations.getString(
                'formatting_examples',
                currentLanguage,
              ),
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ...examples.map(
              (example) => _buildFormatRow(
                AppLocalizations.getString(example.label, currentLanguage),
                example.value,
                example.icon,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFormatRow(String label, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: Colors.grey[600]),
          const SizedBox(width: 12),
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: const TextStyle(fontFamily: 'monospace', fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }
}
