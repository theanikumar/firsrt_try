import 'package:flutter/material.dart';

class ParayanTopTabNavigation extends StatelessWidget {
  final int activeTab; // 0 for Saptah Parayan, 1 for All 51 Adhyays
  final Function(int) onTabChanged;

  const ParayanTopTabNavigation({
    super.key,
    required this.activeTab,
    required this.onTabChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, // Fill width
      padding: const EdgeInsets.only(
        left: 16,
        right: 16,
        top: 12,
        bottom: 4,
      ),
      child: Container(
        width: double.infinity, // Fill width
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: const Color(0xFFF2EDE6), // Fill color
          borderRadius: BorderRadius.circular(9999), // Corner radius 9999
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF000000).withOpacity(0.05), // 5% opacity
              offset: const Offset(0, 1), // x: 0, y: 1
              blurRadius: 2,
              spreadRadius: 0,
            ),
          ],
        ),
        child: Row(
          children: [
            // Option 1: Saptah Parayan (7 Days)
            Expanded(
              child: _buildTabOption(
                icon: Icons.calendar_month,
                text: 'Saptah Parayan (7 Days)',
                isActive: activeTab == 0,
                onTap: () => onTabChanged(0),
              ),
            ),

            // Option 2: All 51 Adhyays
            Expanded(
              child: _buildTabOption(
                icon: Icons.menu_book,
                text: 'All 51 Adhyays',
                isActive: activeTab == 1,
                onTap: () => onTabChanged(1),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabOption({
    required IconData icon,
    required String text,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity, // Fill width
        padding: const EdgeInsets.symmetric(
          horizontal: 0,
          vertical: 8,
        ),
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFF9A4100) : Colors.transparent,
          borderRadius: BorderRadius.circular(9999),
          boxShadow: isActive
              ? [
                  BoxShadow(
                    color: const Color(0xFF9A4100).withOpacity(0.25), // 25% opacity
                    offset: const Offset(0, 2), // x: 0, y: 2
                    blurRadius: 10,
                    spreadRadius: 0,
                  ),
                ]
              : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isActive ? const Color(0xFFFFFFFF) : const Color(0xFF574238),
              size: 16,
            ),
            const SizedBox(width: 6), // Gap 6
            Flexible(
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: isActive ? FontWeight.w700 : FontWeight.w500, // bold : medium
                  fontSize: 12,
                  height: 16 / 12, // line height 16
                  letterSpacing: 0.36,
                  color: isActive ? const Color(0xFFFFFFFF) : const Color(0xFF574238),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
