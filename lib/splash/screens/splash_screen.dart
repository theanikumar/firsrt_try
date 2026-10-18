import 'package:flutter/material.dart';
import '../widgets/splash_greeting.dart';
import '../widgets/splash_main.dart';
import '../widgets/splash_loading.dart';
import '../../routes/app_routes.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F3EC),
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                'assets/image/splash/splash_background.png',
                fit: BoxFit.cover,
              ),
            ),
            // Background image will be added here manually later
            // For now, using solid color background

            // Main content
            Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // 1. Greeting widget
                    const SplashGreeting(),

                    // 2. Main widget (image, title, quote)
                    const SplashMain(),

                    // 3. Loading widget
                    SplashLoading(
                      onLoadingComplete: () {
                        // Navigate to login after loading completes
                        Future.delayed(const Duration(milliseconds: 500), () {
                          Navigator.of(context).pushReplacementNamed(
                            AppRoutes.login,
                          );
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
