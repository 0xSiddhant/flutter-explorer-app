import 'package:core/core.dart';
import 'package:flutter/material.dart';

/// Widget for semantic tab bar example
class SemanticTabBarWidget extends StatelessWidget {
  final int selectedTab;
  final Function(int) onTabChanged;
  final Function(String) onActionPerformed;

  const SemanticTabBarWidget({
    super.key,
    required this.selectedTab,
    required this.onTabChanged,
    required this.onActionPerformed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.getString('semantic_tab_bar'),
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        Semantics(
          label:
              '${AppLocalizations.getString('tab_navigation')} $selectedTab ${AppLocalizations.getString('tabs')}',
          child: Row(
            children: [
              _buildSemanticTab(
                context,
                AppLocalizations.getString('home'),
                0,
                Icons.home,
              ),
              _buildSemanticTab(
                context,
                AppLocalizations.getString('profile'),
                1,
                Icons.person,
              ),
              _buildSemanticTab(
                context,
                AppLocalizations.getString('settings'),
                2,
                Icons.settings,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSemanticTab(
    BuildContext context,
    String label,
    int index,
    IconData icon,
  ) {
    final isSelected = selectedTab == index;
    return Expanded(
      child: Semantics(
        label: '$label ${AppLocalizations.getString('tab')}',
        selected: isSelected,
        button: true,
        child: GestureDetector(
          onTap: () {
            onTabChanged(index);
            onActionPerformed('$label tab selected');
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: isSelected
                  ? Theme.of(context).colorScheme.primaryContainer
                  : Colors.transparent,
              border: Border(
                bottom: BorderSide(
                  color: isSelected
                      ? Theme.of(context).colorScheme.primary
                      : Colors.transparent,
                  width: 2,
                ),
              ),
            ),
            child: Column(
              children: [
                Icon(
                  icon,
                  color: isSelected
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.onSurfaceVariant,
                ),
                const SizedBox(height: 4),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    color: isSelected
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
