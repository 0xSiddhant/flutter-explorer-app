import 'package:flutter/material.dart';
import 'package:core/core.dart';

/// Widget for displaying deep link scheme and allowed links information
class DeepLinkInfoWidget extends StatelessWidget {
  final Function(String) onChipTap;

  const DeepLinkInfoWidget({super.key, required this.onChipTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.info_outline,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 8.0),
                Text(
                  AppLocalizations.getString('deep_link_information'),
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            _buildInfoRow(
              context,
              AppLocalizations.getString('deep_link_scheme'),
              AppRouteManager.getDeepLinkScheme(),
              Icons.link,
            ),
            const SizedBox(height: 12.0),
            Text(
              AppLocalizations.getString('allowed_deep_links'),
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(height: 8.0),
            Container(
              constraints: const BoxConstraints(maxHeight: 120),
              child: SingleChildScrollView(
                child: Wrap(
                  spacing: 8.0,
                  runSpacing: 4.0,
                  children: AppRouteManager.getAllowedDeepLinks()
                      .map(
                        (link) => InkWell(
                          onTap: () => onChipTap('frouter://$link'),
                          borderRadius: BorderRadius.circular(16.0),
                          child: Chip(
                            label: Text(link),
                            backgroundColor: Theme.of(
                              context,
                            ).colorScheme.primaryContainer.withOpacity(0.3),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(
    BuildContext context,
    String label,
    String value,
    IconData icon,
  ) {
    return Row(
      children: [
        Icon(
          icon,
          size: 16.0,
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
        const SizedBox(width: 8.0),
        Text(
          '$label: ',
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
        ),
        Expanded(
          child: Text(
            value,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontFamily: 'monospace',
              color: Theme.of(context).colorScheme.primary,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
