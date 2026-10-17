import 'package:flutter/material.dart';
import '../../../utils/app_strings.dart';

class SacredSankalpButton extends StatelessWidget {
  final VoidCallback onPressed;

  const SacredSankalpButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 4),
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Button
          GestureDetector(
            onTap: onPressed,
            child: Container(
              width: double.infinity,
              height: 56,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              decoration: BoxDecoration(
                color: const Color(0xFF9A4100),
                borderRadius: BorderRadius.circular(9999),
              ),
              child: Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Fire icon
                    const Icon(
                      Icons.local_fire_department,
                      color: Color(0xFFFEA619),
                    ),
                    const SizedBox(width: 12),
                    // Button text
                    Flexible(
                      child: Text(
                        AppStrings.takeSacredSankalp,
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          height: 1.5, // Line height 24 / font size 16 = 1.5
                          letterSpacing: 0,
                          color: Color(0xFFFFFFFF),
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          // Text line with verified badge
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Verified badge icon
              Container(
                width: 16,
                height: 16,
                decoration: const BoxDecoration(
                  color: Color(0xFF855300),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 12,
                ),
              ),
              const SizedBox(width: 6),
              // Text line
              Text(
                AppStrings.blessedDevotees,
                textAlign: TextAlign.center,
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
        ],
      ),
    );
  }
}
