import 'package:flutter/material.dart';
import '../../../utils/app_strings.dart';

class DailySaptahSchedule extends StatelessWidget {
  const DailySaptahSchedule({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, // Fill width
      child: Column(
        children: [
          // Section title widget
          _buildSectionTitle(),

          const SizedBox(height: 8), // Gap 8

          // 7 Adhyay list widgets
          _buildAdhyayListWatched(
            day: AppStrings.day1,
            duration: AppStrings.day1Duration,
            adhyays: AppStrings.day1Adhyays,
            summary: AppStrings.day1Summary,
          ),
          const SizedBox(height: 8),

          _buildAdhyayListWatched(
            day: AppStrings.day2,
            duration: AppStrings.day2Duration,
            adhyays: AppStrings.day2Adhyays,
            summary: AppStrings.day2Summary,
          ),
          const SizedBox(height: 8),

          // Watching widget for day 3
          _buildAdhyayListWatching(
            day: AppStrings.day3,
            duration: AppStrings.day3Duration,
            adhyays: AppStrings.day3Adhyays,
            summary: AppStrings.day3Summary,
          ),
          const SizedBox(height: 8),

          // Locked widgets for days 4-7
          _buildAdhyayListLocked(
            day: AppStrings.day4,
            duration: AppStrings.day4Duration,
            adhyays: AppStrings.day4Adhyays,
            summary: AppStrings.day4Summary,
          ),
          const SizedBox(height: 8),

          _buildAdhyayListLocked(
            day: AppStrings.day5,
            duration: AppStrings.day5Duration,
            adhyays: AppStrings.day5Adhyays,
            summary: AppStrings.day5Summary,
          ),
          const SizedBox(height: 8),

          _buildAdhyayListLocked(
            day: AppStrings.day6,
            duration: AppStrings.day6Duration,
            adhyays: AppStrings.day6Adhyays,
            summary: AppStrings.day6Summary,
          ),
          const SizedBox(height: 8),

          _buildAdhyayListLocked(
            day: AppStrings.day7,
            duration: AppStrings.day7Duration,
            adhyays: AppStrings.day7Adhyays,
            summary: AppStrings.day7Summary,
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle() {
    return Container(
      width: double.infinity, // Fill width
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Left text widget
          const Text(
            'Daily Saptah Schedule',
            style: TextStyle(
              fontFamily: 'SF Pro Display', // Display extracondensed
              fontWeight: FontWeight.w600, // semibold
              fontSize: 20,
              height: 28 / 20, // line height 28
              letterSpacing: 0,
              color: Color(0xFF1D1C18),
            ),
          ),

          // Right text widget
          const Text(
            'DAYS 3 TO 7',
            style: TextStyle(
              fontWeight: FontWeight.w600, // semibold
              fontSize: 10,
              height: 14 / 10, // line height 14
              letterSpacing: 0.25,
              color: Color(0xFF765700),
            ),
          ),
        ],
      ),
    );
  }

  // Watched adhyay list widget (for completed days)
  Widget _buildAdhyayListWatched({
    required String day,
    required String duration,
    required String adhyays,
    required String summary,
  }) {
    return Container(
      width: double.infinity, // Fill width
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF000000).withOpacity(0.05), // 5% opacity
            offset: const Offset(0, 1),
            blurRadius: 2,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Row(
        children: [
          // 1. Main widget - Icon and Details
          Expanded(
            child: Row(
              children: [
                // Icon widget - Completed checkmark
                Container(
                  width: 40,
                  height: 40,
                  decoration: const BoxDecoration(
                    color: Color(0xFFFFDDB8),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Container(
                      width: 24,
                      height: 24,
                      decoration: const BoxDecoration(
                        color: Color(0xFF9A4100),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.check,
                        color: Color(0xFFFFFFFF),
                        size: 16,
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 12),

                // Details widget
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Day and duration
                      Row(
                        children: [
                          // "DAY" text
                          Text(
                            day,
                            style: const TextStyle(
                              fontWeight: FontWeight.w700, // bold
                              fontSize: 10,
                              height: 14 / 10, // line height 14
                              letterSpacing: 0.5,
                              color: Color(0xFF9A4100),
                            ),
                          ),
                          const SizedBox(width: 4),
                          // Dot separator
                          const Text(
                            '•',
                            style: TextStyle(
                              fontWeight: FontWeight.w600, // semibold
                              fontSize: 10,
                              height: 14 / 10,
                              letterSpacing: 0.5,
                              color: Color(0xFF8A7267),
                            ),
                          ),
                          const SizedBox(width: 4),
                          // Duration
                          Text(
                            duration,
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

                      const SizedBox(height: 2),

                      // Adhyays
                      Text(
                        adhyays,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600, // semibold
                          fontSize: 16,
                          height: 24 / 16, // line height 24
                          letterSpacing: 0,
                          color: Color(0xFF1D1C18),
                        ),
                      ),

                      const SizedBox(height: 2),

                      // Summary
                      Text(
                        summary,
                        style: const TextStyle(
                          fontWeight: FontWeight.w400, // regular
                          fontSize: 12,
                          height: 18 / 12, // line height 18
                          letterSpacing: 0,
                          color: Color(0xFF574238),
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 12),

          // 2. Playback button
          GestureDetector(
            onTap: () {
              // TODO: Handle play again
              print('Play again: $day');
            },
            child: Container(
              width: 36,
              height: 36,
              decoration: const BoxDecoration(
                color: Color(0xFFF2EDE6),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.replay,
                color: Color(0xFF574238),
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Watching adhyay list widget (for current day in progress)
  Widget _buildAdhyayListWatching({
    required String day,
    required String duration,
    required String adhyays,
    required String summary,
  }) {
    return Container(
      width: double.infinity, // Fill width
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF000000).withOpacity(0.10), // 10% opacity
            offset: const Offset(0, 4),
            blurRadius: 6,
            spreadRadius: -1,
          ),
          BoxShadow(
            color: const Color(0xFF000000).withOpacity(0.10), // 10% opacity
            offset: const Offset(0, 2),
            blurRadius: 4,
            spreadRadius: -2,
          ),
        ],
      ),
      child: Stack(
        children: [
          // Left active styling bar (positioned at left edge)
          Positioned(
            left: 0,
            top: 0,
            bottom: 0,
            child: Container(
              width: 6,
              decoration: BoxDecoration(
                color: const Color(0xFFFEA619),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  bottomLeft: Radius.circular(12),
                ),
              ),
            ),
          ),

          // Main content with padding
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                // Detail widget and play icon container
                Row(
                  children: [
                    // 1. Detail widget
                    Expanded(
                      child: Row(
                        children: [
                          // Icon container (music lines)
                          Container(
                            width: 44,
                            height: 44,
                            decoration: const BoxDecoration(
                              color: Color(0xFFFEA619),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.graphic_eq, // Multiple lines icon for music
                              color: Color(0xFF855300),
                              size: 24,
                            ),
                          ),

                          const SizedBox(width: 12),

                          // Right 3 inner widgets
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Top widgets (highlighted & normal)
                                Row(
                                  children: [
                                    // Highlighted widget
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFFEA619),
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: Text(
                                        '${AppStrings.today} • $day',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w700, // bold
                                          fontSize: 10,
                                          height: 14 / 10, // line height 14
                                          letterSpacing: 0.5,
                                          color: Color(0xFF684000),
                                        ),
                                      ),
                                    ),

                                    const SizedBox(width: 8),

                                    // Normal widget
                                    Text(
                                      duration,
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

                                const SizedBox(height: 4),

                                // Middle widget - Adhyays
                                Text(
                                  adhyays,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w700, // bold
                                    fontSize: 18,
                                    height: 26 / 18, // line height 26
                                    letterSpacing: 0,
                                    color: Color(0xFF9A4100),
                                  ),
                                ),

                                const SizedBox(height: 2),

                                // Bottom widget - Summary
                                Text(
                                  summary,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w400, // regular
                                    fontSize: 12,
                                    height: 18 / 12, // line height 18
                                    letterSpacing: 0,
                                    color: Color(0xFF574238),
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(width: 12),

                    // 2. Play icon container (right)
                    GestureDetector(
                      onTap: () {
                        // TODO: Handle play
                        print('Play: $day');
                      },
                      child: Container(
                        width: 44,
                        height: 44,
                        decoration: const BoxDecoration(
                          color: Color(0xFF9A4100),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.play_arrow,
                          color: Color(0xFFFFFFFF),
                          size: 28,
                        ),
                      ),
                    ),
                  ],
                ),

                // Bottom widget
                Container(
                  width: double.infinity, // Fill width
                  padding: const EdgeInsets.only(left: 4, top: 16),
                  child: Container(
                    width: double.infinity, // Fill width
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8F3EC),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        // 1. Details widget
                        Expanded(
                          child: Row(
                            children: [
                              // Icon (mic)
                              const Icon(
                                Icons.mic,
                                color: Color(0xFFFEA619),
                                size: 20,
                              ),
                              const SizedBox(width: 8),

                              // Details text
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // "Chapter 15 Playing Now"
                                    Text(
                                      'Chapter 15  ${AppStrings.playingNow}',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w600, // semibold
                                        fontSize: 12,
                                        height: 16 / 12, // line height 16
                                        letterSpacing: 0.36,
                                        color: Color(0xFF1D1C18),
                                      ),
                                    ),
                                    const SizedBox(height: 2),

                                    // "08:24 elapsed • 14:10 remaining"
                                    Text(
                                      '08:24 ${AppStrings.elapsed} • 14:10 ${AppStrings.remaining}',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w600, // semibold
                                        fontSize: 10,
                                        height: 14 / 10, // line height 14
                                        letterSpacing: 0.5,
                                        color: Color(0xFF765700),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(width: 12),

                        // 2. Offline status (downloads are not part of v1)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE6E2DB),
                            borderRadius: BorderRadius.circular(9999),
                          ),
                          child: Text(
                            AppStrings.offline,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 10,
                              height: 14 / 10,
                              letterSpacing: 0.5,
                              color: Color(0xFF1D1C18),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Locked adhyay list widget (for future days)
  Widget _buildAdhyayListLocked({
    required String day,
    required String duration,
    required String adhyays,
    required String summary,
  }) {
    return Opacity(
      opacity: 0.5, // Reduced opacity to indicate locked state
      child: Container(
        width: double.infinity, // Fill width
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xFFFFFFFF),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF000000).withOpacity(0.05), // 5% opacity
              offset: const Offset(0, 1),
              blurRadius: 2,
              spreadRadius: 0,
            ),
          ],
        ),
        child: Row(
          children: [
            // 1. Main widget - Icon and Details
            Expanded(
              child: Row(
                children: [
                  // Icon widget - Lock icon
                  Container(
                    width: 40,
                    height: 40,
                    decoration: const BoxDecoration(
                      color: Color(0xFFFFDDB8),
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.lock,
                        color: Color(0xFF9A4100),
                        size: 20,
                      ),
                    ),
                  ),

                  const SizedBox(width: 12),

                  // Details widget
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Day and duration
                        Row(
                          children: [
                            // "DAY" text
                            Text(
                              day,
                              style: const TextStyle(
                                fontWeight: FontWeight.w700, // bold
                                fontSize: 10,
                                height: 14 / 10, // line height 14
                                letterSpacing: 0.5,
                                color: Color(0xFF9A4100),
                              ),
                            ),
                            const SizedBox(width: 4),
                            // Dot separator
                            const Text(
                              '•',
                              style: TextStyle(
                                fontWeight: FontWeight.w600, // semibold
                                fontSize: 10,
                                height: 14 / 10,
                                letterSpacing: 0.5,
                                color: Color(0xFF8A7267),
                              ),
                            ),
                            const SizedBox(width: 4),
                            // Duration
                            Text(
                              duration,
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

                        const SizedBox(height: 2),

                        // Adhyays
                        Text(
                          adhyays,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600, // semibold
                            fontSize: 16,
                            height: 24 / 16, // line height 24
                            letterSpacing: 0,
                            color: Color(0xFF1D1C18),
                          ),
                        ),

                        const SizedBox(height: 2),

                        // Summary
                        Text(
                          summary,
                          style: const TextStyle(
                            fontWeight: FontWeight.w400, // regular
                            fontSize: 12,
                            height: 18 / 12, // line height 18
                            letterSpacing: 0,
                            color: Color(0xFF574238),
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 12),

            // 2. Lock icon button
            Container(
              width: 36,
              height: 36,
              decoration: const BoxDecoration(
                color: Color(0xFFF2EDE6),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.lock,
                color: Color(0xFF574238),
                size: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
