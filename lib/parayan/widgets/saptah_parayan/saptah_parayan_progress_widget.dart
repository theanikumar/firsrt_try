import 'package:flutter/material.dart';

class SaptahParayanProgressWidget extends StatelessWidget {
  final int completedChapters;
  final int totalChapters;
  final int completedDays; // Number of days completed (for progress boxes)
  final String timeListened;
  final String timeLeft;

  const SaptahParayanProgressWidget({
    super.key,
    this.completedChapters = 18,
    this.totalChapters = 51,
    this.completedDays = 2, // 2 days completed, on 3rd day
    this.timeListened = '4h 12m listened',
    this.timeLeft = 'Est. 5h 45m left',
  });

  @override
  Widget build(BuildContext context) {
    final percentage = ((completedChapters / totalChapters) * 100).toInt();

    return Container(
      width: double.infinity, // Fill width
      padding: const EdgeInsets.all(12),
      decoration: const BoxDecoration(
        color: Color(0xFFF8F3EC),
      ),
      child: Column(
        children: [
          Container(
            width: double.infinity, // Fill width
            padding: const EdgeInsets.only(top: 4),
            child: Column(
          children: [
            // 1. Completed info container
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // 1_a. Left - Chapters info
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // i. "18 of 51"
                    Text(
                      '$completedChapters of $totalChapters',
                      style: const TextStyle(
                        fontWeight: FontWeight.w700, // bold
                        fontSize: 18,
                        height: 26 / 18, // line height 26
                        color: Color(0xFF9A4100),
                      ),
                    ),
                    // ii. "Chapters Recited"
                    const Text(
                      'Chapters Recited',
                      style: TextStyle(
                        fontWeight: FontWeight.w400, // regular
                        fontSize: 12,
                        height: 18 / 12, // line height 18
                        color: Color(0xFF574238),
                      ),
                    ),
                  ],
                ),

                // 1_b. Right - Percentage complete
                Text(
                  '$percentage% Complete',
                  style: const TextStyle(
                    fontWeight: FontWeight.w700, // bold
                    fontSize: 12,
                    height: 16 / 12, // line height 16
                    letterSpacing: 0.36,
                    color: Color(0xFF765700),
                  ),
                ),
              ],
            ),

            // 2. Progress bar container
            Container(
              width: double.infinity, // Fill width
              height: 18,
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                children: List.generate(7, (index) {
                  return Expanded(
                    child: Container(
                      margin: EdgeInsets.only(
                        right: index < 6 ? 6 : 0, // Gap 6 between boxes
                      ),
                      child: _buildProgressBox(index),
                    ),
                  );
                }),
              ),
            ),

            // 3. Left container - Time info
            Container(
              width: double.infinity, // Fill width
              padding: const EdgeInsets.only(top: 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Left - Time listened with icon
                  Row(
                    children: [
                      const Icon(
                        Icons.headset,
                        size: 14,
                        color: Color(0xFF8A7267),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        timeListened,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600, // semibold
                          fontSize: 10,
                          height: 14 / 10, // line height 14
                          letterSpacing: 0.5,
                          color: Color(0xFF8A7267),
                        ),
                      ),
                    ],
                  ),

                  // Right - Time left
                  Text(
                    timeLeft,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600, // semibold
                      fontSize: 10,
                      height: 14 / 10, // line height 14
                      letterSpacing: 0.5,
                      color: Color(0xFF8A7267),
                    ),
                  ),
                ],
              ),
            ),
          ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressBox(int index) {
    Color boxColor;
    List<BoxShadow>? boxShadow;

    // Determine color based on progress
    if (index < completedDays) {
      // First 2 boxes - completed (dark orange)
      boxColor = const Color(0xFF9A4100);
    } else if (index == completedDays) {
      // 3rd box - current day (yellow with glow)
      boxColor = const Color(0xFFFEA619);
      boxShadow = [
        BoxShadow(
          color: const Color(0xFFFEA619).withOpacity(0.70), // 70% opacity
          offset: const Offset(0, 0),
          blurRadius: 8,
          spreadRadius: 0,
        ),
      ];
    } else {
      // 4th-7th boxes - not started (light gray)
      boxColor = const Color(0xFFE6E2DB);
    }

    return Container(
      height: 10,
      decoration: BoxDecoration(
        color: boxColor,
        borderRadius: BorderRadius.circular(9999),
        boxShadow: boxShadow,
      ),
    );
  }
}
