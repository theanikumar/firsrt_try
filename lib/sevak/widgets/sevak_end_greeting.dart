import 'package:flutter/material.dart';

class SevakEndGreeting extends StatelessWidget {
  final String title;
  final String quote;
  final String closing;

  const SevakEndGreeting({
    super.key,
    this.title = 'सबका मालिक एक',
    this.quote = '"Why fear when I am here? Cast all your burdens on Me, and I shall bear them."',
    this.closing = 'ॐ साईं राम • Sri Sachidananda Sadguru Sainath Maharaj Ki Jai',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, // Fill width
      padding: const EdgeInsets.only(top: 20),
      child: Container(
        width: double.infinity, // Fill width
        padding: const EdgeInsets.only(top: 12),
        child: Column(
          children: [
            // 1. Top container
            _buildTopContainer(),

            // 2. Middle container
            _buildMiddleContainer(),

            // 3. Bottom container
            _buildBottomContainer(),
          ],
        ),
      ),
    );
  }

  Widget _buildTopContainer() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // a. Icon container (left)
        const Icon(
          Icons.wb_sunny,
          color: Color(0xFF9A4100),
          size: 20,
        ),

        const SizedBox(width: 8),

        // b. Text container
        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontWeight: FontWeight.w600, // semibold
            fontSize: 22,
            height: 30 / 22, // line height 30
            letterSpacing: 0,
            color: Color(0xFF9A4100),
          ),
        ),

        const SizedBox(width: 8),

        // c. Icon container (right)
        const Icon(
          Icons.wb_sunny,
          color: Color(0xFF9A4100),
          size: 20,
        ),
      ],
    );
  }

  Widget _buildMiddleContainer() {
    return Container(
      padding: const EdgeInsets.only(top: 4),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Text(
          quote,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontWeight: FontWeight.w400, // regular
            fontSize: 12,
            height: 18 / 12, // line height 18
            letterSpacing: 0,
            color: Color(0xFF8A7267),
            fontStyle: FontStyle.italic,
          ),
        ),
      ),
    );
  }

  Widget _buildBottomContainer() {
    return Container(
      padding: const EdgeInsets.only(top: 4),
      child: Container(
        padding: const EdgeInsets.only(top: 4),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // a. Icon (left)
            const Icon(
              Icons.self_improvement, // Namaskaar icon
              color: Color(0xFF765700),
              size: 14,
            ),

            // b. Text (right) with padding left & right
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Text(
                closing,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.w600, // semibold
                  fontSize: 10,
                  height: 14 / 10, // line height 14
                  letterSpacing: 0.5,
                  color: Color(0xFF765700),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
