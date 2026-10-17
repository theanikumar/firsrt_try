import 'package:flutter/material.dart';
import 'dart:ui';
import '../../../utils/app_strings.dart';

class AllAdhyayInfoCard extends StatelessWidget {
  final int currentRead;
  final int totalReads;
  final String adhyayTitle;
  final int verseNumber;
  final String timeRemaining;
  final int currentTrackProgress; // 0-100
  final int overallProgress; // 0-100
  final VoidCallback? onPlayPressed;

  const AllAdhyayInfoCard({
    super.key,
    this.currentRead = 4,
    this.totalReads = 52,
    this.adhyayTitle = 'Adhyay 15 • Cholkar\'s Sugar',
    this.verseNumber = 48,
    this.timeRemaining = '8 min remaining',
    this.currentTrackProgress = 62,
    this.overallProgress = 27,
    this.onPlayPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, // Fill width
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        width: double.infinity, // Fill width
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.0, 0.5, 1.0],
            colors: [
              Color(0xFFF8F3EC), // 0% - f8f3ec at 100%
              Color(0xFFF2EDE6), // 50% - f2ede6 at 100%
              Color(0xFFFFDDB8), // 100% - ffddb8 at 20%
            ],
          ),
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
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Stack(
            children: [
              // Background circle (30% visible at bottom right)
              Positioned(
                bottom: -90, // Position so only 30% is visible
                right: -90,
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 40, sigmaY: 40),
                  child: Container(
                    width: 128,
                    height: 128,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFDDB8).withOpacity(0.40), // 40% opacity
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),

              // Content
              Column(
                children: [
                  // 1. Top widget
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Left - Details
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Top widget (highlighted & normal)
                            Row(
                              children: [
                                // Highlighted widget
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFFEA619).withOpacity(0.20), // 20% opacity
                                    borderRadius: BorderRadius.circular(9999),
                                  ),
                                  child: Text(
                                    AppStrings.sacredProcess,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600, // semibold
                                      fontSize: 10,
                                      height: 14 / 10, // line height 14
                                      letterSpacing: 0.25,
                                      color: Color(0xFF684000),
                                    ),
                                  ),
                                ),

                                const SizedBox(width: 8),

                                // Normal widget
                                Text(
                                  '$currentRead of $totalReads reads',
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

                            // Middle widget - Title
                            Text(
                              adhyayTitle,
                              style: const TextStyle(
                                fontFamily: 'SF Pro Display', // Display extracondensed
                                fontWeight: FontWeight.w600, // semibold
                                fontSize: 20,
                                height: 28 / 20, // line height 28
                                letterSpacing: -0.5,
                                color: Color(0xFF1D1C18),
                              ),
                            ),

                            const SizedBox(height: 2),

                            // Bottom widget - Resuming info
                            Text(
                              '${AppStrings.resumingAt} ${AppStrings.verse} $verseNumber • $timeRemaining',
                              style: const TextStyle(
                                fontWeight: FontWeight.w400, // regular
                                fontSize: 12,
                                height: 18 / 12, // line height 18
                                letterSpacing: 0,
                                color: Color(0xFF574238),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(width: 12),

                      // Right - Play button
                      GestureDetector(
                        onTap: onPlayPressed,
                        child: Container(
                          width: 48,
                          height: 48,
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

                  const SizedBox(height: 12), // Gap between top and bottom widgets

                  // 2. Bottom widget
                  Column(
                    children: [
                      // Top - Progress text
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Left - Current track progress with blinking dot
                          Row(
                            children: [
                              // Blinking dot
                              Container(
                                width: 6,
                                height: 6,
                                decoration: const BoxDecoration(
                                  color: Color(0xFF765700),
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 6),
                              Text(
                                '${AppStrings.currentTrack}: $currentTrackProgress% ${AppStrings.finished}',
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

                          // Right - Overall progress
                          Text(
                            '$overallProgress% ${AppStrings.overall}',
                            style: const TextStyle(
                              fontWeight: FontWeight.w700, // bold
                              fontSize: 10,
                              height: 14 / 10, // line height 14
                              letterSpacing: 0.5,
                              color: Color(0xFF574238),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 4),

                      // Bottom - Progress bar
                      Stack(
                        children: [
                          // Background
                          Container(
                            width: double.infinity, // Fill width
                            height: 8,
                            decoration: BoxDecoration(
                              color: const Color(0xFFE6E2DB),
                              borderRadius: BorderRadius.circular(9999),
                            ),
                          ),

                          // Progress
                          FractionallySizedBox(
                            widthFactor: overallProgress / 100,
                            child: Container(
                              height: 8,
                              decoration: BoxDecoration(
                                color: const Color(0xFF9A4100),
                                borderRadius: BorderRadius.circular(9999),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
