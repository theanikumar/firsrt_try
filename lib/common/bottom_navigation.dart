import 'package:flutter/material.dart';

class BottomNavigation extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNavigation({
    super.key,
    this.currentIndex = -1, // -1 means no active (for home page)
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 80,
      padding: const EdgeInsets.symmetric(horizontal: 4),
      decoration: const BoxDecoration(
        color: Color(0xFFFFFFFF),
        boxShadow: [
          BoxShadow(
            color: Color(0x0D000000),
            offset: Offset(0, -1),
            blurRadius: 4,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavButton(
            index: 0,
            icon: Icons.menu_book,
            label: 'Parayan',
          ),
          _buildNavButton(
            index: 1,
            icon: Icons.explore,
            label: 'Explore',
          ),
          _buildNavButton(
            index: 2,
            icon: Icons.graphic_eq,
            label: 'Player',
          ),
          _buildNavButton(
            index: 3,
            icon: Icons.groups,
            label: 'Shevak',
          ),
          _buildNavButton(
            index: 4,
            icon: Icons.settings,
            label: 'Settings',
          ),
        ],
      ),
    );
  }

  Widget _buildNavButton({
    required int index,
    required IconData icon,
    required String label,
  }) {
    final isActive = currentIndex == index;

    return GestureDetector(
      onTap: () => onTap(index),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon
            Icon(
              icon,
              color: isActive
                  ? const Color(0xFF9A4100)
                  : const Color(0xFF574238),
              size: 24,
            ),
            const SizedBox(height: 4),
            // Label
            Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 10,
                height: 1.4, // Line height 14 / font size 10 = 1.4
                letterSpacing: -0.25,
                color: Color(0xFF574238),
                decoration: TextDecoration.none,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
