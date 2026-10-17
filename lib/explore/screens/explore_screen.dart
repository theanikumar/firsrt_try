import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../common/app_header.dart';
import '../../common/bottom_navigation.dart';
import '../../common/player_drawer.dart';
import '../../services/audio_service.dart';
import '../../data/songs_data.dart';
import '../../routes/app_routes.dart';
import '../widgets/explore_search_bar.dart';
import '../widgets/explore_collections.dart';
import '../widgets/explore_vocal_masters.dart';
import '../widgets/explore_trending_bhajans.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  bool _isSaved = false;

  void _handleNavigation(int index) {
    // Don't navigate if already on the same screen
    if (index == 1) return;

    switch (index) {
      case 0:
        // Parayan
        AppRoutes.replaceWithParayan(context);
        break;
      case 1:
        // Explore - already here
        break;
      case 2:
        // Player
        AppRoutes.navigateToPlayer(context);
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

  void _handleSearchTap() {
    print('Search tapped');
    // TODO: Navigate to search screen
  }

  void _handleMicTap() {
    print('Mic tapped for voice search');
    // TODO: Implement voice search
  }

  void _handleCollectionTap(int index) {
    print('Collection $index tapped');
    // TODO: Navigate to collection detail screen
  }

  void _handleViewAllSingersTap() {
    print('View All singers tapped');
    // TODO: Navigate to all singers screen
  }

  void _handleSingerTap(int index) {
    print('Singer $index tapped');
    // TODO: Navigate to singer detail screen
  }

  void _handlePlayPause() {
    final audioService = Provider.of<AudioService>(context, listen: false);
    audioService.togglePlayPause();
    print('Play/Pause pressed via player drawer');
  }

  void _handleSave() {
    setState(() {
      _isSaved = !_isSaved;
    });
    print('Save pressed: isSaved = $_isSaved');
  }

  void _handlePlayerTap() {
    print('Player drawer tapped - navigate to player page');
    AppRoutes.navigateToPlayer(context);
  }

  void _handlePlaySong(String songName, String details) {
    print('Playing: $songName - $details');
    // Audio service already handled in widget
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AudioService>(
      builder: (context, audioService, child) {
        // Get trending songs from devotional melodies
        final trendingSongs = ExploreTrendingBhajansData.getTrendingSongs(
          SongsData.devotionalMelodies,
        );

        return Scaffold(
          backgroundColor: const Color(0xFFF8F3EC),
          body: SafeArea(
            child: Column(
              children: [
                // 1. App Header (fixed at top)
                const AppHeader(
                  streakCount: 7,
                  profileImageUrl: null,
                ),

                // 2. Scrollable content
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        // Search Bar
                        ExploreSearchBar(
                          onSearchTap: _handleSearchTap,
                          onMicTap: _handleMicTap,
                        ),

                        const SizedBox(height: 16),

                        // Collections
                        ExploreCollections(
                          totalCollections: 6,
                          collections: ExploreCollectionsData.collections,
                          onCollectionTap: _handleCollectionTap,
                        ),

                        const SizedBox(height: 16),

                        // Vocal Masters
                        ExploreVocalMasters(
                          singers: ExploreVocalMastersData.singers,
                          onViewAllTap: _handleViewAllSingersTap,
                          onSingerTap: _handleSingerTap,
                        ),

                        const SizedBox(height: 16),

                        // Trending Bhajans
                        ExploreTrendingBhajans(
                          songs: trendingSongs,
                          onPlaySong: _handlePlaySong,
                        ),
                      ],
                    ),
                  ),
                ),

                // 3. Player Drawer (if song is playing)
                if (audioService.currentSong != null)
                  PlayerDrawer(
                    songName: audioService.currentSong!.title,
                    songDetails: audioService.currentSong!.artist,
                    thumbnailUrl: audioService.currentSong!.thumbnailUrl,
                    isPlaying: audioService.isPlaying,
                    isSaved: _isSaved,
                    onPlayPausePressed: _handlePlayPause,
                    onSavePressed: _handleSave,
                    onTap: _handlePlayerTap,
                  ),

                // 4. Bottom Navigation (fixed at bottom)
                BottomNavigation(
                  currentIndex: 1, // Explore tab active (index 1 now)
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
