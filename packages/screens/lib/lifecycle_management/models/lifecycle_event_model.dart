import 'package:core/core.dart';
/// Model class representing a lifecycle event
class LifecycleEventModel {
  final String event;
  final String description;
  final DateTime timestamp;
  final bool isAppForeground;
  final bool isScreenVisible;

  const LifecycleEventModel({
    required this.event,
    required this.description,
    required this.timestamp,
    required this.isAppForeground,
    required this.isScreenVisible,
  });
}
