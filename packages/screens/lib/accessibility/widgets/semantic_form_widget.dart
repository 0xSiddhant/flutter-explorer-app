import 'package:flutter/material.dart';
import 'package:common/common.dart';

/// Widget for semantic form example
class SemanticFormWidget extends StatelessWidget {
  final Function(String) onActionPerformed;

  const SemanticFormWidget({super.key, required this.onActionPerformed});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.getString('semantic_form', 'en'),
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        Semantics(
          label: AppLocalizations.getString('contact_form', 'en'),
          child: Column(
            children: [
              Semantics(
                label: AppLocalizations.getString('name_input_field', 'en'),
                textField: true,
                child: TextField(
                  decoration: InputDecoration(
                    labelText: AppLocalizations.getString('name', 'en'),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onChanged: (value) {
                    onActionPerformed('Name field updated: $value');
                  },
                ),
              ),
              const SizedBox(height: 8),
              Semantics(
                label: AppLocalizations.getString('email_input_field', 'en'),
                textField: true,
                child: TextField(
                  decoration: InputDecoration(
                    labelText: AppLocalizations.getString('email', 'en'),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onChanged: (value) {
                    onActionPerformed('Email field updated: $value');
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
