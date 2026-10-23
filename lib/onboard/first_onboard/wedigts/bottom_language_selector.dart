import 'package:flutter/material.dart';

import '../../../utils/app_strings.dart';
import 'language_option_box.dart';

class BottomLanguageSelector extends StatelessWidget {
  const BottomLanguageSelector({
    super.key,
    required this.selectedLanguage,
    required this.onSelected,
  });

  final String selectedLanguage;
  final ValueChanged<String> onSelected;

  static const List<Map<String, String>> _languages = [
    {
      'code': 'hi',
      'nameLocal': 'हिन्दी',
      'nameEnglish': 'Hindi',
      'badge': 'पूर्ण पाठ',
    },
    {
      'code': 'mr',
      'nameLocal': 'मराठी',
      'nameEnglish': 'Marathi',
      'badge': 'पूर्ण पाठ',
    },
    {
      'code': 'te',
      'nameLocal': 'తెలుగు',
      'nameEnglish': 'Telugu',
      'badge': 'Coming soon',
    },
    {
      'code': 'en',
      'nameLocal': 'English',
      'nameEnglish': 'English',
      'badge': 'Full audio',
    },
    {
      'code': 'gu',
      'nameLocal': 'ગુજરાતી',
      'nameEnglish': 'Gujarati',
      'badge': 'Coming soon',
    },
    {
      'code': 'or',
      'nameLocal': 'ଓଡ଼ିଆ',
      'nameEnglish': 'Odia',
      'badge': 'Coming soon',
    },
  ];

  void _select(String code) {
    AppStrings.setLanguage(code);
    onSelected(code);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 1.8,
        ),
        itemCount: _languages.length,
        itemBuilder: (context, index) {
          final language = _languages[index];
          return LanguageOptionBox(
            languageNameLocal: language['nameLocal']!,
            languageNameEnglish: language['nameEnglish']!,
            audioBadgeText: language['badge']!,
            isSelected: selectedLanguage == language['code'],
            onTap: () => _select(language['code']!),
          );
        },
      ),
    );
  }
}
