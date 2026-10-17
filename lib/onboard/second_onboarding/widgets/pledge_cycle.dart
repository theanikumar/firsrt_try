import 'package:flutter/material.dart';
import '../../../utils/app_strings.dart';

class PledgeCycle extends StatelessWidget {
  const PledgeCycle({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(12),
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // 1. Left - Image
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                'assets/image/onboarding/diya.png',
                width: 56,
                height: 56,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 12),
            // 2. Right - Text content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                // Sub heading
                Text(
                  AppStrings.pledgeCycle,
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 10,
                    height: 1.4, // Line height 14 / font size 10 = 1.4
                    letterSpacing: 0.5,
                    color: Color(0xFF765700),
                    decoration: TextDecoration.none,
                  ),
                ),
                // Heading
                Text(
                  AppStrings.pledgeCycleDates,
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    height: 1.5, // Line height 24 / font size 16 = 1.5
                    letterSpacing: 0,
                    color: Color(0xFF1D1C18),
                    decoration: TextDecoration.none,
                  ),
                ),
                // Text line
                Text(
                  AppStrings.pledgeCycleDescription,
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    height: 1.5, // Line height 18 / font size 12 = 1.5
                    letterSpacing: 0,
                    color: Color(0xFF574238),
                    decoration: TextDecoration.none,
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
