import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/auth/auth_provider.dart';
import '../../../core/network/api_exception.dart';
import '../../../routes/app_routes.dart';
import '../../../utils/app_strings.dart';
import '../wedigts/bottom_btm_outer_container.dart';
import '../wedigts/bottom_inner_container.dart';
import '../wedigts/bottom_language_selector.dart';
import '../wedigts/bottom_middle_inner_container.dart';
import '../wedigts/bottom_widget_container.dart';
import '../wedigts/language_selector_heading.dart';

class BottomScreen extends StatefulWidget {
  const BottomScreen({super.key});

  @override
  State<BottomScreen> createState() => _BottomScreenState();
}

class _BottomScreenState extends State<BottomScreen> {
  String _selectedLanguage = 'en';
  bool _initialized = false;
  bool _saving = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_initialized) return;
    _initialized = true;
    final language = context.read<AuthProvider>().language;
    if (language.isNotEmpty) {
      _selectedLanguage = language;
      AppStrings.setLanguage(language);
    }
  }

  Future<void> _continue() async {
    if (_saving) return;
    setState(() => _saving = true);
    try {
      await context.read<AuthProvider>().completeOnboarding(_selectedLanguage);
      if (!mounted) return;
      Navigator.of(context).pushReplacementNamed(AppRoutes.home);
    } on ApiException catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error.message)),
      );
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomWidgetContainer(
      child: BottomMiddleInnerContainer(
        children: [
          BottomInnerContainer(
            children: [
              const LanguageSelectorHeading(),
              BottomLanguageSelector(
                selectedLanguage: _selectedLanguage,
                onSelected: (code) {
                  setState(() => _selectedLanguage = code);
                },
              ),
            ],
          ),
          BottomBtmOuterContainer(onButtonPressed: _continue),
        ],
      ),
    );
  }
}
