import 'package:flutter/material.dart';
import 'package:common/common.dart';

/// Professional typography showcase widget for language-specific font rendering
class TypographyShowcaseWidget extends StatefulWidget {
  final String currentLanguage;

  const TypographyShowcaseWidget({super.key, required this.currentLanguage});

  @override
  State<TypographyShowcaseWidget> createState() => _TypographyShowcaseWidgetState();
}

class _TypographyShowcaseWidgetState extends State<TypographyShowcaseWidget> {
  String _selectedFontFamily = '';

  @override
  void initState() {
    super.initState();
    _selectedFontFamily = AppLocalizations.getFontFamilyForLanguage(widget.currentLanguage);
  }

  @override
  void didUpdateWidget(TypographyShowcaseWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.currentLanguage != widget.currentLanguage) {
      setState(() {
        _selectedFontFamily = AppLocalizations.getFontFamilyForLanguage(widget.currentLanguage);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final availableFonts = AppLocalizations.getAvailableFontFamiliesForLanguage(widget.currentLanguage);
    
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.getString('typography_showcase'),
              style: AppLocalizations.getTextStyleForCurrentLanguage(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildFontSelector(availableFonts),
            const SizedBox(height: 16),
            _buildFontExample('English', 'Hello World', 'en'),
            _buildFontExample('Spanish', 'Hola Mundo', 'es'),
            _buildFontExample('French', 'Bonjour le Monde', 'fr'),
            _buildFontExample('German', 'Hallo Welt', 'de'),
            _buildFontExample('Arabic', 'مرحبا بالعالم', 'ar'),
            _buildFontExample('Japanese', 'こんにちは世界', 'ja'),
            const SizedBox(height: 16),
            _buildFontInfo(),
          ],
        ),
      ),
    );
  }

  Widget _buildFontSelector(List<String> availableFonts) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.getString('select_font'),
          style: AppLocalizations.getTextStyleForCurrentLanguage(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: availableFonts.map((fontFamily) {
            return ChoiceChip(
              label: Text(
                fontFamily,
                style: TextStyle(fontFamily: fontFamily),
              ),
              selected: _selectedFontFamily == fontFamily,
              onSelected: (selected) {
                if (selected) {
                  setState(() {
                    _selectedFontFamily = fontFamily;
                  });
                }
              },
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildFontExample(
    String languageName,
    String text,
    String languageCode,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            languageName,
            style: AppLocalizations.getTextStyleForCurrentLanguage(
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            text,
            style: AppLocalizations.getTextStyleForLanguage(
              languageCode,
              fontSize: 16,
              customFontFamily: _selectedFontFamily,
            ),
          ),
          Text(
            'Font: ${AppLocalizations.getFontFamilyForLanguage(languageCode)}',
            style: AppLocalizations.getTextStyleForCurrentLanguage(
              fontSize: 12,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFontInfo() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.getString('font_information'),
            style: AppLocalizations.getTextStyleForCurrentLanguage(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Current Language: ${widget.currentLanguage}',
            style: AppLocalizations.getTextStyleForCurrentLanguage(fontSize: 14),
          ),
          Text(
            'Selected Font: $_selectedFontFamily',
            style: AppLocalizations.getTextStyleForCurrentLanguage(fontSize: 14),
          ),
          Text(
            AppLocalizations.getString('font_support_description'),
            style: AppLocalizations.getTextStyleForCurrentLanguage(fontSize: 14),
          ),
        ],
      ),
    );
  }
}
