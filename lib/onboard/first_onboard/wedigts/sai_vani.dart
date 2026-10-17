import 'package:flutter/material.dart';
import '../../../utils/app_strings.dart';

class SaiVani extends StatelessWidget {
  const SaiVani({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 4),
      alignment: Alignment.center,
      child: Text(
        AppStrings.saiVani,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 22,
          height: 1.36, // Line height 30 / font size 22 = 1.36
          letterSpacing: -0.55,
          color: Color(0xFF1D1C18),
          fontWeight: FontWeight.w400,
          decoration: TextDecoration.none,
        ),
      ),
    );
  }
}
