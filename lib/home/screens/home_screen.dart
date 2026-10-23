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
import '../../core/auth/auth_provider.dart';
import '../../core/bootstrap/bootstrap_provider.dart';
import '../../core/models/offering.dart';
import '../../routes/app_routes.dart';
import '../../services/audio_service.dart';

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
    // The audio service is already playing; open the full player.
    AppRoutes.navigateToPlayer(context);
  }

  Song _songFromOffering(Offering offering) {
    final videoId = offering.youtubeVideoId;
    final url = offering.youtubeUrl.isNotEmpty
        ? offering.youtubeUrl
        : 'https://www.youtube.com/watch?v=$videoId';
    return Song(
      id: offering.id.toString(),
      title: offering.title,
      artist: offering.artistName,
      youtubeUrl: url,
      videoId: videoId,
      duration: offering.duration,
      category: _categoryLabel(offering.category),
      thumbnailUrl:
          offering.thumbnailUrl.isNotEmpty ? offering.thumbnailUrl : null,
      isSaptahParayan: offering.offeringType == 'parayan',
    );
  }

  String _categoryLabel(String category) {
    switch (category) {
      case 'kakad_aarti':
        return 'Kakad Aarti';
      case 'dhoop_aarti':
        return 'Dhoop Aarti';
      case 'shej_aarti':
        return 'Shej Aarti';
      case 'bhajan':
        return 'Bhajan';
      case 'dhun':
        return 'Dhun';
      case 'parayan':
        return 'Parayan';
      default:
        return category.isEmpty
            ? 'Devotional'
            : category.replaceAll('_', ' ');
    }
  }

  Widget _buildRetryCard(BootstrapProvider bootstrap) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF3E0),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE8C9A0)),
      ),
      child: Row(
        children: [
          const Icon(Icons.cloud_off, color: Color(0xFF9A4100), size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              'Live content could not be refreshed. ${bootstrap.error ?? ''}',
              style: const TextStyle(
                fontSize: 12,
                height: 1.4,
                color: Color(0xFF574238),
              ),
            ),
          ),
          TextButton(
            onPressed: bootstrap.isLoading ? null : bootstrap.refresh,
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    final bootstrap = context.watch<BootstrapProvider>();
    final language = auth.language;
    final quote = bootstrap.quote;
    final live = bootstrap.primaryLiveStream;
    final melodies = bootstrap.melodies
        .where((offering) => offering.isPlayable)
        .map(_songFromOffering)
        .toList();

    return Consumer<AudioService>(
      builder: (context, audioService, child) {
        return Scaffold(
          backgroundColor: const Color(0xFFF8F3EC),
          body: SafeArea(
                child: Column(
                  children: [
                    // Header (fixed at top)
                    HomeHeader(
                      streakCount: 7,
                      profileImageUrl: auth.devotee?.avatarUrl.isNotEmpty == true
                          ? auth.devotee!.avatarUrl
                          : null,
                    ),

            // Scrollable content
            Expanded(
              child: SingleChildScrollView(
                child: HomeMainContainer(
                  children: [
                    if (bootstrap.error != null)
                      _buildRetryCard(bootstrap),

                    // 1. Greeting
                    HomeGreeting(
                      dayStreak: 3,
                      userName: auth.displayName,
                    ),

                    // 2. Live Darshan
                    if (live != null && live.hasHls)
                      LiveDarshan(videoUrl: live.hlsUrl),

                    // 3. Parayan Progress
                    ParayanProgress(
                      currentDay: 3,
                      totalDays: 7,
                      completedDays: 2,
                      progressPercentage: 43.0,
                      onResumePressed: () {
                        AppRoutes.navigateToParayan(context);
                      },
                    ),

                    // 4. Amrit Vani (Daily Quote)
                    AmritVani(
                      quote: quote?.quoteFor(language),
                      translation:
                          language == 'en' ? null : quote?.quoteEn,
                      reference: quote?.reference,
                    ),

                    // 5. Quick Actions (Sacred Offerings)
                    QuickActions(),

                    // 6. Devotional Melodies
                    DevotionalMelodies(
                      songs: melodies,
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
