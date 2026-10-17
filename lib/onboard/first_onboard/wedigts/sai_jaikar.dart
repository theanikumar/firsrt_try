import 'package:flutter/material.dart';
import '../../../utils/app_strings.dart';

class SaiJaikar extends StatelessWidget {
  const SaiJaikar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320,
      padding: const EdgeInsets.only(bottom: 12),
      child: Container(
        width: 320,
        decoration: BoxDecoration(
          color: const Color(0xFFF2EDE6),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              offset: const Offset(0, 1),
              blurRadius: 2,
              spreadRadius: 0,
            ),
          ],
        ),
        padding: const EdgeInsets.only(
          left: 16,
          right: 16,
          top: 6.88,
          bottom: 8,
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            left: 12.23,
            right: 12.23,
            top: 0,
            bottom: 0.63,
          ),
          child: Text(
            AppStrings.saiJaikar,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color(0xFF855300),
              fontWeight: FontWeight.w600,
              fontSize: 10,
              height: 1.38, // Line height 13.8 / font size 10 = 1.38
              letterSpacing: 0.25,
              decoration: TextDecoration.none,
            ),
          ),
        ),
      ),
    );
  }
}
