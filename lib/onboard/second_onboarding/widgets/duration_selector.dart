import 'package:flutter/material.dart';
import '../../../utils/app_strings.dart';

class DurationSelector extends StatefulWidget {
  const DurationSelector({super.key});

  @override
  State<DurationSelector> createState() => _DurationSelectorState();
}

class _DurationSelectorState extends State<DurationSelector> {
  int selectedIndex = 0; // 0 for 7-Day Saptah, 1 for 1 Adhyay Daily

  void _onButtonPressed(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: const Color(0xFFF2EDE6),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          // Button 1: 7-Day Saptah
          Expanded(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOut,
              child: _DurationButton(
                heading: AppStrings.sevenDaySaptah,
                subheading: AppStrings.currentDayStart,
                isActive: selectedIndex == 0,
                onPressed: () => _onButtonPressed(0),
              ),
            ),
          ),
          const SizedBox(width: 8),
          // Button 2: 1 Adhyay Daily
          Expanded(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOut,
              child: _DurationButton(
                heading: AppStrings.oneAdhyayDaily,
                subheading: AppStrings.flexiblePace,
                isActive: selectedIndex == 1,
                onPressed: () => _onButtonPressed(1),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DurationButton extends StatelessWidget {
  final String heading;
  final String subheading;
  final bool isActive;
  final VoidCallback onPressed;

  const _DurationButton({
    required this.heading,
    required this.subheading,
    required this.isActive,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(horizontal: 27.5, vertical: 10),
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFFFFFFFF) : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          boxShadow: isActive
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    offset: const Offset(0, 1),
                    blurRadius: 2,
                    spreadRadius: 0,
                  ),
                ]
              : null,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Heading
            Text(
              heading,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
                height: 1.43, // Line height 20 / font size 14 = 1.43
                letterSpacing: 0.28,
                color: isActive
                    ? const Color(0xFF9A4100)
                    : const Color(0xFF574238),
                decoration: TextDecoration.none,
              ),
            ),
            // Subheading
            Text(
              subheading,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 10,
                height: 1.4, // Line height 14 / font size 10 = 1.4
                letterSpacing: 0.5,
                color: isActive
                    ? const Color(0xFF765700)
                    : const Color(0xFF574238),
                decoration: TextDecoration.none,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
