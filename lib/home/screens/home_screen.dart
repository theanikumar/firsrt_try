import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/home_header.dart';
import '../widgets/home_main_container.dart';
import '../widgets/home_greeting.dart';
import '../widgets/live_darshan.dart';
import '../widgets/satcharitra_home_card.dart';
import '../widgets/amrit_vani.dart';
import '../widgets/quick_actions.dart';
import '../widgets/devotional_melodies.dart';
import '../../common/bottom_navigation.dart';
import '../../common/player_drawer.dart';
import '../../core/auth/auth_provider.dart';
import '../../core/bootstrap/bootstrap_provider.dart';
import '../../core/content/chapters_provider.dart';
import '../../core/favorites/favorites_provider.dart';
import '../../core/models/offering.dart';
import '../../core/repositories/catalog_repository.dart';
import '../../routes/app_routes.dart';
import '../../services/audio_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<ChaptersProvider>().ensureLoaded();
        context.read<FavoritesProvider>().ensureLoaded();
      }
    });
  }

  void _handleNavigation(int index) {
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
  }

  Future<void> _handleSave() async {
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

  void _handlePlayerTap() {
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
    final chapters = context.watch<ChaptersProvider>();
    final favorites = context.watch<FavoritesProvider>();
    final language = auth.language;
    final quote = bootstrap.quote;
    final live = bootstrap.primaryLiveStream;
    final melodies = bootstrap.melodies
        .where((offering) => offering.isPlayable)
        .map(_songFromOffering)
        .toList();

    return Consumer<AudioService>(
      builder: (context, audioService, child) {
        final currentOfferingId = int.tryParse(audioService.currentSong?.id ?? '');
        return Scaffold(
          backgroundColor: const Color(0xFFF8F3EC),
          body: SafeArea(
                child: Column(
                  children: [
                    // Header (fixed at top)
                    HomeHeader(
                      streakCount: 0,
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
                      dayStreak: 0,
                      userName: auth.displayName,
                    ),

                    // 2. Live Darshan
                    if (live != null && live.hasHls)
                      LiveDarshan(videoUrl: live.hlsUrl),

                    // 3. Satcharitra index
                    SatcharitraHomeCard(
                      totalChapters:
                          chapters.chapters.isEmpty ? 51 : chapters.chapters.length,
                      recordedChapters: chapters.recordedCount,
                      isLoading: chapters.isLoading,
                      onPressed: () {
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
                    QuickActions(
                      onTap: (index) {
                        if (index == 2) {
                          AppRoutes.navigateToParayan(context);
                        } else {
                          AppRoutes.navigateToExplore(context);
                        }
                      },
                    ),

                    // 6. Devotional Melodies
                    DevotionalMelodies(
                      songs: melodies,
                      onPlaySong: _playSong,
                      onSongPlayed: (song) {
                        final id = int.tryParse(song.id);
                        if (id != null) {
                          context
                              .read<CatalogRepository>()
                              .reportPlay(id);
                        }
                      },
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
                          isSaved: favorites.isFavorite(currentOfferingId),
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
