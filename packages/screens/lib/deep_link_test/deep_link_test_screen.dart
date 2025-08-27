import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'data/deep_link_examples_data.dart';
import 'models/deep_link_example_model.dart';
import 'widgets/deep_link_example_widget.dart';
import 'widgets/deep_link_info_widget.dart';
import 'widgets/deep_link_test_input_widget.dart';

/// Test screen for demonstrating deep linking functionality
class DeepLinkTestScreen extends StatefulWidget {
  const DeepLinkTestScreen({super.key});

  @override
  State<DeepLinkTestScreen> createState() => _DeepLinkTestScreenState();
}

class _DeepLinkTestScreenState extends State<DeepLinkTestScreen>
    with AutomaticKeepAliveClientMixin, AppRestorationMixin {
  final TextEditingController _urlController = TextEditingController();
  String _lastDeepLink = '';
  List<DeepLinkExampleModel> _deepLinkExamples = [];
  late ScrollController _scrollController;

  @override
  bool get wantKeepAlive => true;

  @override
  String get restorationKey => 'deep_link_test_screen';

  @override
  void initState() {
    super.initState();
    _urlController.text = 'frouter://home';
    _scrollController = ScrollController();
    _loadDeepLinkExamples();

    // Listen for language changes to update examples
    LanguageChangeListener.instance.addListener(_onLanguageChanged);

    // Listen for config changes to update examples
    ConfigChangeListener.instance.addListener(_onConfigChanged);

    // Setup scroll restoration
    _setupScrollRestoration();
  }

  void _setupScrollRestoration() {
    // Restore scroll position
    restoreScrollPosition(_scrollController);

    // Listen to scroll changes and save position
    listenToScrollChanges(_scrollController);
  }

  void _loadDeepLinkExamples() {
    setState(() {
      _deepLinkExamples = DeepLinkExamplesData.getDeepLinkExamples(
        context,
        _onExampleTap,
      );
    });
  }

  void _onLanguageChanged() {
    _loadDeepLinkExamples();
  }

  void _onConfigChanged() {
    _loadDeepLinkExamples();
  }

  void _onExampleTap(String url) {
    _urlController.text = url;
    // Only update the text field, don't navigate yet
  }

  void _testDeepLink() async {
    final url = _urlController.text.trim();
    if (url.isNotEmpty) {
      setState(() {
        _lastDeepLink = url;
      });
      await AppRouteManager.handleDeepLink(url);
    }
  }

  @override
  void dispose() {
    LanguageChangeListener.instance.removeListener(_onLanguageChanged);
    ConfigChangeListener.instance.removeListener(_onConfigChanged);
    _urlController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // Required for AutomaticKeepAliveClientMixin
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.getString('deep_link_test')),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          controller: _scrollController,
          key: const PageStorageKey<String>('deep_link_test_screen'),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              DeepLinkInfoWidget(onChipTap: _onExampleTap),
              const SizedBox(height: 16.0),
              DeepLinkTestInputWidget(
                controller: _urlController,
                onTest: _testDeepLink,
                lastTestedLink: _lastDeepLink,
              ),
              const SizedBox(height: 16.0),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.list_alt,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          const SizedBox(width: 8.0),
                          Text(
                            AppLocalizations.getString('example_deep_links'),
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ],
                      ),
                      const SizedBox(height: 16.0),
                      Container(
                        constraints: const BoxConstraints(maxHeight: 400),
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: _deepLinkExamples.length,
                          itemBuilder: (context, index) {
                            return DeepLinkExampleWidget(
                              example: _deepLinkExamples[index],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
