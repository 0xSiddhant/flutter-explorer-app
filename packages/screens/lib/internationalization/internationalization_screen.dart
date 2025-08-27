import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'data/internationalization_data.dart';
import 'models/formatting_example_model.dart';
import 'widgets/language_selector_widget.dart';
import 'widgets/formatting_examples_widget.dart';
import 'widgets/feature_list_widget.dart';

class InternationalizationScreen extends StatefulWidget {
  const InternationalizationScreen({super.key});

  @override
  State<InternationalizationScreen> createState() =>
      _InternationalizationScreenState();
}

class _InternationalizationScreenState
    extends State<InternationalizationScreen> {
  String _currentLanguage = AppLocalizations.currentLanguageCode;
  FormattingDataModel? _formattingData;
  final String _originalLanguage = AppLocalizations.currentLanguageCode;
  bool _hasHandledParams = false;

  @override
  void initState() {
    super.initState();
    _loadFormattingData();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_hasHandledParams) {
      _handleDeepLinkParams();
      _hasHandledParams = true;
    }
  }

  @override
  void dispose() {
    // Reset to original language when widget is disposed
    if (_currentLanguage != _originalLanguage) {
      AppLocalizations.changeLanguage(_originalLanguage);
    }
    super.dispose();
  }

  void _loadFormattingData() {
    setState(() {
      _formattingData = InternationalizationData.getFormattingData();
    });
  }

  void _handleDeepLinkParams() async {
    // Get query parameters using core package utility
    if (!RouteParamsUtils.hasQueryParameters(context)) return;

    // Handle locale parameter
    final localeParam = RouteParamsUtils.getQueryParameter(context, 'locale');
    if (localeParam != null) {
      // Check if the locale is supported
      final supportedLanguages = AppLocalizations.supportedLanguages;
      final language = supportedLanguages.firstWhere(
        (l) => l.code == localeParam,
        orElse: () => supportedLanguages.first,
      );

      if (language.code == localeParam) {
        // Change app locale for preview purposes
        await AppLocalizations.changeLanguage(localeParam);

        if (mounted) {
          setState(() {
            _currentLanguage = localeParam;
            _formattingData = InternationalizationData.getFormattingData();
          });
        }
        debugPrint('Internationalization: Locale preview set to $localeParam');
      } else {
        debugPrint(
          'Internationalization: Unsupported locale $localeParam, using default',
        );
      }
    }

    // Debug all parameters
    if (mounted) {
      debugPrint(
        'Internationalization: Deep link parameters: ${RouteParamsUtils.getParametersDebugString(context)}',
      );
    }
  }

  void _onLanguageChanged(String languageCode) async {
    // Change the app's locale using AppLocalizations
    await AppLocalizations.changeLanguage(languageCode);

    setState(() {
      _currentLanguage = languageCode;
      _loadFormattingData();
    });
  }

  void _onFeatureTap(String route) {
    // Navigate to the respective feature using app router with push navigation
    switch (route) {
      case '/navigation':
        AppRouteManager.navigateToNavigationAnalytics(context, usePush: true);
        break;
      case '/theming':
        AppRouteManager.navigateToTheming(context, usePush: true);
        break;
      case '/native-communication':
        AppRouteManager.navigateToNativeCommunication(context, usePush: true);
        break;
      case '/background-tasks':
        AppRouteManager.navigateToBackgroundTasks(context, usePush: true);
        break;
      case '/accessibility':
        AppRouteManager.navigateToAccessibility(context, usePush: true);
        break;
      case '/file-management':
        AppRouteManager.navigateToFileManagement(context, usePush: true);
        break;
      default:
        // Show snackbar for unknown routes
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              '${AppLocalizations.getString('navigating_to')} $route',
            ),
            duration: const Duration(seconds: 2),
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: AppLocalizations.textDirection,
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.getString('internationalization')),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                LanguageSelectorWidget(
                  currentLanguage: _currentLanguage,
                  onLanguageChanged: _onLanguageChanged,
                ),
                const SizedBox(height: 16),
                _buildWelcomeSection(),
                const SizedBox(height: 16),
                if (_formattingData != null)
                  FormattingExamplesWidget(
                    currentLanguage: _currentLanguage,
                    examples: _formattingData!.examples,
                  ),
                const SizedBox(height: 16),
                FeatureListWidget(
                  currentLanguage: _currentLanguage,
                  onFeatureTap: _onFeatureTap,
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWelcomeSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              InternationalizationData.getWelcomeMessage(),
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              InternationalizationData.getDescription(),
              style: const TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
