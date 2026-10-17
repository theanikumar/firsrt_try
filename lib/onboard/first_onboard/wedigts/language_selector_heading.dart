import 'package:flutter/material.dart';
import '../../../utils/app_strings.dart';

class LanguageSelectorHeading extends StatelessWidget {
  const LanguageSelectorHeading({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      alignment: Alignment.center,
      padding: EdgeInsets.zero,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Heading with icon and text
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Language icon
              Icon(
                Icons.translate,
                color: const Color(0xFF9A4100),
              ),
              const SizedBox(width: 8),
              // Text
              Text(
                AppStrings.chooseSacredLanguage,
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
            ],
          ),
          // Hindi Badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: const Color(0xFFECE6E1),
              borderRadius: BorderRadius.circular(9999),
            ),
            child: Text(
              AppStrings.languageBadge,
              textAlign: TextAlign.left,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 10,
                height: 1.4, // Line height 14 / font size 10 = 1.4
                letterSpacing: 0.5,
                color: Color(0xFF574238),
                decoration: TextDecoration.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
