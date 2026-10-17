import 'package:flutter/material.dart';
import 'dart:ui';

class SaptahParayanInfoCard extends StatefulWidget {
  final String title;
  final String subtitle;
  final String dateRange;
  final String daysLeft;
  final double selectedSpeed;
  final Function(double) onSpeedChanged;

  const SaptahParayanInfoCard({
    super.key,
    this.title = 'Shravan Shukla Parayan',
    this.subtitle = 'Thu 24 Oct - Wed 30 Oct',
    this.daysLeft = '3 days left',
    this.dateRange = 'Thu 24 Oct - Wed 30 Oct',
    this.selectedSpeed = 1.0,
    required this.onSpeedChanged,
  });

  @override
  State<SaptahParayanInfoCard> createState() => _SaptahParayanInfoCardState();
}

class _SaptahParayanInfoCardState extends State<SaptahParayanInfoCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, // Fill width
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F3EC),
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
            // Blurred circle background (25% visible at top right)
            Positioned(
              top: -120, // Position so only 25% is visible
              right: -120,
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 40, sigmaY: 40),
                child: Container(
                  width: 160,
                  height: 160,
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
              // Main info row
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Left widget - Information
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // 1_a. Sacred label with icon
                        Row(
                          children: [
                            // Three stars icon
                            SizedBox(
                              width: 20,
                              height: 14,
                              child: Stack(
                                children: [
                                  // Center star (focused/larger)
                                  const Positioned(
                                    left: 5,
                                    top: 0,
                                    child: Icon(
                                      Icons.star,
                                      size: 10,
                                      color: Color(0xFF855300),
                                    ),
                                  ),
                                  // Top right star
                                  const Positioned(
                                    right: 0,
                                    top: 0,
                                    child: Icon(
                                      Icons.star,
                                      size: 7,
                                      color: Color(0xFF855300),
                                    ),
                                  ),
                                  // Bottom right star
                                  const Positioned(
                                    right: 0,
                                    bottom: 0,
                                    child: Icon(
                                      Icons.star,
                                      size: 7,
                                      color: Color(0xFF855300),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 4),
                            const Text(
                              'SACRED 7-DAY SANKALPA',
                              style: TextStyle(
                                fontWeight: FontWeight.w700, // bold
                                fontSize: 10,
                                height: 14 / 10, // line height 14
                                letterSpacing: 0.5,
                                color: Color(0xFF855300),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 4),

                        // 1_b. Title
                        Text(
                          widget.title,
                          style: const TextStyle(
                            fontFamily: 'SF Pro Display', // Display extracondensed
                            fontWeight: FontWeight.w600, // semibold
                            fontSize: 20,
                            height: 27.5 / 20, // line height 27.5
                            letterSpacing: 0,
                            color: Color(0xFF1D1C18),
                          ),
                        ),

                        const SizedBox(height: 2),

                        // 1_c. Date range and days left
                        Text(
                          '${widget.dateRange} • ${widget.daysLeft}',
                          style: const TextStyle(
                            fontWeight: FontWeight.w400, // regular
                            fontSize: 12,
                            height: 18 / 12, // line height 18
                            letterSpacing: 0,
                            color: Color(0xFF8A7267),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(width: 12),

                  // Right widget - Pace boost and playback speed
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      // 2_a. Pace boost label
                      const Text(
                        'PACE BOOST',
                        style: TextStyle(
                          fontWeight: FontWeight.w600, // semibold
                          fontSize: 10,
                          height: 14 / 10, // line height 14
                          letterSpacing: 0.5,
                          color: Color(0xFF765700),
                        ),
                      ),

                      const SizedBox(height: 4),

                      // 2_b. Playback speed container
                      Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE6E2DB),
                          borderRadius: BorderRadius.circular(9999),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _buildSpeedOption('1.0x', 1.0),
                            _buildSpeedOption('1.25x', 1.25),
                            _buildSpeedOption('1.5x', 1.5),
                          ],
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
    );
  }

  Widget _buildSpeedOption(String label, double speed) {
    final isActive = widget.selectedSpeed == speed;

    return GestureDetector(
      onTap: () => widget.onSpeedChanged(speed),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFF9A4100) : Colors.transparent,
          borderRadius: BorderRadius.circular(9999),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontWeight: isActive ? FontWeight.w700 : FontWeight.w600, // bold : semibold
            fontSize: 10,
            height: 14 / 10, // line height 14
            letterSpacing: 0.5,
            color: isActive ? const Color(0xFFFFFFFF) : const Color(0xFF574238),
          ),
        ),
      ),
    );
  }
}
