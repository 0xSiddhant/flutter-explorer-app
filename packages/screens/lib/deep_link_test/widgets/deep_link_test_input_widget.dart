import 'package:core/core.dart';
import 'package:flutter/material.dart';

/// Widget for testing deep links with input field
class DeepLinkTestInputWidget extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onTest;
  final String lastTestedLink;

  const DeepLinkTestInputWidget({
    super.key,
    required this.controller,
    required this.onTest,
    required this.lastTestedLink,
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
              AppLocalizations.getString('test_deep_links'),
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: controller,
              decoration: InputDecoration(
                labelText: AppLocalizations.getString('deep_link_url'),
                hintText: AppLocalizations.getString('deep_link_url_hint'),
                border: const OutlineInputBorder(),
                prefixIcon: const Icon(Icons.link),
              ),
            ),
            const SizedBox(height: 16.0),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: onTest,
                icon: const Icon(Icons.play_arrow),
                label: Text(AppLocalizations.getString('test_deep_link')),
              ),
            ),
            if (lastTestedLink.isNotEmpty) ...[
              const SizedBox(height: 16.0),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.getString('last_tested_deep_link'),
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      lastTestedLink,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                        fontFamily: 'monospace',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
