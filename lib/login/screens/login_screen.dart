import 'package:flutter/material.dart';
import '../widgets/login_header.dart';
import '../widgets/login_top.dart';
import '../widgets/phone_otp_card.dart';
import '../widgets/login_info_card.dart';
import '../widgets/login_footer.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F3EC),
      body: SafeArea(
        child: Column(
          children: [
            // Header - Fixed at top
            const LoginHeader(),

            // Main content - Fills remaining space
            Expanded(
              child: SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.height -
                        MediaQuery.of(context).padding.top -
                        80, // Approximate header + footer height
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Top section (image, title, welcome)
                      const LoginTop(),

                      // Middle section (phone OTP and info card)
                      Column(
                        children: [
                          // Phone + OTP sign-in
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: PhoneOtpCard(),
                          ),

                          // Info card
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: LoginInfoCard(),
                          ),
                        ],
                      ),

                      // Spacer to push footer to bottom
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            ),

            // Footer - Fixed at bottom
            LoginFooter(
              onTermsTap: () {
                print('Terms of Seva tapped');
              },
              onPrivacyTap: () {
                print('Privacy Sanctity tapped');
              },
              onHelpTap: () {
                print('Help Desk tapped');
              },
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
