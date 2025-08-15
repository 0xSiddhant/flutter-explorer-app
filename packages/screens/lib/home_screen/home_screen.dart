import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'data/feature_cards_data.dart';
import 'widgets/feature_card.dart';
import 'models/feature_card_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin {
  List<FeatureCardModel> _featureCards = [];
  late ScrollController _scrollController;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _loadFeatureCards();

    // Listen for language changes to update feature cards
    LanguageChangeListener.instance.addListener(_onLanguageChanged);
  }

  void _loadFeatureCards() {
    setState(() {
      _featureCards = FeatureCardsData.getFeatureCards(context);
    });
    debugPrint('Home screen loaded with ${_featureCards.length} feature cards');
  }

  void _onLanguageChanged() {
    _loadFeatureCards();
  }

  @override
  void dispose() {
    LanguageChangeListener.instance.removeListener(_onLanguageChanged);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // Required for AutomaticKeepAliveClientMixin
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.getString('explore_flutter_capabilities'),
          style: Theme.of(
            context,
          ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: GridView.builder(
                  controller: _scrollController,
                  key: const PageStorageKey<String>('home_screen_grid'),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 1.1,
                  ),
                  itemCount: _featureCards.length,
                  itemBuilder: (context, index) {
                    return FeatureCard(feature: _featureCards[index]);
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
