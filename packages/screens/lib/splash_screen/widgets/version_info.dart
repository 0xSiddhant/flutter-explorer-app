import 'package:flutter/material.dart';
import '../data/splash_data.dart';
import '../models/splash_animation_model.dart';

/// Widget for displaying version information
class VersionInfo extends StatelessWidget {
  const VersionInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<AppVersionInfo>(
      future: SplashData.getAppVersionInfo(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text(
            'Loading...',
            style: TextStyle(color: Colors.white, fontSize: 12),
          );
        }

        if (snapshot.hasError || !snapshot.hasData || !snapshot.data!.success) {
          return const Text(
            'Version 1.0.0',
            style: TextStyle(color: Colors.white, fontSize: 12),
          );
        }

        final versionInfo = snapshot.data!;
        return Column(
          children: [
            Text(
              'Version ${versionInfo.displayVersion}',
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.6),
                fontSize: 12,
                shadows: [
                  Shadow(
                    color: Colors.black.withValues(alpha: 0.2),
                    offset: const Offset(1, 1),
                    blurRadius: 2,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 4),
            Text(
              versionInfo.appName,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.4),
                fontSize: 10,
                shadows: [
                  Shadow(
                    color: Colors.black.withValues(alpha: 0.2),
                    offset: const Offset(1, 1),
                    blurRadius: 2,
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
