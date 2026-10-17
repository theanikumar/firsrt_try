import 'package:flutter/material.dart';
import 'dart:ui';

class LoginHeader extends StatelessWidget {
  final String greetingText;

  const LoginHeader({
    super.key,
    this.greetingText = '|| ॐ श्री साईं नाथाय नमः ||',
  });

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: const Color(0xFFFEF9F2),
            border: Border.all(
              color: const Color(0xFFF2EDE6),
              width: 1,
            ),
          ),
          child: Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFFF8F3EC),
                borderRadius: BorderRadius.circular(9999),
                border: Border.all(
                  color: const Color(0xFFDDC1B3).withOpacity(0.30), // 30% opacity
                  width: 1,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // 1. Left icon (sun)
                  const Icon(
                    Icons.wb_sunny,
                    color: Color(0xFF855300),
                    size: 16,
                  ),

                  const SizedBox(width: 6),

                  // 2. Text
                  Text(
                    greetingText,
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      fontWeight: FontWeight.w400, // regular
                      fontSize: 12,
                      height: 18 / 12, // line height 18
                      letterSpacing: 0.3,
                      color: Color(0xFF855300),
                    ),
                  ),

                  const SizedBox(width: 6),

                  // 3. Right icon (sun)
                  const Icon(
                    Icons.wb_sunny,
                    color: Color(0xFF855300),
                    size: 16,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
