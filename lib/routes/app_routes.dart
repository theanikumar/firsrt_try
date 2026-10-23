import 'package:flutter/material.dart';
import '../splash/screens/splash_screen.dart';
import '../login/screens/login_screen.dart';
import '../onboard/first_onboard/screens/onboarding_first.dart';
import '../onboard/second_onboarding/screens/onboarding_second.dart';
import '../home/screens/home_screen.dart';
import '../player/screens/player_screen.dart';
import '../parayan/screens/parayan_screen.dart';
import '../explore/screens/explore_screen.dart';
import '../sevak/screens/sevak_screen.dart';
import '../settings/screens/settings_screen.dart';

class AppRoutes {
  // Route names
  static const String splash = '/splash';
  static const String login = '/login';
  static const String onboardingFirst = '/onboarding-first';
  static const String onboardingSecond = '/onboarding-second';
  static const String home = '/home';
  static const String player = '/player';
  static const String parayan = '/parayan';
  static const String explore = '/explore';
  static const String sevak = '/sevak';
  static const String settings = '/settings';

  // Route generator
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final String? routeName = settings.name;

    switch (routeName) {
      case splash:
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
          settings: settings,
        );
      case login:
        return MaterialPageRoute(
          builder: (_) => const LoginScreen(),
          settings: settings,
        );
      case onboardingFirst:
        return MaterialPageRoute(
          builder: (_) => const OnboardingFirst(),
          settings: settings,
        );
      case onboardingSecond:
        return MaterialPageRoute(
          builder: (_) => const OnboardingSecond(),
          settings: settings,
        );
      case home:
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(),
          settings: settings,
        );
      case player:
        return MaterialPageRoute(
          builder: (_) => const PlayerScreen(),
          settings: settings,
        );
      case parayan:
        return MaterialPageRoute(
          builder: (_) => const ParayanScreen(),
          settings: settings,
        );
      case explore:
        return MaterialPageRoute(
          builder: (_) => const ExploreScreen(),
          settings: settings,
        );
      case '/sevak':
        return MaterialPageRoute(
          builder: (_) => const SevakScreen(),
          settings: settings,
        );
      case '/settings':
        return MaterialPageRoute(
          builder: (_) => const SettingsScreen(),
          settings: settings,
        );
      case '/':
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
          settings: settings,
        );
      default:
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
          settings: settings,
        );
    }
  }

  // Navigation helper methods
  static Future<dynamic> navigateToOnboardingFirst(BuildContext context) {
    return Navigator.pushNamed(context, onboardingFirst);
  }

  static Future<dynamic> navigateToOnboardingSecond(BuildContext context) {
    return Navigator.pushNamed(context, onboardingSecond);
  }

  // Replace current screen (no back navigation)
  static Future<dynamic> replaceWithOnboardingSecond(BuildContext context) {
    return Navigator.pushReplacementNamed(context, onboardingSecond);
  }

  static Future<dynamic> navigateToHome(BuildContext context) {
    return Navigator.pushNamed(context, home);
  }

  // Replace current screen with home (no back navigation to onboarding)
  static Future<dynamic> replaceWithHome(BuildContext context) {
    return Navigator.pushReplacementNamed(context, home);
  }

  static Future<dynamic> navigateToPlayer(BuildContext context) {
    return Navigator.pushNamed(context, player);
  }

  static Future<dynamic> navigateToParayan(BuildContext context) {
    return Navigator.pushNamed(context, parayan);
  }

  static Future<dynamic> navigateToExplore(BuildContext context) {
    return Navigator.pushNamed(context, explore);
  }

  static Future<dynamic> navigateToSevak(BuildContext context) {
    return Navigator.pushNamed(context, sevak);
  }

  static Future<dynamic> navigateToSettings(BuildContext context) {
    return Navigator.pushNamed(context, settings);
  }

  // Replace methods for lateral navigation between main tabs
  static Future<dynamic> replaceWithParayan(BuildContext context) {
    return Navigator.pushReplacementNamed(context, parayan);
  }

  static Future<dynamic> replaceWithExplore(BuildContext context) {
    return Navigator.pushReplacementNamed(context, explore);
  }

  static Future<dynamic> replaceWithPlayer(BuildContext context) {
    return Navigator.pushReplacementNamed(context, player);
  }

  static Future<dynamic> replaceWithSevak(BuildContext context) {
    return Navigator.pushReplacementNamed(context, sevak);
  }

  static Future<dynamic> replaceWithSettings(BuildContext context) {
    return Navigator.pushReplacementNamed(context, settings);
  }
}
