import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/parayan_top_tab_navigation.dart';
import '../widgets/all_adhyay/all_adhyay_info_card.dart';
import '../widgets/all_adhyay/search_and_categories.dart';
import '../widgets/all_adhyay/adhyay_list_widget.dart';
import '../../services/audio_service.dart';
import '../../data/adhyay_data.dart';
import '../../data/adhyay_youtube_links.dart';

class AllAdhyayParayanScreen extends StatefulWidget {
  const AllAdhyayParayanScreen({super.key});

  @override
  State<AllAdhyayParayanScreen> createState() => _AllAdhyayParayanScreenState();
}

class _AllAdhyayParayanScreenState extends State<AllAdhyayParayanScreen> {
  int _activeTab = 1; // 1 for All 51 Adhyays tab
  String _selectedCategory = 'All';
  final TextEditingController _searchController = TextEditingController();

  void _handleTabChange(int tab) {
    setState(() {
      _activeTab = tab;
    });
    print('Tab changed to: $tab');
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

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F3EC),
      body: SafeArea(
        child: Column(
          children: [
            // 1. Top Tab Navigation
            ParayanTopTabNavigation(
              activeTab: _activeTab,
              onTabChanged: _handleTabChange,
            ),

            // 2. Scrollable content
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // 3. All Adhyay Info Card
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

                    // 4. Search and Categories
                    SearchAndCategories(
                      selectedCategory: _selectedCategory,
                      onCategorySelected: _handleCategoryChange,
                      onSearchChanged: _handleSearchChange,
                      onMicTap: _handleMicTap,
                      searchController: _searchController,
                    ),

                    const SizedBox(height: 8),

                    // 5. Adhyay List Widget
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
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
