import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/audio_service.dart';
import '../../data/songs_data.dart';

class DevotionalMelodies extends StatelessWidget {
  final Function(String songName, String details)? onPlaySong;
  final List<Song>? songs;

  const DevotionalMelodies({
    super.key,
    this.onPlaySong,
    this.songs,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 1. Section Title
          _buildSectionTitle(),
          const SizedBox(height: 8),

          // 2. Music Container (placeholder)
          _buildMusicContainer(context),
        ],
      ),
    );
  }

  Widget _buildSectionTitle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // a. Left - Title and subtitle
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: const [
              // Line 1
              Text(
                'Devotional Melodies',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                  height: 1.44, // Line height 26 / font size 18 = 1.44
                  letterSpacing: 0,
                  color: Color(0xFF1D1C18),
                  decoration: TextDecoration.none,
                ),
              ),
              // Line 2
              Text(
                'Handpicked for peace and meditation',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                  height: 1.5, // Line height 18 / font size 12 = 1.5
                  letterSpacing: 0,
                  color: Color(0xFF8A7267),
                  decoration: TextDecoration.none,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        // b. Right - View All button
        GestureDetector(
          onTap: () {
            // Handle View All tap
            print('View All tapped');
          },
          child: const Text(
            'View All',
            textAlign: TextAlign.left,
            style: TextStyle(
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

  Widget _buildMusicContainer(BuildContext context) {
    final songs = this.songs ?? SongsData.devotionalMelodies;

    if (songs.isEmpty) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        decoration: BoxDecoration(
          color: const Color(0xFFFFFFFF),
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Text(
          'New melodies are being consecrated. Please check back soon.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 13,
            height: 1.5,
            color: Color(0xFF8A7267),
          ),
        ),
      );
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: songs.map((song) {
        final isLast = song == songs.last;
        return Padding(
          padding: EdgeInsets.only(
            bottom: isLast ? 0 : 8,
          ),
          child: _buildMusicCard(
            context: context,
            song: song,
            playlist: songs,
            onPlaySong: onPlaySong,
          ),
        );
      }).toList(),
    );
  }

  Widget _buildMusicCard({
    required BuildContext context,
    required Song song,
    required List<Song> playlist,
    required Function(String songName, String details)? onPlaySong,
  }) {
    // Format duration
    String formatDuration(Duration duration) {
      String twoDigits(int n) => n.toString().padLeft(2, '0');
      final minutes = twoDigits(duration.inMinutes.remainder(60));
      final seconds = twoDigits(duration.inSeconds.remainder(60));
      return '$minutes:$seconds';
    }
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            offset: const Offset(0, 1),
            blurRadius: 2,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Row(
        children: [
          // Music Details
          Expanded(
            child: Row(
              children: [
                // Thumbnail
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFDBCB),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: song.thumbnailUrl != null &&
                          song.thumbnailUrl!.isNotEmpty
                      ? Image.network(
                          song.thumbnailUrl!,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(
                            Icons.music_note,
                            color: Color(0xFF9A4100),
                            size: 28,
                          ),
                        )
                      : const Icon(
                          Icons.music_note,
                          color: Color(0xFF9A4100),
                          size: 28,
                        ),
                ),
                const SizedBox(width: 8),
                // Music Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Line 1 - Music name
                      Text(
                        song.title,
                        textAlign: TextAlign.left,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          height: 1.33, // Line height 24 / font size 18 = 1.33
                          letterSpacing: 0,
                          color: Color(0xFF1D1C18),
                          decoration: TextDecoration.none,
                        ),
                      ),
                      // Line 2 - Singer
                      Text(
                        song.artist,
                        textAlign: TextAlign.left,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          height: 1.5, // Line height 18 / font size 12 = 1.5
                          letterSpacing: 0,
                          color: Color(0xFF574238),
                          decoration: TextDecoration.none,
                        ),
                      ),
                      // Line 3 - Duration & Category
                      Text(
                        '${formatDuration(song.duration)} • ${song.category}',
                        textAlign: TextAlign.left,
                        style: const TextStyle(
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
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          // Play button
          GestureDetector(
            onTap: () async {
              if (song.videoId.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('This melody is not available yet.'),
                  ),
                );
                return;
              }

              // Handle play action - trigger player drawer and audio service
              final audioService = Provider.of<AudioService>(context, listen: false);

              // Start playing the song
              await audioService.playSong(song, playlist: playlist);

              if (onPlaySong != null) {
                onPlaySong(song.title, '${song.artist} • ${song.category}');
              }
            },
            child: Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                color: Color(0xFFFFDBCB),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.play_arrow,
                color: Color(0xFF783100),
                size: 24,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
