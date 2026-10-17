import 'package:flutter/material.dart';

class LoginFooter extends StatelessWidget {
  final VoidCallback? onTermsTap;
  final VoidCallback? onPrivacyTap;
  final VoidCallback? onHelpTap;

  const LoginFooter({
    super.key,
    this.onTermsTap,
    this.onPrivacyTap,
    this.onHelpTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // i. Left - Terms of Seva
          GestureDetector(
            onTap: onTermsTap,
            child: const Text(
              'Terms of Seva',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w600, // semibold
                fontSize: 10,
                height: 14 / 10, // line height 14
                letterSpacing: 0.5,
                color: Color(0xFF8A7267),
                decoration: TextDecoration.underline,
              ),
            ),
          ),

          const SizedBox(width: 12),

          // ii. Dot
          Container(
            width: 4,
            height: 4,
            decoration: BoxDecoration(
              color: const Color(0xFFDDC1B3),
              borderRadius: BorderRadius.circular(9999),
            ),
          ),

          const SizedBox(width: 12),

          // iii. Middle - Privacy Sanctity
          GestureDetector(
            onTap: onPrivacyTap,
            child: const Text(
              'Privacy Sanctity',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w600, // semibold
                fontSize: 10,
                height: 14 / 10, // line height 14
                letterSpacing: 0.5,
                color: Color(0xFF8A7267),
                decoration: TextDecoration.underline,
              ),
            ),
          ),

          const SizedBox(width: 12),

          // iv. Dot
          Container(
            width: 4,
            height: 4,
            decoration: BoxDecoration(
              color: const Color(0xFFDDC1B3),
              borderRadius: BorderRadius.circular(9999),
            ),
          ),

          const SizedBox(width: 12),

          // v. Right - Help Desk
          GestureDetector(
            onTap: onHelpTap,
            child: const Text(
              'Help Desk',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w600, // semibold
                fontSize: 10,
                height: 14 / 10, // line height 14
                letterSpacing: 0.5,
                color: Color(0xFF8A7267),
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
