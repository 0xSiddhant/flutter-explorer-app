import 'package:core/core.dart';
import 'package:flutter/material.dart';

/// Screen that showcases components based on the selected theme type
class ThemeComponentShowcaseScreen extends StatefulWidget {
  const ThemeComponentShowcaseScreen({super.key});

  @override
  State<ThemeComponentShowcaseScreen> createState() =>
      _ThemeComponentShowcaseScreenState();
}

class _ThemeComponentShowcaseScreenState
    extends State<ThemeComponentShowcaseScreen> {
  String _selectedThemeId = ThemeManager.instance.getValidThemeId(
    ThemeManager.instance.defaultThemeId,
  );
  bool _isDarkMode = false;

  @override
  void initState() {
    super.initState();
    _loadCurrentTheme();
  }

  void _loadCurrentTheme() {
    final themeManager = ThemeManager.instance;
    setState(() {
      _selectedThemeId = ThemeManager.instance.getValidThemeId(
        themeManager.selectedThemeId,
      );
      _isDarkMode = themeManager.isDarkMode;
    });
  }

  void _onThemeChanged(String themeId) {
    setState(() {
      _selectedThemeId = ThemeManager.instance.getValidThemeId(themeId);
    });
  }

  void _onDarkModeChanged(bool isDark) {
    setState(() {
      _isDarkMode = isDark;
    });
  }

  void _applyTheme() {
    // Apply the selected theme to the app
    ThemeManager.instance.setSelectedTheme(_selectedThemeId);
    ThemeManager.instance.setDarkMode(_isDarkMode);

    // Show success message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(AppLocalizations.getString('theme_applied_successfully')),
        backgroundColor: Theme.of(context).colorScheme.primary,
        behavior: SnackBarBehavior.floating,
      ),
    );

    // Navigate back to previous screen
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    // Get theme for preview
    final previewTheme = ThemeManager.instance.getThemeForPreview(
      _selectedThemeId,
      _isDarkMode,
    );

    return Theme(
      data: previewTheme,
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.getString('theme_preview')),
          backgroundColor: previewTheme.colorScheme.inversePrimary,
        ),
        body: SafeArea(
          child: Column(
            children: [
              // Theme selector controls
              _buildThemeControls(previewTheme),

              // Component showcase
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Color palette grid
                      _buildColorGrid(previewTheme),
                      const SizedBox(height: 24),

                      // UI elements showcase
                      _buildUIElements(previewTheme),
                      const SizedBox(height: 24),

                      // Text styles showcase
                      _buildTextStyles(previewTheme),
                      const SizedBox(height: 24),

                      // Card examples
                      _buildCards(previewTheme),
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

  Widget _buildThemeControls(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        border: Border(
          bottom: BorderSide(color: theme.colorScheme.outline.withOpacity(0.2)),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.getString('theme_preview_mode'),
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.primary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            AppLocalizations.getString('theme_preview_description'),
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 16),

          // Theme selection dropdown
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DropdownButtonFormField<String>(
                value: _selectedThemeId,
                decoration: InputDecoration(
                  labelText: AppLocalizations.getString('select_app_theme'),
                  border: const OutlineInputBorder(),
                ),
                items: ThemeManager.instance.getAvailableThemesForUI().map((
                  themeInfo,
                ) {
                  return DropdownMenuItem<String>(
                    value: themeInfo.id,
                    child: Text(
                      AppLocalizations.getString(themeInfo.localizationKey),
                    ),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    _onThemeChanged(newValue);
                  }
                },
              ),
              const SizedBox(height: 16),

              // Dark mode toggle
              Row(
                children: [
                  Text(
                    AppLocalizations.getString('dark_mode'),
                    style: theme.textTheme.bodyMedium,
                  ),
                  const SizedBox(width: 8),
                  Switch(value: _isDarkMode, onChanged: _onDarkModeChanged),
                ],
              ),
              const SizedBox(height: 16),

              // Apply button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _applyTheme,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.colorScheme.primary,
                    foregroundColor: theme.colorScheme.onPrimary,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: Text(
                    AppLocalizations.getString('apply_changes'),
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildColorGrid(ThemeData theme) {
    final colorScheme = theme.colorScheme;
    final colors = [
      {
        'name': 'Primary',
        'color': colorScheme.primary,
        'onColor': colorScheme.onPrimary,
      },
      {
        'name': 'Secondary',
        'color': colorScheme.secondary,
        'onColor': colorScheme.onSecondary,
      },
      {
        'name': 'Tertiary',
        'color': colorScheme.tertiary,
        'onColor': colorScheme.onTertiary,
      },
      {
        'name': 'Surface',
        'color': colorScheme.surface,
        'onColor': colorScheme.onSurface,
      },
      {
        'name': 'Background',
        'color': colorScheme.background,
        'onColor': colorScheme.onBackground,
      },
      {
        'name': 'Error',
        'color': colorScheme.error,
        'onColor': colorScheme.onError,
      },
      {
        'name': 'Outline',
        'color': colorScheme.outline,
        'onColor': colorScheme.onSurface,
      },
      {
        'name': 'Surface Variant',
        'color': colorScheme.surfaceVariant,
        'onColor': colorScheme.onSurfaceVariant,
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Color Palette',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            childAspectRatio: 2.5,
          ),
          itemCount: colors.length,
          itemBuilder: (context, index) {
            final colorInfo = colors[index];
            return Container(
              decoration: BoxDecoration(
                color: colorInfo['color'] as Color,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: theme.colorScheme.outline.withOpacity(0.3),
                ),
              ),
              child: Center(
                child: Text(
                  colorInfo['name'] as String,
                  style: TextStyle(
                    color: colorInfo['onColor'] as Color,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildUIElements(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'UI Elements',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),

        // Buttons
        _buildButtonsSection(theme),
        const SizedBox(height: 16),

        // Form elements
        _buildFormElementsSection(theme),
        const SizedBox(height: 16),

        // Progress indicators
        _buildProgressIndicatorsSection(theme),
      ],
    );
  }

  Widget _buildButtonsSection(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Buttons',
          style: theme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            ElevatedButton(
              onPressed: () {},
              child: Text(AppLocalizations.getString('primary_button')),
            ),
            OutlinedButton(
              onPressed: () {},
              child: Text(AppLocalizations.getString('secondary_button')),
            ),
            TextButton(onPressed: () {}, child: const Text('Text Button')),
            IconButton(onPressed: () {}, icon: const Icon(Icons.favorite)),
            FloatingActionButton(
              onPressed: () {},
              child: const Icon(Icons.add),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildFormElementsSection(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Form Elements',
          style: theme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 16,
          runSpacing: 8,
          children: [
            Switch(value: true, onChanged: (value) {}),
            Checkbox(value: true, onChanged: (value) {}),
            Radio<bool>(value: true, groupValue: true, onChanged: (value) {}),
            Slider(value: 0.5, onChanged: (value) {}),
            SizedBox(width: 100, child: LinearProgressIndicator(value: 0.7)),
          ],
        ),
      ],
    );
  }

  Widget _buildProgressIndicatorsSection(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Progress Indicators',
          style: theme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 16,
          runSpacing: 8,
          children: [
            const CircularProgressIndicator(),
            const LinearProgressIndicator(),
            SizedBox(width: 100, child: LinearProgressIndicator(value: 0.6)),
            SizedBox(
              width: 50,
              height: 50,
              child: CircularProgressIndicator(value: 0.8),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTextStyles(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Text Styles',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),

        // Display styles
        _buildDisplayStyles(theme),
        const SizedBox(height: 16),

        // Headline styles
        _buildHeadlineStyles(theme),
        const SizedBox(height: 16),

        // Title styles
        _buildTitleStyles(theme),
        const SizedBox(height: 16),

        // Body styles
        _buildBodyStyles(theme),
        const SizedBox(height: 16),

        // Label styles
        _buildLabelStyles(theme),
      ],
    );
  }

  Widget _buildDisplayStyles(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Display',
          style: theme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w600,
            color: theme.colorScheme.primary,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Display Large - This is a display large text',
          style: theme.textTheme.displayLarge,
        ),
        Text(
          'Display Medium - This is a display medium text',
          style: theme.textTheme.displayMedium,
        ),
        Text(
          'Display Small - This is a display small text',
          style: theme.textTheme.displaySmall,
        ),
      ],
    );
  }

  Widget _buildHeadlineStyles(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Headlines',
          style: theme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w600,
            color: theme.colorScheme.primary,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Headline Large - This is a headline large text',
          style: theme.textTheme.headlineLarge,
        ),
        Text(
          'Headline Medium - This is a headline medium text',
          style: theme.textTheme.headlineMedium,
        ),
        Text(
          'Headline Small - This is a headline small text',
          style: theme.textTheme.headlineSmall,
        ),
      ],
    );
  }

  Widget _buildTitleStyles(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Titles',
          style: theme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w600,
            color: theme.colorScheme.primary,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Title Large - This is a title large text',
          style: theme.textTheme.titleLarge,
        ),
        Text(
          'Title Medium - This is a title medium text',
          style: theme.textTheme.titleMedium,
        ),
        Text(
          'Title Small - This is a title small text',
          style: theme.textTheme.titleSmall,
        ),
      ],
    );
  }

  Widget _buildBodyStyles(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Body',
          style: theme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w600,
            color: theme.colorScheme.primary,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Body Large - This is a body large text',
          style: theme.textTheme.bodyLarge,
        ),
        Text(
          'Body Medium - This is a body medium text',
          style: theme.textTheme.bodyMedium,
        ),
        Text(
          'Body Small - This is a body small text',
          style: theme.textTheme.bodySmall,
        ),
      ],
    );
  }

  Widget _buildLabelStyles(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Labels',
          style: theme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w600,
            color: theme.colorScheme.primary,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Label Large - This is a label large text',
          style: theme.textTheme.labelLarge,
        ),
        Text(
          'Label Medium - This is a label medium text',
          style: theme.textTheme.labelMedium,
        ),
        Text(
          'Label Small - This is a label small text',
          style: theme.textTheme.labelSmall,
        ),
      ],
    );
  }

  Widget _buildCards(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Cards',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),

        // Basic cards
        _buildBasicCards(theme),
        const SizedBox(height: 16),

        // Elevated cards
        _buildElevatedCards(theme),
        const SizedBox(height: 16),

        // Outlined cards
        _buildOutlinedCards(theme),
      ],
    );
  }

  Widget _buildBasicCards(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Basic Cards',
          style: theme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w600,
            color: theme.colorScheme.primary,
          ),
        ),
        const SizedBox(height: 8),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Basic Card', style: theme.textTheme.titleMedium),
                const SizedBox(height: 8),
                Text(
                  'This is a basic card with default styling. It uses the theme\'s card theme for colors and elevation.',
                  style: theme.textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildElevatedCards(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Elevated Cards',
          style: theme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w600,
            color: theme.colorScheme.primary,
          ),
        ),
        const SizedBox(height: 8),
        Card(
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.star, color: theme.colorScheme.primary),
                    const SizedBox(width: 8),
                    Text('Featured Card', style: theme.textTheme.titleMedium),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  'This is an elevated card with higher elevation and an icon. It stands out more from the background.',
                  style: theme.textTheme.bodyMedium,
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(onPressed: () {}, child: const Text('Action')),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text('Primary Action'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildOutlinedCards(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Outlined Cards',
          style: theme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w600,
            color: theme.colorScheme.primary,
          ),
        ),
        const SizedBox(height: 8),
        Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(color: theme.colorScheme.outline, width: 1),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Outlined Card', style: theme.textTheme.titleMedium),
                const SizedBox(height: 8),
                Text(
                  'This is an outlined card with no elevation and a border. It has a subtle appearance.',
                  style: theme.textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
