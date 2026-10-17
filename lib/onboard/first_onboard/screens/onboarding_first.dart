import 'package:flutter/material.dart';
import 'top_screen.dart';
import 'bottom_screen.dart';

class OnboardingFirst extends StatelessWidget {
  const OnboardingFirst({super.key});

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
