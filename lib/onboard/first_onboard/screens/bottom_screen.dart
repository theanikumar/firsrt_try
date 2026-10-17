import 'package:flutter/material.dart';
import '../wedigts/bottom_widget_container.dart';
import '../wedigts/bottom_middle_inner_container.dart';
import '../wedigts/bottom_inner_container.dart';
import '../wedigts/language_selector_heading.dart';
import '../wedigts/bottom_language_selector.dart';
import '../wedigts/bottom_btm_outer_container.dart';
import '../../../routes/app_routes.dart';

class BottomScreen extends StatelessWidget {
  const BottomScreen({super.key});

  void _onLanguageSelected(BuildContext context) {
    // Navigate to second onboarding screen
    AppRoutes.navigateToOnboardingSecond(context);
  }

  @override
  Widget build(BuildContext context) {
    return BottomWidgetContainer(
      child: BottomMiddleInnerContainer(
        children: [
          // First widget: Language selection section
          BottomInnerContainer(
            children: const [
              LanguageSelectorHeading(),
              BottomLanguageSelector(),
            ],
          ),
          // Second widget: Bottom button section
          BottomBtmOuterContainer(
            onButtonPressed: () => _onLanguageSelected(context),
          ),
        ],
      ),
    );
  }
}
