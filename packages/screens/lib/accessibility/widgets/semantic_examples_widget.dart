import 'package:flutter/material.dart';
import 'package:common/common.dart';
import 'semantic_button_widget.dart';
import 'semantic_image_widget.dart';
import 'semantic_tab_bar_widget.dart';
import 'semantic_form_widget.dart';
import 'semantic_list_widget.dart';

/// Widget for displaying semantic UI examples
class SemanticExamplesWidget extends StatelessWidget {
  final int selectedTab;
  final Function(int) onTabChanged;
  final Function(String) onActionPerformed;

  const SemanticExamplesWidget({
    super.key,
    required this.selectedTab,
    required this.onTabChanged,
    required this.onActionPerformed,
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
              AppLocalizations.getString('semantic_ui_examples'),
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SemanticButtonWidget(onActionPerformed: onActionPerformed),
                  const SizedBox(height: 16),
                  SemanticImageWidget(),
                  const SizedBox(height: 16),
                  SemanticTabBarWidget(
                    selectedTab: selectedTab,
                    onTabChanged: onTabChanged,
                    onActionPerformed: onActionPerformed,
                  ),
                  const SizedBox(height: 16),
                  SemanticFormWidget(onActionPerformed: onActionPerformed),
                  const SizedBox(height: 16),
                  SemanticListWidget(onActionPerformed: onActionPerformed),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
