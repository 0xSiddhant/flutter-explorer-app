import 'package:core/core.dart';
import 'package:flutter/material.dart';

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
          AppLocalizations.getString('semantic_form'),
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        Semantics(
          label: AppLocalizations.getString('contact_form'),
          child: Column(
            children: [
              Semantics(
                label: AppLocalizations.getString('name_input_field'),
                textField: true,
                child: TextField(
                  decoration: InputDecoration(
                    labelText: AppLocalizations.getString('name'),
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
                label: AppLocalizations.getString('email_input_field'),
                textField: true,
                child: TextField(
                  decoration: InputDecoration(
                    labelText: AppLocalizations.getString('email'),
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
