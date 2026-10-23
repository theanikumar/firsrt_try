import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../common/app_header.dart';
import '../../common/bottom_navigation.dart';
import '../../common/player_drawer.dart';
import '../../core/auth/auth_provider.dart';
import '../../core/content/chapters_provider.dart';
import '../../core/favorites/favorites_provider.dart';
import '../../core/models/content.dart';
import '../../core/repositories/catalog_repository.dart';
import '../../routes/app_routes.dart';
import '../../services/audio_service.dart';
import '../../utils/app_strings.dart';
import '../widgets/all_adhyay/adhyay_list_widget.dart';
import '../widgets/all_adhyay/search_and_categories.dart';
import '../widgets/parayan_main_container.dart';
import '../widgets/parayan_top_tab_navigation.dart';

class ParayanScreen extends StatefulWidget {
  const ParayanScreen({super.key});

  @override
  State<ParayanScreen> createState() => _ParayanScreenState();
}

class _ParayanScreenState extends State<ParayanScreen> {
  int _activeTab = 1; // Default to the live Satcharitra index.
  String _selectedCategory = 'All';
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

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

  void _handleTabChange(int tab) {
    setState(() => _activeTab = tab);
  }

  void _handleCategoryChange(String category) {
    setState(() => _selectedCategory = category);
  }

  void _handleSearchChange(String query) {
    setState(() => _searchQuery = query.trim().toLowerCase());
  }

  void _handleNavigation(int index) {
    if (index == 0) return;

    switch (index) {
      case 1:
        AppRoutes.replaceWithExplore(context);
        break;
      case 2:
        AppRoutes.navigateToPlayer(context);
        break;
      case 3:
        AppRoutes.replaceWithSevak(context);
        break;
      case 4:
        AppRoutes.replaceWithSettings(context);
        break;
    }
  }

  void _handlePlayPause() {
    context.read<AudioService>().togglePlayPause();
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

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    final favorites = context.watch<FavoritesProvider>();

    return Consumer<AudioService>(
      builder: (context, audioService, child) {
        final currentOfferingId = int.tryParse(audioService.currentSong?.id ?? '');
        return Scaffold(
          backgroundColor: const Color(0xFFF8F3EC),
          body: SafeArea(
            child: Column(
              children: [
                AppHeader(
                  streakCount: 0,
                  profileImageUrl:
                      auth.devotee?.avatarUrl.isNotEmpty == true
                          ? auth.devotee!.avatarUrl
                          : null,
                  onBackPressed: () => AppRoutes.replaceWithHome(context),
                ),
                ParayanTopTabNavigation(
                  activeTab: _activeTab,
                  onTabChanged: _handleTabChange,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: _activeTab == 0
                        ? _buildSaptahParayanTab()
                        : _buildAllAdhyayTab(auth.language),
                  ),
                ),
                if (audioService.currentSong != null)
                  PlayerDrawer(
                    songName: audioService.currentSong!.title,
                    songDetails: audioService.currentSong!.artist,
                    thumbnailUrl: audioService.currentSong!.thumbnailUrl,
                    isPlaying: audioService.isPlaying,
                    isSaved: favorites.isFavorite(currentOfferingId),
                    onPlayPausePressed: _handlePlayPause,
                    onSavePressed: _handleSave,
                    onTap: _handlePlayerTap,
                  ),
                BottomNavigation(
                  currentIndex: 0,
                  onTap: _handleNavigation,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSaptahParayanTab() {
    return ParayanMainContainer(
      children: [
        Container(
          margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color(0xFFFFFFFF),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF000000).withValues(alpha: 0.05),
                offset: const Offset(0, 1),
                blurRadius: 2,
              ),
            ],
          ),
          child: Column(
            children: [
              const Icon(
                Icons.calendar_month_outlined,
                size: 40,
                color: Color(0xFF9A4100),
              ),
              const SizedBox(height: 12),
              const Text(
                'Saptah Parayan',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                  color: Color(0xFF1D1C18),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Seven-day vow planning, sankalp and daily progress are coming in an upcoming update. '
                'Every chapter is already available in the All 51 Adhyays tab.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  height: 1.5,
                  color: Color(0xFF574238),
                ),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () => setState(() => _activeTab = 1),
                child: const Text('Browse all 51 Adhyays'),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAllAdhyayTab(String language) {
    final provider = context.watch<ChaptersProvider>();

    if (provider.isLoading && provider.chapters.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(40),
        child: Center(child: CircularProgressIndicator()),
      );
    }

    if (provider.error != null && provider.chapters.isEmpty) {
      return _buildErrorState(provider);
    }

    final chapters = _filteredChapters(provider.chapters);
    final recorded = provider.recordedCount;
    final total = provider.chapters.length;

    return Column(
      children: [
        _buildChapterSummary(total, recorded),
        const SizedBox(height: 8),
        SearchAndCategories(
          selectedCategory: _selectedCategory,
          onCategorySelected: _handleCategoryChange,
          onSearchChanged: _handleSearchChange,
          searchController: _searchController,
          categories: [
            SearchCategory('All', count: total),
            SearchCategory(AppStrings.recorded, count: recorded),
            SearchCategory(
              AppStrings.notRecorded,
              count: total - recorded,
            ),
          ],
        ),
        const SizedBox(height: 8),
        AdhyayListWidget(
          chapters: chapters,
          language: language,
          onListen: (chapter) => _playChapter(chapter, language),
          emptyMessage: _searchQuery.isNotEmpty
              ? 'No adhyay matches "$_searchQuery".'
              : null,
        ),
      ],
    );
  }

  List<Chapter> _filteredChapters(List<Chapter> chapters) {
    final recordedLabel = AppStrings.recorded;
    final notRecordedLabel = AppStrings.notRecorded;

    return chapters.where((chapter) {
      bool matchesCategory;
      if (_selectedCategory == recordedLabel) {
        matchesCategory = chapter.hasAudio;
      } else if (_selectedCategory == notRecordedLabel) {
        matchesCategory = !chapter.hasAudio;
      } else {
        matchesCategory = true;
      }
      if (!matchesCategory) return false;

      if (_searchQuery.isEmpty) return true;

      final haystack = [
        chapter.number.toString(),
        chapter.titleEn,
        chapter.titleHi,
        chapter.titleMr,
        chapter.summaryEn,
        chapter.summaryHi,
        chapter.summaryMr,
      ].join(' ').toLowerCase();

      return haystack.contains(_searchQuery);
    }).toList();
  }

  Widget _buildChapterSummary(int total, int recorded) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.fromLTRB(16, 12, 16, 0),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFF8F3EC), Color(0xFFFFDDB8)],
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF000000).withValues(alpha: 0.05),
            offset: const Offset(0, 1),
            blurRadius: 2,
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppStrings.satcharitaIndex,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                    letterSpacing: 0.28,
                    color: Color(0xFF1D1C18),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '$total • $recorded ${AppStrings.recorded}',
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    color: Color(0xFF574238),
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  'Audio is added chapter by chapter. Unrecorded chapters stay visible so the index is complete.',
                  style: TextStyle(
                    fontSize: 11,
                    height: 1.4,
                    color: Color(0xFF8A7267),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          const Icon(
            Icons.auto_stories,
            size: 40,
            color: Color(0xFF9A4100),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(ChaptersProvider provider) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        children: [
          const Icon(
            Icons.cloud_off,
            size: 36,
            color: Color(0xFF9A4100),
          ),
          const SizedBox(height: 12),
          Text(
            provider.error ?? 'The Satcharitra index could not be loaded.',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 13,
              height: 1.5,
              color: Color(0xFF574238),
            ),
          ),
          const SizedBox(height: 12),
          TextButton(
            onPressed: provider.refresh,
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  Future<void> _playChapter(Chapter chapter, String language) async {
    final recording = chapter.audio;
    if (recording == null || !recording.isPlayable) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Adhyay ${chapter.number} has not been recorded yet.',
          ),
        ),
      );
      return;
    }

    final song = Song(
      id: recording.id.toString(),
      title: chapter.titleFor(language),
      artist: recording.artistName,
      youtubeUrl: recording.youtubeUrl.isNotEmpty
          ? recording.youtubeUrl
          : 'https://www.youtube.com/watch?v=${recording.youtubeVideoId}',
      videoId: recording.youtubeVideoId,
      duration: recording.duration,
      category: 'Adhyay ${chapter.number}',
      thumbnailUrl:
          recording.thumbnailUrl.isNotEmpty ? recording.thumbnailUrl : null,
      isSaptahParayan: true,
    );

    await context.read<AudioService>().playSong(song);
    if (!mounted) return;
    context.read<CatalogRepository>().reportPlay(recording.id);
    AppRoutes.navigateToPlayer(context);
  }
}
