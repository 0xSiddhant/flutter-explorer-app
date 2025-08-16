import 'package:flutter/material.dart';
import 'package:common/common.dart';

/// Widget for semantic button example
class SemanticButtonWidget extends StatelessWidget {
  final Function(String) onActionPerformed;

  const SemanticButtonWidget({super.key, required this.onActionPerformed});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.getString('semantic_button'),
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        Semantics(
          label: AppLocalizations.getString('primary_action_button'),
          hint: AppLocalizations.getString('double_tap_to_perform_action'),
          button: true,
          child: ElevatedButton(
            onPressed: () {
              onActionPerformed('Primary button pressed');
            },
            child: Text(AppLocalizations.getString('primary_action')),
          ),
        ),
      ],
    );
  }
}
