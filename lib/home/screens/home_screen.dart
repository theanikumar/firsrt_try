import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/home_header.dart';
import '../widgets/home_main_container.dart';
import '../widgets/home_greeting.dart';
import '../widgets/live_darshan.dart';
import '../widgets/parayan_progress.dart';
import '../widgets/amrit_vani.dart';
import '../widgets/quick_actions.dart';
import '../widgets/devotional_melodies.dart';
import '../../common/bottom_navigation.dart';
import '../../common/player_drawer.dart';
import '../../routes/app_routes.dart';
import '../../services/audio_service.dart';
import '../../data/songs_data.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Player state
  bool _isSaved = false;

  void _handleNavigation(int index) {
    // Handle navigation to different screens
    print('Navigate to index: $index');

    switch (index) {
      case 0:
        // Parayan
        AppRoutes.navigateToParayan(context);
        break;
      case 1:
        // Explore
        AppRoutes.navigateToExplore(context);
        break;
      case 2:
        // Player
        AppRoutes.navigateToPlayer(context);
        break;
      case 3:
        // Sevak
        AppRoutes.navigateToSevak(context);
        break;
      case 4:
        // Settings
        AppRoutes.navigateToSettings(context);
        break;
    }
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

  // Method to start playing a song (can be called from child widgets)
  void _playSong(String songName, String details) {
    print('Now playing: $songName - $details');

    // Navigate to player screen
    AppRoutes.navigateToPlayer(context);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AudioService>(
      builder: (context, audioService, child) {
        return Scaffold(
          backgroundColor: const Color(0xFFF8F3EC),
          body: SafeArea(
                child: Column(
                  children: [
                    // Header (fixed at top)
                    const HomeHeader(
                      streakCount: 7,
                      profileImageUrl: null, // Will use default profile icon
                    ),

            // Scrollable content
            Expanded(
              child: SingleChildScrollView(
                child: HomeMainContainer(
                  children: [
                    // 1. Greeting
                    HomeGreeting(
                      dayStreak: 3,
                      userName: 'Devotee',
                    ),

                    // 2. Live Darshan
                    LiveDarshan(
                      videoUrl: 'https://www.youtube.com/watch?v=04fkCLDjNec',
                    ),

                    // 3. Parayan Progress
                    ParayanProgress(
                      currentDay: 3,
                      totalDays: 7,
                      completedDays: 2,
                      progressPercentage: 43.0,
                      onResumePressed: () async {
                        // Get audio service and play Satcharitra
                        final audioService = Provider.of<AudioService>(context, listen: false);
                        final satcharitra = SongsData.saptahParayan.first;
                        await audioService.playSong(satcharitra);

                        _playSong(satcharitra.title, satcharitra.artist);
                      },
                    ),

                    // 4. Amrit Vani (Daily Quote)
                    AmritVani(),

                    // 5. Quick Actions (Sacred Offerings)
                    QuickActions(),

                    // 6. Devotional Melodies
                    DevotionalMelodies(
                      onPlaySong: _playSong,
                    ),
                  ],
                ),
              ),
            ),

                    // Player Drawer (shown above bottom navigation when playing)
                    if (audioService.currentSong != null)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: PlayerDrawer(
                          songName: audioService.currentSong!.title,
                          songDetails: '${audioService.currentSong!.artist} • ${audioService.currentSong!.category}',
                          thumbnailUrl: null, // Will use default music icon
                          isPlaying: audioService.isPlaying,
                          isSaved: _isSaved,
                          onPlayPausePressed: _handlePlayPause,
                          onSavePressed: _handleSave,
                          onTap: _handlePlayerTap,
                        ),
                      ),

                    // Bottom Navigation (fixed at bottom)
                    BottomNavigation(
                      currentIndex: -1, // -1 means no tab is active (for home page)
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
