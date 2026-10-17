import 'package:flutter/material.dart';

class LoginInfoCard extends StatelessWidget {
  const LoginInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 24),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: const Color(0xFFF8F3EC),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: const Color(0xFFDDC1B3).withOpacity(0.30), // 30% opacity
            width: 1,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Left - Icon
            Container(
              padding: const EdgeInsets.only(top: 2),
              child: const Icon(
                Icons.verified_user,
                color: Color(0xFF855300),
                size: 20,
              ),
            ),

            const SizedBox(width: 10),

            // Right - Text content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // i. Top - Title
                  const Text(
                    '100% Free, Sacred & Private Seva',
                    style: TextStyle(
                      fontWeight: FontWeight.w600, // semibold
                      fontSize: 12,
                      height: 16 / 12, // line height 16
                      letterSpacing: 0.36,
                      color: Color(0xFF1D1C18),
                    ),
                  ),

                  // ii. Bottom - Description
                  Container(
                    padding: const EdgeInsets.only(top: 2),
                    child: const Text(
                      'Your sacred devotion confidential. We do not track, market, or commercialize your personal prayers and darshan activity',
                      style: TextStyle(
                        fontWeight: FontWeight.w400, // regular
                        fontSize: 12,
                        height: 19.5 / 12, // line height 19.5
                        letterSpacing: 0,
                        color: Color(0xFF574238),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
