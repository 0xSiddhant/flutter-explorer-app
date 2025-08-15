import 'package:core/core.dart';
/// Model class representing navigation analytics data
class AnalyticsModel {
  final int totalNavigations;
  final int uniqueScreens;
  final String? mostVisitedScreen;
  final Map<String, int> screenVisitCount;
  final List<String> navigationHistory;

  const AnalyticsModel({
    required this.totalNavigations,
    required this.uniqueScreens,
    this.mostVisitedScreen,
    required this.screenVisitCount,
    required this.navigationHistory,
  });

  factory AnalyticsModel.fromMap(Map<String, dynamic> map) {
    return AnalyticsModel(
      totalNavigations: map['totalNavigations'] ?? 0,
      uniqueScreens: map['uniqueScreens'] ?? 0,
      mostVisitedScreen: map['mostVisitedScreen'],
      screenVisitCount: Map<String, int>.from(map['screenVisitCount'] ?? {}),
      navigationHistory: List<String>.from(map['navigationHistory'] ?? []),
    );
  }
}
