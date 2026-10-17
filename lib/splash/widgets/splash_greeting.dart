import 'package:flutter/material.dart';
import 'dart:ui';

class SplashGreeting extends StatelessWidget {
  final String greetingText;

  const SplashGreeting({
    super.key,
    this.greetingText = '|| ॐ श्री साईं नाथाय नमः ||',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, // Fill width
      padding: const EdgeInsets.only(top: 4),
      child: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(9999),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFFECE7E1).withOpacity(0.60), // 60% opacity
                borderRadius: BorderRadius.circular(9999),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF000000).withOpacity(0.05), // 5% opacity
                    offset: const Offset(0, 1),
                    blurRadius: 2,
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // 1. Left logo (sun)
                  const Icon(
                    Icons.wb_sunny,
                    color: Color(0xFF9A4100),
                    size: 16,
                  ),

                  const SizedBox(width: 4),

                  // 2. Text
                  Text(
                    greetingText,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontWeight: FontWeight.w400, // regular
                      fontSize: 12,
                      height: 18 / 12, // line height 18
                      letterSpacing: 1.2,
                      color: Color(0xFF9A4100),
                    ),
                  ),

                  const SizedBox(width: 4),

                  // 3. Right logo (sun)
                  const Icon(
                    Icons.wb_sunny,
                    color: Color(0xFF9A4100),
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
