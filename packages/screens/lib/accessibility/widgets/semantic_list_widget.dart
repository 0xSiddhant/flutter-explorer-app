import 'package:flutter/material.dart';
import 'package:common/common.dart';

/// Widget for semantic list example
class SemanticListWidget extends StatelessWidget {
  final Function(String) onActionPerformed;

  const SemanticListWidget({super.key, required this.onActionPerformed});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.getString('semantic_list', 'en'),
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        Semantics(
          label: AppLocalizations.getString('list_of_items', 'en'),
          child: Column(
            children: [
              _buildSemanticListItem(
                AppLocalizations.getString('first_item', 'en'),
                AppLocalizations.getString('first_item_description', 'en'),
              ),
              _buildSemanticListItem(
                AppLocalizations.getString('second_item', 'en'),
                AppLocalizations.getString('second_item_description', 'en'),
              ),
              _buildSemanticListItem(
                AppLocalizations.getString('third_item', 'en'),
                AppLocalizations.getString('third_item_description', 'en'),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSemanticListItem(String title, String subtitle) {
    return Semantics(
      label: '$title, $subtitle',
      button: true,
      child: ListTile(
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {
          onActionPerformed('$title selected');
        },
      ),
    );
  }
}
