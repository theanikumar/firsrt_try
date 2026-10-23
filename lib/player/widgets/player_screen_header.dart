import 'package:flutter/material.dart';

class PlayerScreenHeader extends StatelessWidget {
  final VoidCallback onDropPressed;
  final VoidCallback onSavePressed;
  final bool isSaved;
  final String qualityText;

  const PlayerScreenHeader({
    super.key,
    required this.onDropPressed,
    required this.onSavePressed,
    this.isSaved = false,
    this.qualityText = 'Streaming from YouTube',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // 1. Drop button widget (left)
          _buildDropButton(),

          // 2. Now Playing widget (center)
          Expanded(
            child: _buildNowPlayingWidget(),
          ),

          // 3. Save widget (right)
          _buildSaveWidget(),
        ],
      ),
    );
  }

  // 1. Drop button widget
  Widget _buildDropButton() {
    return GestureDetector(
      onTap: onDropPressed,
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: const Color(0xFFF2EDE6),
          borderRadius: BorderRadius.circular(9999),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              offset: const Offset(0, 1),
              blurRadius: 2,
              spreadRadius: 0,
            ),
          ],
        ),
        child: const Icon(
          Icons.keyboard_arrow_down,
          color: Color(0xFF1D1C18),
          size: 24,
        ),
      ),
    );
  }

  // 2. Now Playing widget
  Widget _buildNowPlayingWidget() {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 2_a. "NOW PLAYING" text
          const Text(
            'NOW PLAYING',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 10,
              height: 1.4, // Line height 14 / font size 10 = 1.4
              letterSpacing: 1,
              color: Color(0xFF765700),
              decoration: TextDecoration.none,
            ),
          ),
          // 2_b. Text container with quality badge
          Container(
            padding: const EdgeInsets.only(top: 2),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: const Color(0xFFECE7E1),
                borderRadius: BorderRadius.circular(9999),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Dot
                  Container(
                    width: 6,
                    height: 6,
                    decoration: const BoxDecoration(
                      color: Color(0xFFFEA619),
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 4),
                  // Quality text
                  Flexible(
                    child: Text(
                      qualityText,
                      textAlign: TextAlign.left,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 10,
                        height: 1.4, // Line height 14 / font size 10 = 1.4
                        letterSpacing: 0.5,
                        color: Color(0xFF574238),
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 3. Save widget
  Widget _buildSaveWidget() {
    return GestureDetector(
      onTap: onSavePressed,
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: const Color(0xFFF2EDE6),
          borderRadius: BorderRadius.circular(9999),
        ),
        child: Icon(
          isSaved ? Icons.bookmark : Icons.bookmark_border,
          color: const Color(0xFF9A4100),
          size: 24,
        ),
      ),
    );
  }
}
