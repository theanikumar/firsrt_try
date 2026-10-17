import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/parayan_top_tab_navigation.dart';
import '../widgets/parayan_main_container.dart';
import '../widgets/saptah_parayan/saptah_parayan_info_card.dart';
import '../widgets/saptah_parayan/saptah_parayan_progress_widget.dart';
import '../widgets/saptah_parayan/daily_saptah_schedule.dart';
import '../widgets/all_adhyay/all_adhyay_info_card.dart';
import '../widgets/all_adhyay/search_and_categories.dart';
import '../widgets/all_adhyay/adhyay_list_widget.dart';
import '../../common/app_header.dart';
import '../../common/bottom_navigation.dart';
import '../../common/player_drawer.dart';
import '../../services/audio_service.dart';
import '../../data/adhyay_data.dart';
import '../../data/adhyay_youtube_links.dart';
import '../../routes/app_routes.dart';

class ParayanScreen extends StatefulWidget {
  const ParayanScreen({super.key});

  @override
  State<ParayanScreen> createState() => _ParayanScreenState();
}

class _ParayanScreenState extends State<ParayanScreen> {
  int _activeTab = 0; // 0 for Saptah Parayan (default), 1 for All 51 Adhyays
  double _selectedSpeed = 1.0;
  String _selectedCategory = 'All';
  final TextEditingController _searchController = TextEditingController();
  bool _isSaved = false;

  void _handleTabChange(int tab) {
    setState(() {
      _activeTab = tab;
    });
    print('Tab changed to: $tab');
  }

  void _handleSpeedChange(double speed) {
    setState(() {
      _selectedSpeed = speed;
    });
    print('Speed changed to: $speed');
  }

  void _handleCategoryChange(String category) {
    setState(() {
      _selectedCategory = category;
    });
    print('Category changed to: $category');
  }

  void _handleSearchChange(String query) {
    print('Search query: $query');
    // TODO: Implement search filtering
  }

  void _handleMicTap() {
    print('Mic tapped for voice search');
    // TODO: Implement voice search
  }

  void _handleNavigation(int index) {
    // Don't navigate if already on the same screen
    if (index == 0) return;

    switch (index) {
      case 0:
        // Parayan - already here
        break;
      case 1:
        // Explore
        AppRoutes.replaceWithExplore(context);
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

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
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
                // 1. App Header (fixed at top)
                const AppHeader(
                  streakCount: 7,
                  profileImageUrl: null,
                ),

                // 2. Top Tab Navigation
                ParayanTopTabNavigation(
                  activeTab: _activeTab,
                  onTabChanged: _handleTabChange,
                ),

                // 3. Scrollable content based on active tab
                Expanded(
                  child: SingleChildScrollView(
                    child: _activeTab == 0
                        ? _buildSaptahParayanTab()
                        : _buildAllAdhyayTab(),
                  ),
                ),

                // 4. Player Drawer (if song is playing)
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

                // 5. Bottom Navigation (fixed at bottom)
                BottomNavigation(
                  currentIndex: 0, // Parayan tab active (index 0 now)
                  onTap: _handleNavigation,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Saptah Parayan Tab Content
  Widget _buildSaptahParayanTab() {
    return ParayanMainContainer(
      children: [
        // 1. Saptah Parayan Info Card
        SaptahParayanInfoCard(
          title: 'Shravan Shukla Parayan',
          dateRange: 'Thu 24 Oct - Wed 30 Oct',
          daysLeft: '3 days left',
          selectedSpeed: _selectedSpeed,
          onSpeedChanged: _handleSpeedChange,
        ),

        // 2. Saptah Parayan Progress Widget
        const SaptahParayanProgressWidget(
          completedChapters: 18,
          totalChapters: 51,
          completedDays: 2,
          timeListened: '4h 12m listened',
          timeLeft: 'Est. 5h 45m left',
        ),

        // 3. Daily Saptah Schedule
        const DailySaptahSchedule(),
      ],
    );
  }

  // All 51 Adhyays Tab Content
  Widget _buildAllAdhyayTab() {
    return Column(
      children: [
        // 1. All Adhyay Info Card
        const AllAdhyayInfoCard(
          currentRead: 4,
          totalReads: 52,
          adhyayTitle: 'Adhyay 15 • Cholkar\'s Sugar',
          verseNumber: 48,
          timeRemaining: '8 min remaining',
          currentTrackProgress: 62,
          overallProgress: 27,
        ),

        const SizedBox(height: 12),

        // 2. Search and Categories
        SearchAndCategories(
          selectedCategory: _selectedCategory,
          onCategorySelected: _handleCategoryChange,
          onSearchChanged: _handleSearchChange,
          onMicTap: _handleMicTap,
          searchController: _searchController,
        ),

        const SizedBox(height: 8),

        // 3. Adhyay List Widget
        Builder(
          builder: (context) {
            return AdhyayListWidget(
              onReadTap: (adhyayNumber, videoId) {
                final audioService = Provider.of<AudioService>(context, listen: false);
                final adhyayData = AdhyayData.getAdhyay(adhyayNumber);

                final song = Song(
                  id: 'adhyay_$adhyayNumber',
                  title: adhyayData.title,
                  artist: 'Sai Satcharitra',
                  youtubeUrl: AdhyayYoutubeLinks.getYoutubeUrl(adhyayNumber, 'en'),
                  videoId: videoId,
                  duration: Duration(minutes: adhyayData.durationMinutes),
                  category: 'Adhyay $adhyayNumber',
                  thumbnailUrl: adhyayData.imageUrl,
                  isSaptahParayan: false,
                );

                audioService.playSong(song);
                print('Playing Adhyay $adhyayNumber');
                print('Video ID: $videoId');
              },
            );
          },
        ),
      ],
    );
  }
}
