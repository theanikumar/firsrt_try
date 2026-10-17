import 'package:flutter/material.dart';
import '../../../utils/app_strings.dart';

class ParayanSankalpSetup extends StatelessWidget {
  const ParayanSankalpSetup({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.zero,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Title section
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // a. Icon box
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFDBCB),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        offset: const Offset(0, 1),
                        blurRadius: 2,
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.menu_book,
                    color: Color(0xFF9A4100),
                  ),
                ),
                const SizedBox(width: 10),
                // b. Heading
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Title
                      Text(
                        AppStrings.parayanSankalpSetup,
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
                      // Subtitle
                      Text(
                        AppStrings.selectSacredReadingVow,
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
          const SizedBox(width: 8),
          // 2. Badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: const Color(0xFFFFDDB8),
              borderRadius: BorderRadius.circular(9999),
            ),
            child: Text(
              AppStrings.saptahSankalp,
              style: const TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 10,
                height: 1.4, // Line height 14 / font size 10 = 1.4
                letterSpacing: 0.5,
                color: Color(0xFF2A1700),
                decoration: TextDecoration.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
