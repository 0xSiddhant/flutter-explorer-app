import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'widgets/config_viewer_widget.dart';
import 'models/settings_section_model.dart';
import 'data/settings_data.dart';
import 'services/settings_service.dart';
import 'widgets/settings_section_widget.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen>
    with AutomaticKeepAliveClientMixin {
  final ThemeProvider _themeProvider = ThemeProvider.instance;

  @override
  bool get wantKeepAlive => true;
  Map<String, dynamic> _config = {};
  bool _isLoading = true;
  String? _selectedLanguage;
  Map<String, dynamic>? _appInfo;
  List<SettingsSection> _sections = [];
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _initializeSettings();

    // Listen for theme changes to rebuild screen
    _themeProvider.addListener(_onThemeChanged);

    // Listen for config changes to rebuild screen
    ConfigChangeListener.instance.addListener(_onConfigChanged);
  }

  void _onThemeChanged() {
    setState(() {});
  }

  void _onConfigChanged() {
    _loadConfiguration().then((_) {
      _buildSections();
    });
  }

  Future<void> _initializeSettings() async {
    await _loadConfiguration();
    await _loadAppInfo();
    _buildSections();
  }

  Future<void> _loadConfiguration() async {
    try {
      final config = SettingsService.getAllConfig();
      final languageCode =
          config['internationalization']?['defaultLanguage'] ?? 'en';

      setState(() {
        _config = config;
        _selectedLanguage = languageCode;
      });

      debugPrint('Settings screen loaded with language: $languageCode');
    } catch (e) {
      debugPrint('Error loading configuration: $e');
    }
  }

  Future<void> _loadAppInfo() async {
    try {
      final appInfo = await SettingsService.getAppInfo();
      setState(() {
        _appInfo = appInfo;
      });
    } catch (e) {
      debugPrint('Error loading app info: $e');
    }
  }

  void _buildSections() {
    setState(() {
      _sections = SettingsData.getSettingsSections(
        config: _config,
        selectedLanguage: _selectedLanguage ?? 'en',
        appInfo: _appInfo,
        onConfigUpdate: _handleConfigUpdate,
        onLanguageChange: _handleLanguageChange,
        onReloadConfig: _handleReloadConfig,
        onResetConfig: _handleResetConfig,
        onViewConfig: _handleViewConfig,
      );
      _isLoading = false;
    });
  }

  Future<void> _handleConfigUpdate(String key, dynamic value) async {
    try {
      await SettingsService.updateConfig(key, value);
      await _loadConfiguration();
      _buildSections();

      // Update theme provider for theme-related changes
      if (key == 'theme.isDarkMode') {
        _themeProvider.setDarkMode(value as bool);
      } else if (key == 'theme.textScaleFactor') {
        _themeProvider.setTextScaleFactor(value as double);
      }

      // Update accessibility provider for accessibility-related changes
      if (key == 'accessibility.enableScreenReader') {
        await AccessibilityProvider.instance.setScreenReaderEnabled(
          value as bool,
        );
      } else if (key == 'accessibility.enableHighContrast') {
        await AccessibilityProvider.instance.setHighContrastEnabled(
          value as bool,
        );
      } else if (key == 'accessibility.enableLargeText') {
        await AccessibilityProvider.instance.setLargeTextEnabled(value as bool);
      } else if (key == 'accessibility.enableReducedMotion') {
        await AccessibilityProvider.instance.setReducedMotionEnabled(
          value as bool,
        );
      } else if (key == 'accessibility.enableColorBlindSupport') {
        await AccessibilityProvider.instance.setColorBlindSupportEnabled(
          value as bool,
        );
      } else if (key == 'accessibility.enableLargeTouchTargets') {
        await AccessibilityProvider.instance.setLargeTouchTargetsEnabled(
          value as bool,
        );
      } else if (key == 'accessibility.enableHapticFeedback') {
        await AccessibilityProvider.instance.setHapticFeedbackEnabled(
          value as bool,
        );
      } else if (key == 'accessibility.enableSimplifiedUI') {
        await AccessibilityProvider.instance.setSimplifiedUIEnabled(
          value as bool,
        );
      } else if (key == 'accessibility.enableEnhancedFocus') {
        await AccessibilityProvider.instance.setEnhancedFocusEnabled(
          value as bool,
        );
      }
    } catch (e) {
      if (mounted) {
        SettingsService.showErrorMessage(
          context,
          '${AppLocalizations.getString('error_updating_setting')}: $e',
        );
      }
    }
  }

  Future<void> _handleLanguageChange(String languageCode) async {
    try {
      await SettingsService.changeLanguage(languageCode);
      setState(() {
        _selectedLanguage = languageCode;
      });
      _buildSections();

      // The LanguageChangeListener will automatically notify all listeners
      // including HomeScreen and other screens

      if (mounted) {
        SettingsService.showSuccessMessage(
          context,
          '${AppLocalizations.getString('language_changed_to')} ${AppLocalizations.getLanguageByCode(languageCode)?.name ?? languageCode}',
        );
      }
    } catch (e) {
      if (mounted) {
        SettingsService.showErrorMessage(
          context,
          '${AppLocalizations.getString('error_changing_language')}: $e',
        );
      }
    }
  }

  Future<void> _handleReloadConfig() async {
    try {
      await SettingsService.reloadConfiguration();
      await _loadConfiguration();
      _buildSections();

      if (mounted) {
        SettingsService.showSuccessMessage(
          context,
          AppLocalizations.getString('configuration_reloaded_successfully'),
        );
      }
    } catch (e) {
      if (mounted) {
        SettingsService.showErrorMessage(
          context,
          '${AppLocalizations.getString('error_reloading_configuration')}: $e',
        );
      }
    }
  }

  Future<void> _handleResetConfig() async {
    final confirmed = await SettingsService.showResetConfirmationDialog(
      context,
    );

    if (confirmed) {
      try {
        await SettingsService.resetConfiguration();
        await _loadConfiguration();
        _buildSections();

        if (mounted) {
          SettingsService.showSuccessMessage(
            context,
            AppLocalizations.getString('configuration_reset_to_default'),
          );
        }
      } catch (e) {
        if (mounted) {
          SettingsService.showErrorMessage(
            context,
            '${AppLocalizations.getString('error_resetting_configuration')}: $e',
          );
        }
      }
    }
  }

  void _handleViewConfig() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ConfigViewerWidget()),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _themeProvider.removeListener(_onThemeChanged);
    ConfigChangeListener.instance.removeListener(_onConfigChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // Required for AutomaticKeepAliveClientMixin
    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.getString('settings')),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.getString('settings')),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          controller: _scrollController,
          key: const PageStorageKey<String>('settings_screen_scroll'),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: _sections.map((section) {
              return SettingsSectionWidget(section: section);
            }).toList(),
          ),
        ),
      ),
    );
  }
}
