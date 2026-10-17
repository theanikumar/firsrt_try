import 'package:flutter/material.dart';
import '../../first_onboard/screens/top_screen.dart';
import 'bottom_screen.dart';

class OnboardingSecond extends StatelessWidget {
  const OnboardingSecond({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: const [
              TopScreen(),
              BottomScreen(),
            ],
          ),
        ),
      ),
    );
  }
}
