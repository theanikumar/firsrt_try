import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/audio_service.dart';

class TrendingSongData {
  final String title;
  final String artist;
  final String duration;
  final String category;
  final Song song;

  const TrendingSongData({
    required this.title,
    required this.artist,
    required this.duration,
    required this.category,
    required this.song,
  });
}

class ExploreTrendingBhajans extends StatelessWidget {
  final String title;
  final String updateText;
  final List<TrendingSongData> songs;
  final Function(String songName, String details)? onPlaySong;
  final ValueChanged<Song>? onSongPlayed;

  const ExploreTrendingBhajans({
    super.key,
    this.title = 'Trending Song',
    this.updateText = 'Updated Today',
    required this.songs,
    this.onPlaySong,
    this.onSongPlayed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, // Fill width
      padding: const EdgeInsets.only(bottom: 16),
      child: Container(
        width: double.infinity, // Fill width
        child: Column(
          children: [
            // 1. Upper widget - Title and Update text
            _buildUpperWidget(),

            const SizedBox(height: 8), // Gap 8

            // 2. Lower widget - Song cards
            _buildLowerWidget(context),
          ],
        ),
      ),
    );
  }

  Widget _buildUpperWidget() {
    return Container(
      width: double.infinity, // Fill width
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // a. Left - Icon + Title
          Row(
            children: [
              // Icon
              const Icon(
                Icons.trending_up,
                color: Color(0xFFFEA619),
                size: 20,
              ),

              const SizedBox(width: 8), // Gap 8

              // Text "Trending Song"
              Text(
                title,
                textAlign: TextAlign.left,
                style: const TextStyle(
                  fontFamily: 'SF Pro Display', // Display extracondensed
                  fontWeight: FontWeight.w700, // bold
                  fontSize: 20,
                  height: 28 / 20, // line height 28
                  letterSpacing: 0,
                  color: Color(0xFF1D1C18),
                ),
              ),
            ],
          ),

          // b. Right - Updated Today
          Text(
            updateText,
            textAlign: TextAlign.left,
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
    );
  }

  Widget _buildLowerWidget(BuildContext context) {
    return Column(
      children: songs.asMap().entries.map((entry) {
        final index = entry.key;
        final songData = entry.value;
        final isLast = index == songs.length - 1;

        return Padding(
          padding: EdgeInsets.only(bottom: isLast ? 0 : 4), // Gap 4 between cards
          child: _buildSongCard(context, songData),
        );
      }).toList(),
    );
  }

  Widget _buildSongCard(BuildContext context, TrendingSongData songData) {
    return Container(
      width: double.infinity, // Fill width
      padding: const EdgeInsets.all(8),
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
          // a. Left - Thumbnail and Details
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
                  child: const Icon(
                    Icons.music_note,
                    color: Color(0xFF9A4100),
                    size: 28,
                  ),
                ),

                const SizedBox(width: 8),

                // Song Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Line 1 - Song name
                      Text(
                        songData.title,
                        textAlign: TextAlign.left,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600, // semibold
                          fontSize: 18,
                          height: 24 / 18, // line height 24
                          letterSpacing: 0,
                          color: Color(0xFF1D1C18),
                        ),
                      ),

                      // Line 2 - Artist
                      Text(
                        songData.artist,
                        textAlign: TextAlign.left,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontWeight: FontWeight.w400, // regular
                          fontSize: 12,
                          height: 18 / 12, // line height 18
                          letterSpacing: 0,
                          color: Color(0xFF574238),
                        ),
                      ),

                      // Line 3 - Duration & Category
                      Text(
                        '${songData.duration} • ${songData.category}',
                        textAlign: TextAlign.left,
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
                ),
              ],
            ),
          ),

          const SizedBox(width: 8),

          // b. Right - Play button
          GestureDetector(
            onTap: () async {
              // Handle play action
              final audioService = Provider.of<AudioService>(context, listen: false);

              // Start playing the song
              await audioService.playSong(songData.song);

              onSongPlayed?.call(songData.song);

              if (onPlaySong != null) {
                onPlaySong!(songData.title, '${songData.artist} • ${songData.category}');
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

// Sample data for trending songs
class ExploreTrendingBhajansData {
  static List<TrendingSongData> getTrendingSongs(List<Song> songs) {
    if (songs.isEmpty) {
      return [];
    }

    return songs.take(3).map((song) {
      return TrendingSongData(
        title: song.title,
        artist: song.artist,
        duration: _formatDuration(song.duration),
        category: song.category,
        song: song,
      );
    }).toList();
  }

  static String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }
}
