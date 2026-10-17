import 'package:flutter/material.dart';

class SevakSankalp extends StatelessWidget {
  final String title;
  final String message;

  const SevakSankalp({
    super.key,
    this.title = 'हमारा संकल्प • Sai Seva',
    this.message = 'Built as a seva for Sri Sai Baba\'s global parivar. Sai Vani is free, sacred, and maintained with love. We warmly welcome your thoughts, collaborations, and heartfelt blessings.',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, // Fill width
      padding: const EdgeInsets.only(top: 20),
      child: Container(
        width: double.infinity, // Fill width
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            transform: const GradientRotation(70 * 3.14159 / 180), // 70 degrees in radians
            stops: const [0.0, 0.5, 1.0],
            colors: const [
              Color(0x4DFFDDB8), // FFDDB8 with 30% opacity
              Color(0xFFF8F3EC), // F8F3EC with 100% opacity
              Color(0x33FFDBCB), // FFDBCB with 20% opacity
            ],
          ),
          borderRadius: BorderRadius.circular(12),
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Icon container
            _buildIconContainer(),

            const SizedBox(width: 12), // Gap 12

            // 2. Text container
            Expanded(
              child: _buildTextContainer(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIconContainer() {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: const Color(0xFF9A4100).withOpacity(0.10), // 10% opacity
        borderRadius: BorderRadius.circular(9999),
      ),
      child: const Icon(
        Icons.volunteer_activism, // Hand with heart
        color: Color(0xFF9A4100),
        size: 24,
      ),
    );
  }

  Widget _buildTextContainer() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // a. Title
        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontWeight: FontWeight.w700, // bold
            fontSize: 22,
            height: 24 / 16, // line height 24
            letterSpacing: -0.32,
            color: Color(0xFF9A4100),
          ),
        ),

        // b. Message
        Container(
          padding: const EdgeInsets.only(top: 4),
          child: Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.w400, // regular
              fontSize: 12,
              height: 20 / 12, // line height 20
              letterSpacing: 0,
              color: Color(0xFF574238),
            ),
          ),
        ),
      ],
    );
  }
}
