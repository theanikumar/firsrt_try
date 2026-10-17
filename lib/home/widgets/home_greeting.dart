import 'package:flutter/material.dart';

class HomeGreeting extends StatelessWidget {
  final int dayStreak;
  final String userName;

  const HomeGreeting({
    super.key,
    this.dayStreak = 3,
    this.userName = 'Devotee',
  });

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return 'सुप्रभात'; // Good Morning
    } else if (hour < 17) {
      return 'शुभ अपराह्न'; // Good Afternoon
    } else {
      return 'शुभ संध्या'; // Good Evening
    }
  }

  String _getCurrentDay() {
    final days = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'];
    return days[DateTime.now().weekday % 7];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Greeting widget
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // 1_a First greeting line
                Text(
                  '${_getGreeting()} • ${_getCurrentDay()} Darshan',
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 10,
                    height: 1.4, // Line height 14 / font size 10 = 1.4
                    letterSpacing: 0.5,
                    color: Color(0xFF765700),
                    decoration: TextDecoration.none,
                  ),
                ),
                // 1_b Second greeting line
                Text(
                  'Om Sai Ram, $userName',
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                    height: 1.0, // Line height 20 / font size 20 = 1.0
                    letterSpacing: -0.5,
                    color: Color(0xFF9A4100),
                    decoration: TextDecoration.none,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          // 2. Badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFFFFDDB8).withOpacity(0.5),
              borderRadius: BorderRadius.circular(9999),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  offset: const Offset(0, 1),
                  blurRadius: 2,
                  spreadRadius: 0,
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // 2_a Icon
                const Icon(
                  Icons.spa,
                  color: Color(0xFF9A4100),
                  size: 16,
                ),
                const SizedBox(width: 6),
                // 2_b Text
                Text(
                  'Day $dayStreak Streak',
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 10,
                    height: 1.4, // Line height 14 / font size 10 = 1.4
                    letterSpacing: -0.25,
                    color: Color(0xFF2A1700),
                    decoration: TextDecoration.none,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
