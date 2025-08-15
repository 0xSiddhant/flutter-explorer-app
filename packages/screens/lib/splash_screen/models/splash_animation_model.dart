import 'package:core/core.dart';
/// Model for splash screen animation data
class SplashAnimationModel {
  final String title;
  final String subtitle;
  final String version;
  final Duration totalDuration;
  final Duration logoAnimationDuration;
  final Duration textAnimationDuration;
  final Duration loadingAnimationDuration;

  const SplashAnimationModel({
    required this.title,
    required this.subtitle,
    required this.version,
    required this.totalDuration,
    required this.logoAnimationDuration,
    required this.textAnimationDuration,
    required this.loadingAnimationDuration,
  });
}

/// Model for app version information
class AppVersionInfo {
  final bool success;
  final String versionName;
  final String versionCode;
  final String packageName;
  final String appName;
  final String? error;

  const AppVersionInfo({
    required this.success,
    required this.versionName,
    required this.versionCode,
    required this.packageName,
    required this.appName,
    this.error,
  });

  factory AppVersionInfo.fromMap(Map<String, dynamic> map) {
    return AppVersionInfo(
      success: map['success'] ?? false,
      versionName: map['versionName'] ?? 'Unknown',
      versionCode: map['versionCode']?.toString() ?? 'Unknown',
      packageName: map['packageName'] ?? 'Unknown',
      appName: map['appName'] ?? 'Unknown',
      error: map['error'],
    );
  }

  String get displayVersion => '$versionName ($versionCode)';
}
