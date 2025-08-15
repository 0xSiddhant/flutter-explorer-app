import 'package:core/core.dart';
import 'package:flutter/material.dart';

/// Model representing a formatting example
class FormattingExampleModel {
  final String label;
  final String value;
  final IconData icon;

  const FormattingExampleModel({
    required this.label,
    required this.value,
    required this.icon,
  });
}

/// Model representing formatting data for a language
class FormattingDataModel {
  final String languageCode;
  final DateTime currentTime;
  final double sampleNumber;
  final List<FormattingExampleModel> examples;

  const FormattingDataModel({
    required this.languageCode,
    required this.currentTime,
    required this.sampleNumber,
    required this.examples,
  });

  /// Create formatting data for a specific language
  factory FormattingDataModel.forLanguage(String languageCode) {
    final now = DateTime.now();
    final number = 1234567.89;

    return FormattingDataModel(
      languageCode: languageCode,
      currentTime: now,
      sampleNumber: number,
      examples: [
        FormattingExampleModel(
          label: 'current_time',
          value: AppLocalizations.formatTime(TimeOfDay.fromDateTime(now)),
          icon: Icons.access_time,
        ),
        FormattingExampleModel(
          label: 'date_format',
          value: AppLocalizations.formatDate(now),
          icon: Icons.calendar_today,
        ),
        FormattingExampleModel(
          label: 'number_format',
          value: AppLocalizations.formatNumber(number),
          icon: Icons.numbers,
        ),
        FormattingExampleModel(
          label: 'currency_format',
          value: AppLocalizations.formatCurrency(number),
          icon: Icons.attach_money,
        ),
      ],
    );
  }
}
