import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../common/app_header.dart';
import '../../common/bottom_navigation.dart';
import '../widgets/player_main_container.dart';
import '../widgets/player_screen_header.dart';
import '../widgets/player_disc_image.dart';
import '../widgets/player_song_details.dart';
import '../widgets/player_music_progress.dart';
import '../widgets/player_controls.dart';
import '../../services/audio_service.dart';
import '../../core/favorites/favorites_provider.dart';
import '../../routes/app_routes.dart';

class PlayerScreen extends StatefulWidget {
  const PlayerScreen({super.key});

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  void _handleNavigation(int index) {
    // Don't navigate if already on the same screen
    if (index == 2) return;

    switch (index) {
      case 0:
        // Parayan
        AppRoutes.replaceWithParayan(context);
        break;
      case 1:
        // Explore
        AppRoutes.replaceWithExplore(context);
        break;
      case 2:
        // Player - already here
        break;
      case 3:
        // Sevak
        AppRoutes.replaceWithSevak(context);
        break;
      case 4:
        // Settings
        AppRoutes.replaceWithSettings(context);
        break;
    }
  }

  void _handleDropPressed() {
    Navigator.pop(context);
  }

  Future<void> _handleSavePressed() async {
    final song = context.read<AudioService>().currentSong;
    final id = int.tryParse(song?.id ?? '');
    if (id == null) return;
    try {
      await context.read<FavoritesProvider>().toggle(id);
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Saved offerings could not be updated.')),
      );
    }
  }

  void _handlePlayPause() {
    final audioService = Provider.of<AudioService>(context, listen: false);
    audioService.togglePlayPause();
  }

  void _handlePrevious() {
    final audioService = Provider.of<AudioService>(context, listen: false);
    audioService.playPrevious();
  }

  void _handleNext() {
    final audioService = Provider.of<AudioService>(context, listen: false);
    audioService.playNext();
  }

  void _handleRewind() {
    final audioService = Provider.of<AudioService>(context, listen: false);
    audioService.rewind();
  }

  void _handleForward() {
    final audioService = Provider.of<AudioService>(context, listen: false);
    audioService.forward();
  }

  @override
  Widget build(BuildContext context) {
    final favorites = context.watch<FavoritesProvider>();

    return Consumer<AudioService>(
      builder: (context, audioService, child) {
        final currentSong = audioService.currentSong;
        final isPlaying = audioService.isPlaying;
        final currentPosition = audioService.currentPosition;
        final currentOfferingId = int.tryParse(currentSong?.id ?? '');

        // If no song is playing, show placeholder
        if (currentSong == null) {
          return Scaffold(
            backgroundColor: const Color(0xFFF8F3EC),
            body: SafeArea(
              child: Column(
                children: [
                  const AppHeader(
                    streakCount: 0,
                    profileImageUrl: null,
                  ),
                  Expanded(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(
                            Icons.music_note,
                            size: 80,
                            color: Color(0xFF9A4100),
                          ),
                          SizedBox(height: 16),
                          Text(
                            'No song playing',
                            style: TextStyle(
                              fontSize: 18,
                              color: Color(0xFF574238),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  BottomNavigation(
                    currentIndex: 2,
                    onTap: _handleNavigation,
                  ),
                ],
              ),
            ),
          );
        }

        return Scaffold(
          backgroundColor: const Color(0xFFF8F3EC),
          body: SafeArea(
                child: Column(
                  children: [
                    // Header (fixed at top)
                    const AppHeader(
                      streakCount: 0,
                      profileImageUrl: null,
                    ),

                    // Scrollable content
                    Expanded(
                      child: SingleChildScrollView(
                    child: PlayerMainContainer(
                      children: [
                        // Player Screen Header
                        PlayerScreenHeader(
                          onDropPressed: _handleDropPressed,
                          onSavePressed: _handleSavePressed,
                          isSaved: favorites.isFavorite(currentOfferingId),
                          qualityText: 'Streaming from YouTube',
                        ),

                        // Player Disc Image
                        PlayerDiscImage(
                          imagePath: 'assets/image/player_screen/sai_baba.png',
                          imageUrl: currentSong.thumbnailUrl,
                        ),

                        // Player Song Details
                        PlayerSongDetails(
                          isSaptahParayan: currentSong.isSaptahParayan,
                          categoryName: currentSong.category,
                          songName: currentSong.title,
                          singerOrAdhyayTitle: currentSong.artist,
                          readerDetails: currentSong.isSaptahParayan
                              ? 'Narrated by ${currentSong.artist}'
                              : null,
                        ),

                        // Player Music Progress
                        PlayerMusicProgress(
                          currentPosition: currentPosition,
                          totalDuration: currentSong.duration,
                          onSeek: (position) {
                            audioService.seekTo(position);
                          },
                        ),

                        // Player Controls
                        PlayerControls(
                          isPlaying: isPlaying,
                          onPlayPause: _handlePlayPause,
                          onPrevious: _handlePrevious,
                          onNext: _handleNext,
                          onRewind: _handleRewind,
                          onForward: _handleForward,
                        ),
                      ],
                    ),
                  ),
                ),

                // Bottom Navigation (fixed at bottom)
                BottomNavigation(
                  currentIndex: 2, // Player tab is active (index 2)
                  onTap: _handleNavigation,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
