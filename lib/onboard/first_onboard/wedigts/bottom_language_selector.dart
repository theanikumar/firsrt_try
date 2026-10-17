import 'package:flutter/material.dart';
import 'language_option_box.dart';
import '../../../utils/app_strings.dart';

class BottomLanguageSelector extends StatefulWidget {
  const BottomLanguageSelector({super.key});

  @override
  State<BottomLanguageSelector> createState() => _BottomLanguageSelectorState();
}

class _BottomLanguageSelectorState extends State<BottomLanguageSelector> {
  String selectedLanguage = 'en';

  final List<Map<String, String>> languages = [
    {
      'code': 'hi',
      'nameLocal': 'हिन्दी',
      'nameEnglish': 'Hindi',
      'audioBadge': 'पूर्ण पाठ',
    },
    {
      'code': 'mr',
      'nameLocal': 'मराठी',
      'nameEnglish': 'Marathi',
      'audioBadge': 'पूर्ण पाठ',
    },
    {
      'code': 'te',
      'nameLocal': 'తెలుగు',
      'nameEnglish': 'Telugu',
      'audioBadge': 'పూర్తి పాఠం',
    },
    {
      'code': 'en',
      'nameLocal': 'English',
      'nameEnglish': 'English',
      'audioBadge': 'Audio',
    },
    {
      'code': 'gu',
      'nameLocal': 'ગુજરાતી',
      'nameEnglish': 'Gujarati',
      'audioBadge': 'સંપૂર્ણ પાઠ',
    },
    {
      'code': 'or',
      'nameLocal': 'ଓଡ଼ିଆ',
      'nameEnglish': 'Odia',
      'audioBadge': 'ସମ୍ପୂର୍ଣ୍ଣ ପାଠ',
    },
  ];

  void _selectLanguage(String languageCode) {
    setState(() {
      selectedLanguage = languageCode;
      AppStrings.setLanguage(languageCode);
    });
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
        itemCount: languages.length,
        itemBuilder: (context, index) {
          final language = languages[index];
          return LanguageOptionBox(
            languageNameLocal: language['nameLocal']!,
            languageNameEnglish: language['nameEnglish']!,
            audioBadgeText: language['audioBadge']!,
            isSelected: selectedLanguage == language['code'],
            onTap: () => _selectLanguage(language['code']!),
          );
        },
      ),
    );
  }
}
