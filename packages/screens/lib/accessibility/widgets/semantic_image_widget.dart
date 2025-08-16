import 'package:core/core.dart';
import 'package:flutter/material.dart';

/// Widget for semantic image example
class SemanticImageWidget extends StatelessWidget {
  const SemanticImageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.getString('semantic_image'),
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        Semantics(
          label: AppLocalizations.getString('flutter_logo_description'),
          image: true,
          child: Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.flutter_dash, size: 60, color: Colors.blue),
          ),
        ),
      ],
    );
  }
}
