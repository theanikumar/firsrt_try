import 'package:flutter/material.dart';
import '../../../utils/app_strings.dart';

class AartiReminder extends StatefulWidget {
  const AartiReminder({super.key});

  @override
  State<AartiReminder> createState() => _AartiReminderState();
}

class _AartiReminderState extends State<AartiReminder> {
  int selectedCardIndex = 0; // 0 for Morning, 1 for Evening

  final List<Map<String, String>> reminderOptions = [
    {
      'name': 'Morning Kakad',
      'time': '06:30 AM',
      'description': 'Brahma Muhurta',
    },
    {
      'name': 'Evening Dhoop',
      'time': '6:30 PM',
      'description': 'Twilight Peace',
    },
  ];

  void _onCardSelected(int index) {
    setState(() {
      selectedCardIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 4),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 1. Section title widget
          Container(
            width: double.infinity,
            child: Row(
              children: [
                // a. Notification icon
                const Icon(
                  Icons.notifications,
                  color: Color(0xFF855300),
                  size: 20,
                ),
                const SizedBox(width: 6),
                // b. Section title
                Expanded(
                  child: Text(
                    AppStrings.aartiParayanReminder,
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
          const SizedBox(height: 8),
          // 2. Time selection widget
          Row(
            children: [
              // Card 1: Morning Kakad
              Expanded(
                child: _ReminderCard(
                  cardName: reminderOptions[0]['name']!,
                  time: reminderOptions[0]['time']!,
                  description: reminderOptions[0]['description']!,
                  isActive: selectedCardIndex == 0,
                  onTap: () => _onCardSelected(0),
                ),
              ),
              const SizedBox(width: 8),
              // Card 2: Evening Dhoop
              Expanded(
                child: _ReminderCard(
                  cardName: reminderOptions[1]['name']!,
                  time: reminderOptions[1]['time']!,
                  description: reminderOptions[1]['description']!,
                  isActive: selectedCardIndex == 1,
                  onTap: () => _onCardSelected(1),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ReminderCard extends StatelessWidget {
  final String cardName;
  final String time;
  final String description;
  final bool isActive;
  final VoidCallback onTap;

  const _ReminderCard({
    required this.cardName,
    required this.time,
    required this.description,
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
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFFFFDDB8) : const Color(0xFFF2EDE6),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Card name
            Text(
              cardName,
              textAlign: TextAlign.left,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 10,
                height: 1.4, // Line height 14 / font size 10 = 1.4
                letterSpacing: 0.5,
                color: isActive
                    ? const Color(0xFF855300)
                    : const Color(0xFF574238),
                decoration: TextDecoration.none,
              ),
            ),
            // Time
            Text(
              time,
              textAlign: TextAlign.left,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 16,
                height: 1.5, // Line height 24 / font size 16 = 1.5
                letterSpacing: 0,
                color: Color(0xFF1D1C18),
                decoration: TextDecoration.none,
              ),
            ),
            // Description line
            Text(
              description,
              textAlign: TextAlign.left,
              style: const TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 12,
                height: 1.5, // Line height 18 / font size 12 = 1.5
                letterSpacing: 0,
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
