import 'package:flutter/material.dart';
import '../../common/app_header.dart';
import '../../common/bottom_navigation.dart';
import '../widgets/sevak_greeting.dart';
import '../widgets/sevak_sankalp.dart';
import '../widgets/sevak_team.dart';
import '../widgets/sevak_feedback.dart';
import '../widgets/sevak_end_greeting.dart';

class SevakScreen extends StatelessWidget {
  const SevakScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F3EC),
      body: SafeArea(
        child: Column(
          children: [
            // App Header
            AppHeader(
              onBackPressed: () {
                Navigator.of(context).pop();
              },
            ),

            // Main content - Scrollable
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(
                  left: 16,
                  right: 16,
                  bottom: 32,
                ),
                child: Column(
                  children: [
                    // 1. Greeting widget
                    const SevakGreeting(),

                    // 2. Sankalp widget
                    const SevakSankalp(),

                    // 3. Team widget
                    SevakTeam(
                      members: SevakTeamData.members,
                    ),

                    // 4. Feedback widget
                    SevakFeedback(
                      socialChannels: SevakFeedbackData.channels,
                      onSendFeedback: () {
                        // TODO: Implement feedback functionality
                        print('Send Feedback tapped');
                      },
                      onJoinVolunteer: () {
                        // TODO: Implement volunteer functionality
                        print('Join Volunteer tapped');
                      },
                    ),

                    // 5. End Greeting widget
                    const SevakEndGreeting(),
                  ],
                ),
              ),
            ),

            // Bottom Navigation
            BottomNavigation(
              currentIndex: 3, // Sevak is index 3
              onTap: (index) {
                _handleNavigation(context, index);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _handleNavigation(BuildContext context, int index) {
    // Don't navigate if already on the same screen
    if (index == 3) return;

    String? routeName;
    switch (index) {
      case 0:
        routeName = '/parayan';
        break;
      case 1:
        routeName = '/explore';
        break;
      case 2:
        routeName = '/player';
        break;
      case 3:
        routeName = '/sevak';
        break;
      case 4:
        routeName = '/settings';
        break;
    }

    if (routeName != null) {
      Navigator.of(context).pushReplacementNamed(routeName);
    }
  }
}
