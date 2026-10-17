import 'package:flutter/material.dart';

class SevakGreeting extends StatelessWidget {
  final String subtitle;
  final String title;
  final String message;

  const SevakGreeting({
    super.key,
    this.subtitle = 'श्रद्धा • सबुरी • समर्पित सेवा',
    this.title = 'Meet the Creators & Sevaaks',
    this.message = 'Two dedicated devotees building Sai Vani with Baba\'s grace to bring Sri Sai Satcharitra, live Shirdi aartis, and daily darshan to devotees worldwide',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, // Fill width
      padding: const EdgeInsets.only(top: 12),
      child: Column(
        children: [
          // 1. Subtitle container
          _buildSubtitleContainer(),

          // 2. Title
          _buildTitle(),

          // 3. Message
          _buildMessage(),
        ],
      ),
    );
  }

  Widget _buildSubtitleContainer() {
    return Container(
      padding: const EdgeInsets.only(bottom: 8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        decoration: BoxDecoration(
          color: const Color(0xFFFFDDB8),
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
            // Icon - 3 palette flower
            const Icon(
              Icons.local_florist,
              color: Color(0xFF9A4100),
              size: 14,
            ),

            const SizedBox(width: 12), // Gap 12

            // Text
            Text(
              subtitle,
              style: const TextStyle(
                fontWeight: FontWeight.w600, // semibold
                fontSize: 10,
                height: 14 / 10, // line height 14
                letterSpacing: 0.5,
                color: Color(0xFF855300),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Container(
      padding: const EdgeInsets.only(bottom: 4),
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontWeight: FontWeight.w700, // bold
          fontSize: 22,
          height: 30 / 22, // line height 30
          letterSpacing: -0.55,
          color: Color(0xFF9A4100),
        ),
      ),
    );
  }

  Widget _buildMessage() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9.39),
      child: Text(
        message,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontWeight: FontWeight.w400, // regular
          fontSize: 12,
          height: 19.5 / 12, // line height 19.5
          letterSpacing: 0,
          color: Color(0xFF574238),
        ),
      ),
    );
  }
}
