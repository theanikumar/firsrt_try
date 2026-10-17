import 'package:flutter/material.dart';
import 'dart:ui';

class PlayerDrawer extends StatelessWidget {
  final String songName;
  final String songDetails;
  final String? thumbnailUrl;
  final bool isPlaying;
  final bool isSaved;
  final VoidCallback onPlayPausePressed;
  final VoidCallback onSavePressed;
  final VoidCallback onTap;

  const PlayerDrawer({
    super.key,
    required this.songName,
    required this.songDetails,
    this.thumbnailUrl,
    this.isPlaying = false,
    this.isSaved = false,
    required this.onPlayPausePressed,
    required this.onSavePressed,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GestureDetector(
        onTap: onTap,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 24, sigmaY: 24),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFFFFFFFF),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  // Drop shadow 1
                  BoxShadow(
                    color: const Color(0xFF1E293B).withValues(alpha: 0.08),
                    offset: const Offset(0, 12),
                    blurRadius: 32,
                    spreadRadius: -6,
                  ),
                  // Drop shadow 2
                  BoxShadow(
                    color: const Color(0xFFF59E0B).withValues(alpha: 0.18),
                    offset: const Offset(0, 0),
                    blurRadius: 18,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Row(
                children: [
                  // 1. Left - Icon and song details
                  Expanded(
                    child: Row(
                      children: [
                        // Icon widget
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFDDB8),
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.05),
                                offset: const Offset(0, 2),
                                blurRadius: 4,
                                spreadRadius: 0,
                                blurStyle: BlurStyle.inner,
                              ),
                            ],
                          ),
                          child: thumbnailUrl != null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(
                                    thumbnailUrl!,
                                    width: 40,
                                    height: 40,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return _defaultMusicIcon();
                                    },
                                  ),
                                )
                              : _defaultMusicIcon(),
                        ),
                        const SizedBox(width: 8),
                        // Song details
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // Line 1 - Song name
                              Text(
                                songName,
                                textAlign: TextAlign.left,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  height: 1.5, // Line height 24 / font size 16 = 1.5
                                  letterSpacing: 0,
                                  color: Color(0xFF1D1C18),
                                  decoration: TextDecoration.none,
                                ),
                              ),
                              // Line 2 - Song details
                              Text(
                                songDetails,
                                textAlign: TextAlign.left,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
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
                  const SizedBox(width: 4),
                  // 2. Right - Save and Play/Pause buttons
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Save icon container
                      GestureDetector(
                        onTap: onSavePressed,
                        child: Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(9999),
                          ),
                          child: Icon(
                            isSaved ? Icons.bookmark : Icons.bookmark_border,
                            color: const Color(0xFF574238),
                            size: 24,
                          ),
                        ),
                      ),
                      const SizedBox(width: 4),
                      // Play/Pause icon container
                      GestureDetector(
                        onTap: onPlayPausePressed,
                        child: Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            color: const Color(0xFF9A4100),
                            borderRadius: BorderRadius.circular(9999),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFFD96B27).withValues(alpha: 0.35),
                                offset: const Offset(0, 0),
                                blurRadius: 14,
                                spreadRadius: 0,
                              ),
                            ],
                          ),
                          child: Icon(
                            isPlaying ? Icons.pause : Icons.play_arrow,
                            color: const Color(0xFFFFFFFF),
                            size: 24,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _defaultMusicIcon() {
    return const Icon(
      Icons.music_note,
      color: Color(0xFF9A4100),
      size: 24,
    );
  }
}
