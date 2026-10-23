import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/auth/auth_provider.dart';
import '../../core/bootstrap/bootstrap_provider.dart';
import '../../routes/app_routes.dart';
import '../widgets/splash_greeting.dart';
import '../widgets/splash_loading.dart';
import '../widgets/splash_main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _prepare();
  }

  Future<void> _prepare() async {
    final auth = context.read<AuthProvider>();
    final bootstrap = context.read<BootstrapProvider>();
    final started = DateTime.now();

    try {
      await Future.wait([
        auth.ensureInitialized(),
        bootstrap.ensureLoaded(),
      ]);
    } catch (_) {
      // A failed bootstrap must never trap the devotee on the splash screen.
    }

    // Keep the brand moment brief even when the network answers instantly.
    const minimum = Duration(milliseconds: 1200);
    final elapsed = DateTime.now().difference(started);
    if (elapsed < minimum) {
      await Future.delayed(minimum - elapsed);
    }
    if (!mounted) return;

    final route = !auth.isAuthenticated
        ? AppRoutes.login
        : (auth.needsOnboarding
            ? AppRoutes.onboardingFirst
            : AppRoutes.home);
    Navigator.of(context).pushReplacementNamed(route);
  }

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
            Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    SplashGreeting(),
                    SplashMain(),
                    SplashLoading(),
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
