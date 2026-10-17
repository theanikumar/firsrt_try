import 'package:flutter/material.dart';

class PlayerControls extends StatelessWidget {
  final bool isPlaying;
  final VoidCallback onPlayPause;
  final VoidCallback onPrevious;
  final VoidCallback onNext;
  final VoidCallback onRewind;
  final VoidCallback onForward;

  const PlayerControls({
    super.key,
    required this.isPlaying,
    required this.onPlayPause,
    required this.onPrevious,
    required this.onNext,
    required this.onRewind,
    required this.onForward,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // 1. Back widget (15 sec rewind)
            _buildControlButton(
              icon: Icons.replay_10,
              onPressed: onRewind,
            ),

            // 2. Previous song widget
            _buildControlButton(
              icon: Icons.skip_previous,
              onPressed: onPrevious,
            ),

            // 3. Play/Pause widget
            _buildPlayPauseButton(),

            // 4. Next song widget
            _buildControlButton(
              icon: Icons.skip_next,
              onPressed: onNext,
            ),

            // 5. Forward widget (15 sec skip)
            _buildControlButton(
              icon: Icons.forward_10,
              onPressed: onForward,
            ),
          ],
        ),
      ),
    );
  }

  // Control buttons (back, previous, next, forward)
  Widget _buildControlButton({
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(9999),
        ),
        child: Icon(
          icon,
          color: const Color(0xFF1D1C18),
          size: 24,
        ),
      ),
    );
  }

  // Play/Pause button
  Widget _buildPlayPauseButton() {
    return GestureDetector(
      onTap: onPlayPause,
      child: Container(
        width: 64,
        height: 64,
        decoration: BoxDecoration(
          color: const Color(0xFF9A4100),
          borderRadius: BorderRadius.circular(9999),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF9A4100).withValues(alpha: 0.35),
              offset: const Offset(0, 8),
              blurRadius: 20,
              spreadRadius: 0,
            ),
          ],
        ),
        child: Icon(
          isPlaying ? Icons.pause : Icons.play_arrow,
          color: const Color(0xFFFFFFFF),
          size: 32,
        ),
      ),
    );
  }
}
