import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import '../services/audio_service.dart';

/// Global hidden YouTube player widget
/// This should be included at the app root level to ensure
/// audio playback works consistently across all screens
class AudioPlayerWidget extends StatelessWidget {
  final Widget child;

  const AudioPlayerWidget({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<AudioService>(
      builder: (context, audioService, _) {
        return Stack(
          textDirection: TextDirection.ltr,
          children: [
            // Main app content
            child,

            // Hidden YouTube Player for audio playback
            if (audioService.controller != null)
              Positioned(
                left: -10000,
                top: -10000,
                child: SizedBox(
                  width: 100,
                  height: 100,
                  child: YoutubePlayer(
                    controller: audioService.controller!,
                    aspectRatio: 16 / 9,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
