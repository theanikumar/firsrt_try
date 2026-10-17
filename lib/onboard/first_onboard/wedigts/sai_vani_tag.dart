import 'package:flutter/material.dart';
import '../../../utils/app_strings.dart';

class SaiVaniTag extends StatelessWidget {
  const SaiVaniTag({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.only(
        left: 7.11,
        right: 7.11,
        top: 0,
        bottom: 0,
      ),
      child: Text(
        AppStrings.saiVaniTag,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 12,
          height: 1.625, // Line height 19.5 / font size 12 = 1.625
          letterSpacing: 0,
          color: Color(0xFF574238),
          decoration: TextDecoration.none,
        ),
      ),
    );
  }
}
