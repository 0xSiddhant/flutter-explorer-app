import 'package:flutter_test/flutter_test.dart';

import 'package:common/common.dart';

void main() {
  test('AppLocalizations returns correct translations', () {
    // Test English translation
    expect(
      AppLocalizations.getString('app_title', 'en'),
      'Flutter Core Features Demo',
    );

    // Test Spanish translation
    expect(
      AppLocalizations.getString('app_title', 'es'),
      'Demo de Características Principales de Flutter',
    );

    // Test fallback to English for unknown key
    expect(AppLocalizations.getString('unknown_key', 'es'), 'unknown_key');
  });

  test('AppLocalizations formatting works correctly', () {
    final now = DateTime(2024, 1, 15, 14, 30);

    // Test date formatting
    expect(AppLocalizations.formatDate(now, 'en'), '1/15/2024');

    expect(AppLocalizations.formatDate(now, 'es'), '15/1/2024');

    // Test time formatting
    expect(AppLocalizations.formatTime(now, 'en'), '14:30');

    expect(AppLocalizations.formatTime(now, 'fr'), '14h30');
  });
}
