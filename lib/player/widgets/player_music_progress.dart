import 'package:flutter/material.dart';

class PlayerMusicProgress extends StatefulWidget {
  final Duration currentPosition;
  final Duration totalDuration;
  final ValueChanged<Duration>? onSeek;

  const PlayerMusicProgress({
    super.key,
    required this.currentPosition,
    required this.totalDuration,
    this.onSeek,
  });

  @override
  State<PlayerMusicProgress> createState() => _PlayerMusicProgressState();
}

class _PlayerMusicProgressState extends State<PlayerMusicProgress> {
  bool _showTimeRemaining = false;

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }

  double get _progress {
    final total = widget.totalDuration.inMilliseconds;
    if (total <= 0) return 0;
    return (widget.currentPosition.inMilliseconds / total).clamp(0.0, 1.0);
  }

  void _toggleTimeDisplay() {
    setState(() {
      _showTimeRemaining = !_showTimeRemaining;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(bottom: 12),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xFFF8F3EC),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 1. Sound track simulation in vertical lines
            _buildSoundTrackSimulation(),

            // 2. Progress bar widget
            _buildProgressBar(),

            // 3. Numeric details widget
            _buildNumericDetails(),
          ],
        ),
      ),
    );
  }

  // 1. Sound track simulation widget
  Widget _buildSoundTrackSimulation() {
    return Container(
      width: double.infinity,
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end, // Align to bottom
            children: _generateSoundTrackLines(constraints.maxWidth),
          );
        },
      ),
    );
  }

  List<Widget> _generateSoundTrackLines(double availableWidth) {
    // Calculate how many lines can fit with 4px width and 8px gap
    final int totalLines = ((availableWidth + 8) ~/ (4 + 8)).clamp(20, 60);

    final int currentLineIndex = (totalLines * _progress).round();

    // Different heights for variation
    final List<double> heights = [12, 20, 28, 36, 32, 24, 16, 22, 30, 26];

    return List.generate(totalLines, (index) {
      // Determine state: passed, present, or future
      Color lineColor;
      if (index < currentLineIndex) {
        lineColor = const Color(0xFF9A4100); // Passed
      } else if (index == currentLineIndex) {
        lineColor = const Color(0xFFFFB95F); // Present
      } else {
        lineColor = const Color(0xFFE6E2DB); // Future
      }

      // Use different heights in a pattern
      final double height = heights[index % heights.length];

      return Container(
        width: 4,
        height: height,
        margin: EdgeInsets.only(
          right: index < totalLines - 1 ? 8 : 0, // Gap of 8 between lines
        ),
        decoration: BoxDecoration(
          color: lineColor,
          borderRadius: BorderRadius.circular(9999),
        ),
      );
    });
  }

  // 2. Progress bar widget
  Widget _buildProgressBar() {
    final double progress = _progress;

    return Container(
      width: double.infinity,
      height: 14,
      padding: const EdgeInsets.only(top: 2),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final double progressWidth = constraints.maxWidth * progress;

          return Stack(
            alignment: Alignment.centerLeft,
            children: [
              // Background container
              Container(
                width: double.infinity,
                height: 6,
                decoration: BoxDecoration(
                  color: const Color(0xFFE6E2DB),
                  borderRadius: BorderRadius.circular(9999),
                ),
              ),

              // Progress bar
              Container(
                width: progressWidth,
                height: 6,
                decoration: BoxDecoration(
                  color: const Color(0xFF9A4100),
                  borderRadius: BorderRadius.circular(9999),
                ),
              ),

              // Progress indicator disc
              Positioned(
                left: (progressWidth - 8).clamp(0.0, constraints.maxWidth - 16),
                child: Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFEA619),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFF59E0B).withValues(alpha: 0.6),
                        offset: const Offset(0, 0),
                        blurRadius: 12,
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                  child: Center(
                    // Inner white circle
                    child: Container(
                      width: 6,
                      height: 6,
                      decoration: const BoxDecoration(
                        color: Color(0xFFFFFFFF),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  // 3. Numeric details widget
  Widget _buildNumericDetails() {
    final Duration timeRemaining = widget.totalDuration - widget.currentPosition;
    final Duration safeRemaining =
        timeRemaining.isNegative ? Duration.zero : timeRemaining;

    return Container(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Left - Current time
          Text(
            _formatDuration(widget.currentPosition),
            textAlign: TextAlign.left,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 12,
              height: 1.33, // Line height 16 / font size 12 = 1.33
              letterSpacing: 0.36,
              color: Color(0xFF9A4100),
              decoration: TextDecoration.none,
            ),
          ),

          // Right - Total duration or time remaining
          GestureDetector(
            onTap: _toggleTimeDisplay,
            child: Text(
              _showTimeRemaining
                  ? '-${_formatDuration(safeRemaining)}'
                  : _formatDuration(widget.totalDuration),
              textAlign: TextAlign.right,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 12,
                height: 1.33, // Line height 16 / font size 12 = 1.33
                letterSpacing: 0.36,
                color: Color(0xFF574238),
                decoration: TextDecoration.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
