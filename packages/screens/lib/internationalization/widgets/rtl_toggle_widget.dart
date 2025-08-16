import 'package:core/core.dart';
import 'package:flutter/material.dart';

/// Widget for toggling RTL/LTR direction
class RTLToggleWidget extends StatelessWidget {
  final bool isRTLEnabled;
  final Function(bool) onRTLChanged;

  const RTLToggleWidget({
    super.key,
    required this.isRTLEnabled,
    required this.onRTLChanged,
  });

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
                  isRTLEnabled ? Icons.arrow_back : Icons.arrow_forward,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Text(
                  AppLocalizations.getString('text_direction'),
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              AppLocalizations.getString('rtl_description'),
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Text(
                    isRTLEnabled
                        ? 'RTL (Right-to-Left)'
                        : 'LTR (Left-to-Right)',
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                ),
                Switch(value: isRTLEnabled, onChanged: onRTLChanged),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
