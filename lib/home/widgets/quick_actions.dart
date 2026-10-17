import 'package:flutter/material.dart';

class QuickActions extends StatelessWidget {
  const QuickActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 1. Title widget
          _buildTitle(),
          const SizedBox(height: 8),

          // 2. Options widget (placeholder)
          _buildOptions(),
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: const [
        // 1_a. Left - Sacred Offerings
        Text(
          'Sacred Offerings',
          textAlign: TextAlign.left,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 18,
            height: 1.44, // Line height 26 / font size 18 = 1.44
            letterSpacing: 0,
            color: Color(0xFF1D1C18),
            decoration: TextDecoration.none,
          ),
        ),
        // 1_b. Right - Quick Access
        Text(
          'Quick Access',
          textAlign: TextAlign.left,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 10,
            height: 1.4, // Line height 14 / font size 10 = 1.4
            letterSpacing: 0.5,
            color: Color(0xFF8A7267),
            decoration: TextDecoration.none,
          ),
        ),
      ],
    );
  }

  Widget _buildOptions() {
    final options = [
      {'name': '108 Namavali', 'icon': Icons.looks_one, 'color': const Color(0xFF9A4100)},
      {'name': '4 Aartis', 'icon': Icons.wb_sunny, 'color': const Color(0xFF855300)},
      {'name': 'Udi & Prasad', 'icon': Icons.volunteer_activism, 'color': const Color(0xFF765700)},
      {'name': 'Sai Leela', 'icon': Icons.auto_awesome, 'color': const Color(0xFFBD5611)},
    ];

    return Row(
      children: options.map((option) {
        return Expanded(
          child: Padding(
            padding: EdgeInsets.only(
              right: option != options.last ? 8 : 0,
            ),
            child: _buildOptionItem(
              name: option['name'] as String,
              icon: option['icon'] as IconData,
              color: option['color'] as Color,
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildOptionItem({
    required String name,
    required IconData icon,
    required Color color,
  }) {
    return GestureDetector(
      onTap: () {
        // Handle option tap
        print('$name tapped');
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Icon container
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: const Color(0xFFFFFFFF),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    offset: const Offset(0, 1),
                    blurRadius: 2,
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: Icon(
                icon,
                color: color,
                size: 28,
              ),
            ),
            const SizedBox(height: 6),
            // Option name
            Text(
              name,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 10,
                height: 1.25, // Line height 12.5 / font size 10 = 1.25
                letterSpacing: 0.5,
                color: Color(0xFF1D1C18),
                decoration: TextDecoration.none,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
