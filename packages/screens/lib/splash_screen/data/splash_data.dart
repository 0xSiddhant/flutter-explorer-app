import 'package:core/core.dart';
import '../models/splash_animation_model.dart';

/// Data provider for splash screen configuration
class SplashData {
  static const SplashAnimationModel animationData = SplashAnimationModel(
    title: 'Flutter Explorer',
    subtitle: 'Discover Core Features',
    version: 'Version 1.0.0',
    totalDuration: Duration(milliseconds: 3000),
    logoAnimationDuration: Duration(milliseconds: 1500),
    textAnimationDuration: Duration(milliseconds: 1000),
    loadingAnimationDuration: Duration(milliseconds: 2000),
  );

  /// Get app version information via method channel
  static Future<AppVersionInfo> getAppVersionInfo() async {
    try {
      final result = await MethodChannelManager.getAppVersion();
      return AppVersionInfo.fromMap(result);
    } catch (e) {
      return const AppVersionInfo(
        success: false,
        versionName: 'Unknown',
        versionCode: 'Unknown',
        packageName: 'Unknown',
        appName: 'Unknown',
        error: 'Failed to fetch app version',
      );
    }
  }

  /// Get animation data with dynamic version info
  static Future<SplashAnimationModel> getAnimationData() async {
    final versionInfo = await getAppVersionInfo();
    final version = versionInfo.success
        ? 'Version ${versionInfo.displayVersion}'
        : 'Version 1.0.0';

    return SplashAnimationModel(
      title: 'Flutter Explorer',
      subtitle: 'Discover Core Features',
      version: version,
      totalDuration: const Duration(milliseconds: 3000),
      logoAnimationDuration: const Duration(milliseconds: 1500),
      textAnimationDuration: const Duration(milliseconds: 1000),
      loadingAnimationDuration: const Duration(milliseconds: 2000),
    );
  }
}
