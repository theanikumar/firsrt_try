import 'package:flutter/material.dart';

class ParayanProgress extends StatelessWidget {
  final int currentDay;
  final int totalDays;
  final int completedDays;
  final double progressPercentage;
  final VoidCallback? onResumePressed;

  const ParayanProgress({
    super.key,
    this.currentDay = 3,
    this.totalDays = 7,
    this.completedDays = 2,
    this.progressPercentage = 43.0,
    this.onResumePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            offset: const Offset(0, 1),
            blurRadius: 2,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 1. Section Title
          _buildSectionTitle(),
          const SizedBox(height: 12),

          // 2. Streak
          _buildStreak(),
          const SizedBox(height: 12),

          // 3. Chapter Summary (placeholder for now)
          _buildChapterSummary(),
          const SizedBox(height: 12),

          // 4. Resume Button (placeholder for now)
          _buildResumeButton(),
        ],
      ),
    );
  }

  Widget _buildSectionTitle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 1_a. Left
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Logo container
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: const Color(0xFFFFDBCB),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.menu_book,
                  color: Color(0xFF9A4100),
                  size: 20,
                ),
              ),
              const SizedBox(width: 8),
              // Text container
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Line 1
                    const Text(
                      'Saptah Parayan (सप्ताह पारायण)',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        height: 1.5, // Line height 24 / font size 16 = 1.5
                        letterSpacing: 0,
                        color: Color(0xFF1D1C18),
                        decoration: TextDecoration.none,
                      ),
                    ),
                    // Line 2
                    Text(
                      'Day $currentDay of $totalDays • Thu to Wed Saptah Cycle',
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 10,
                        height: 1.4, // Line height 14 / font size 10 = 1.4
                        letterSpacing: 0.5,
                        color: Color(0xFF765700),
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        // 1_b. Right - Badge
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          decoration: BoxDecoration(
            color: const Color(0xFFFFDBCB),
            borderRadius: BorderRadius.circular(9999),
          ),
          child: Text(
            '${progressPercentage.toInt()}%',
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 12,
              height: 1.33, // Line height 16 / font size 12 = 1.33
              letterSpacing: 0.36,
              color: Color(0xFF9A4100),
              decoration: TextDecoration.none,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStreak() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(totalDays, (index) {
          final day = index + 1;
          final isPassed = day < currentDay;
          final isActive = day == currentDay;
          final showLine = day < totalDays;

          return Expanded(
            child: Row(
              children: [
                // Circle
                Expanded(
                  child: Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: isPassed
                          ? const Color(0xFF956E00)
                          : isActive
                              ? const Color(0xFF9A4100)
                              : const Color(0xFFECE7E1),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: isPassed
                          ? const Icon(
                              Icons.check,
                              color: Color(0xFFFFFBFF),
                              size: 16,
                            )
                          : Text(
                              '$day',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 10,
                                height: 1.4,
                                letterSpacing: 0.5,
                                color: isActive
                                    ? const Color(0xFFFFFFFF)
                                    : const Color(0xFF574238),
                                decoration: TextDecoration.none,
                              ),
                            ),
                    ),
                  ),
                ),
                // Connecting line
                if (showLine)
                  Expanded(
                    flex: 0,
                    child: Container(
                      width: 16,
                      height: 2,
                      color: day <= currentDay
                          ? const Color(0xFF9A4100)
                          : const Color(0xFFECE7E1),
                    ),
                  ),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _buildChapterSummary() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F3EC),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 1. Chapter
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // 1_a. Left - Icon and text
              Expanded(
                child: Row(
                  children: [
                    // Headphone icon
                    const Icon(
                      Icons.headphones,
                      color: Color(0xFF855300),
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    // Text
                    const Expanded(
                      child: Text(
                        'Chapter 15 to 21',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          height: 1.33, // Line height 24 / font size 18 = 1.33
                          letterSpacing: 0,
                          color: Color(0xFF1D1C18),
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // 1_b. Right - Duration
              const Text(
                '48 mins',
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
          ),
          const SizedBox(height: 8),

          // 2. Summary
          const Text(
            'Tales of sugar vow, Two lizards, and Baba\'s',
            textAlign: TextAlign.left,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 12,
              height: 1.5, // Line height 18 / font size 12 = 1.5
              letterSpacing: 0,
              color: Color(0xFF574238),
              decoration: TextDecoration.none,
            ),
          ),
          const SizedBox(height: 8),

          // 3. Progress
          Container(
            width: double.infinity,
            height: 10,
            padding: const EdgeInsets.only(top: 4),
            child: Stack(
              children: [
                // Background container
                Container(
                  width: double.infinity,
                  height: 8,
                  decoration: BoxDecoration(
                    color: const Color(0xFFECE7E1),
                    borderRadius: BorderRadius.circular(9999),
                  ),
                ),
                // Progress bar
                Container(
                  width: 167.58,
                  height: 6,
                  margin: const EdgeInsets.only(top: 1),
                  decoration: BoxDecoration(
                    color: const Color(0xFF9A4100),
                    borderRadius: BorderRadius.circular(9999),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),

          // 4. Adhaya
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              // 1. Left
              Text(
                'Adhay 15 • 12:40',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 10,
                  height: 1.4, // Line height 14 / font size 10 = 1.4
                  letterSpacing: 0.5,
                  color: Color(0xFF8A7267),
                  decoration: TextDecoration.none,
                ),
              ),
              // 2. Right
              Text(
                '22:15',
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 10,
                  height: 1.4, // Line height 14 / font size 10 = 1.4
                  letterSpacing: 0.5,
                  color: Color(0xFF8A7267),
                  decoration: TextDecoration.none,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildResumeButton() {
    return GestureDetector(
      onTap: () {
        // Handle resume button press
        if (onResumePressed != null) {
          onResumePressed!();
        }
        print('Resume Parayan Audio pressed');
      },
      child: Container(
        width: double.infinity,
        height: 56,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        decoration: BoxDecoration(
          color: const Color(0xFF9A4100),
          borderRadius: BorderRadius.circular(9999),
        ),
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Resume icon
              const Icon(
                Icons.play_circle_fill,
                color: Color(0xFFFFFFFF),
              ),
              const SizedBox(width: 12),
              // Button text
              Flexible(
                child: const Text(
                  'Resume Parayan Audio (Adhyay 15)',
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    height: 1.5, // Line height 24 / font size 16 = 1.5
                    letterSpacing: 0,
                    color: Color(0xFFFFFFFF),
                    decoration: TextDecoration.none,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
