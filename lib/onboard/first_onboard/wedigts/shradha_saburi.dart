import 'package:flutter/material.dart';
import '../../../utils/app_strings.dart';

class ShradhaSaburi extends StatelessWidget {
  const ShradhaSaburi({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: const Color(0xFFFEA619),
        borderRadius: BorderRadius.circular(9999),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            offset: const Offset(0, 1),
            blurRadius: 2,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(
            Icons.local_fire_department,
            color: Colors.white,
            size: 18,
          ),
          const SizedBox(width: 3.99),
          Text(
            AppStrings.shradha,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              height: 1.4, // Line height 14 / font size 10 = 1.4
              letterSpacing: 0.5,
              color: Color(0xFFFFFFFF),
              decoration: TextDecoration.none,
            ),
          ),
          const SizedBox(width: 3.99),
          Container(
            width: 4,
            height: 4,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 3.99),
          Text(
            AppStrings.saburi,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              height: 1.4, // Line height 14 / font size 10 = 1.4
              letterSpacing: 0.5,
              color: Color(0xFFFFFFFF),
              decoration: TextDecoration.none,
            ),
          ),
        ],
      ),
    );
  }
}
