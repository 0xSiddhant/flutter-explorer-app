import 'package:flutter/material.dart';
import 'data/feature_cards_data.dart';
import 'widgets/feature_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final featureCards = FeatureCardsData.getFeatureCards(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Core Features Demo'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Explore Flutter Core Features',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 1.1,
                  ),
                  itemCount: featureCards.length,
                  itemBuilder: (context, index) {
                    return FeatureCard(feature: featureCards[index]);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
