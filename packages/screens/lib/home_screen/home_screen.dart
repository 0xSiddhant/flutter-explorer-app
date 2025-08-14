import 'package:core/core.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Core Features Demo'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Explore Flutter Core Features',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              LayoutBuilder(
                builder: (context, constraints) {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height * 0.65,
                    child: GridView.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 1.1,
                      children: [
                        _FeatureCard(
                          title: 'Navigation',
                          subtitle: 'Go Router Demo',
                          icon: Icons.navigation,
                          color: Colors.blue,
                          onTap: () =>
                              AppRouteManager.navigateToDetailScreen(context),
                        ),
                        _FeatureCard(
                          title: 'Theme',
                          subtitle: 'Theme Switching',
                          icon: Icons.palette,
                          color: Colors.purple,
                          onTap: () =>
                              AppRouteManager.navigateToThemeDemo(context),
                        ),
                        _FeatureCard(
                          title: 'Method Channel',
                          subtitle: 'Native Communication',
                          icon: Icons.phone_android,
                          color: Colors.green,
                          onTap: () =>
                              AppRouteManager.navigateToMethodChannelDemo(
                                context,
                              ),
                        ),
                        _FeatureCard(
                          title: 'Isolates',
                          subtitle: 'Background Processing',
                          icon: Icons.sync,
                          color: Colors.orange,
                          onTap: () =>
                              AppRouteManager.navigateToIsolateDemo(context),
                        ),
                        _FeatureCard(
                          title: 'Localization',
                          subtitle: 'Multi-language Support',
                          icon: Icons.language,
                          color: Colors.red,
                          onTap: () =>
                              AppRouteManager.navigateToLocalizationDemo(
                                context,
                              ),
                        ),
                        _FeatureCard(
                          title: 'Semantic UI',
                          subtitle: 'Accessibility',
                          icon: Icons.accessibility,
                          color: Colors.teal,
                          onTap: () =>
                              AppRouteManager.navigateToSemanticDemo(context),
                        ),
                        _FeatureCard(
                          title: 'File Storage',
                          subtitle: 'Local File Operations',
                          icon: Icons.folder,
                          color: Colors.indigo,
                          onTap: () =>
                              AppRouteManager.navigateToFileStorageDemo(
                                context,
                              ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FeatureCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _FeatureCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 40, color: color),
              const SizedBox(height: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: TextStyle(fontSize: 10, color: Colors.grey[600]),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
