import 'package:flutter/material.dart';

class TabItemWidget extends StatelessWidget {
  final TabItemWidgetModel model;
  final bool isSelected;
  final Function(int) didSelect;

  const TabItemWidget({
    super.key,
    required this.model,
    required this.isSelected,
    required this.didSelect,
  });

  @override
  Widget build(BuildContext context) {
    // Enhanced color scheme for tabs
    final selectedColor = Theme.of(context).colorScheme.primary;
    final unselectedColor = Theme.of(
      context,
    ).colorScheme.onSurface.withValues(alpha: 0.5);
    final backgroundColor = isSelected
        ? Theme.of(context).colorScheme.primary.withValues(alpha: 0.1)
        : Colors.transparent;

    return GestureDetector(
      onTap: () {
        didSelect(model.index);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              model.icon,
              color: isSelected ? selectedColor : unselectedColor,
              size: 24,
            ),
            const SizedBox(height: 4),
            Text(
              model.label,
              style: TextStyle(
                color: isSelected ? selectedColor : unselectedColor,
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TabItemWidgetModel {
  final IconData icon;
  final String label;
  final int index;

  const TabItemWidgetModel({
    required this.icon,
    required this.label,
    required this.index,
  });
}
