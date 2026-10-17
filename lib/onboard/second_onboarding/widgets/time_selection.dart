import 'package:flutter/material.dart';
import '../../../utils/app_strings.dart';

class TimeSelection extends StatefulWidget {
  const TimeSelection({super.key});

  @override
  State<TimeSelection> createState() => _TimeSelectionState();
}

class _TimeSelectionState extends State<TimeSelection> {
  int selectedTime = 35; // Default: 35 minutes (Balanced)

  final List<Map<String, dynamic>> timeOptions = [
    {'duration': 20, 'label': 'Swift'},
    {'duration': 35, 'label': 'Balanced'},
    {'duration': 50, 'label': 'Deep'},
  ];

  void _onTimeSelected(int time) {
    setState(() {
      selectedTime = time;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 1. Section title widget
          _SectionTitle(selectedTime: selectedTime),
          const SizedBox(height: 10),
          // 2. Time selection widget
          Row(
            children: timeOptions.map((option) {
              return Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                    right: option != timeOptions.last ? 8 : 0,
                  ),
                  child: _TimeCard(
                    duration: option['duration'],
                    label: option['label'],
                    isActive: selectedTime == option['duration'],
                    onTap: () => _onTimeSelected(option['duration']),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final int selectedTime;

  const _SectionTitle({required this.selectedTime});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // a. Left - Icon and title
          Expanded(
            child: Row(
              children: [
                // a_1. Stopwatch icon
                const Icon(
                  Icons.timer,
                  color: Color(0xFF855300),
                  size: 20,
                ),
                const SizedBox(width: 8),
                // a_2. Section title
                Expanded(
                  child: Text(
                    AppStrings.dailyAudioParayanTime,
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      height: 1.43, // Line height 20 / font size 14 = 1.43
                      letterSpacing: 0.28,
                      color: Color(0xFF1D1C18),
                      decoration: TextDecoration.none,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          // b. Right - Badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: const Color(0xFFFFDBCB),
              borderRadius: BorderRadius.circular(9999),
            ),
            child: Text(
              '$selectedTime mins/day',
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 10,
                height: 1.4,
                letterSpacing: 0.5,
                color: Color(0xFF2A1700),
                decoration: TextDecoration.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TimeCard extends StatelessWidget {
  final int duration;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _TimeCard({
    required this.duration,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFF9A4100) : const Color(0xFFF2EDE6),
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
            // Duration
            Text(
              '${duration}m',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 10,
                height: 1.4, // Line height 14 / font size 10 = 1.4
                letterSpacing: 0.5,
                color: isActive
                    ? const Color(0xFFFFFFFF)
                    : const Color(0xFF574238),
                decoration: TextDecoration.none,
              ),
            ),
            // Label
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 10,
                height: 1.4, // Line height 14 / font size 10 = 1.4
                letterSpacing: 0.5,
                color: isActive
                    ? const Color(0xFFFFFFFF)
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
