import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../common/app_header.dart';
import '../../common/bottom_navigation.dart';
import '../../common/player_drawer.dart';
import '../../core/auth/auth_provider.dart';
import '../../core/catalog/catalog_provider.dart';
import '../../core/models/content.dart';
import '../../core/models/offering.dart';
import '../../core/repositories/catalog_repository.dart';
import '../../routes/app_routes.dart';
import '../../services/audio_service.dart';
import '../widgets/explore_collections.dart';
import '../widgets/explore_search_bar.dart';
import '../widgets/explore_trending_bhajans.dart';
import '../widgets/explore_vocal_masters.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  bool _isSaved = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<CatalogProvider>().ensureLoaded();
      }
    });
  }

  void _handleNavigation(int index) {
    if (index == 1) return;

    switch (index) {
      case 0:
        AppRoutes.replaceWithParayan(context);
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

  void _handleSave() {
    setState(() => _isSaved = !_isSaved);
  }

  void _handlePlayerTap() {
    AppRoutes.navigateToPlayer(context);
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    final catalog = context.watch<CatalogProvider>();

    return Consumer<AudioService>(
      builder: (context, audioService, child) {
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
                Expanded(
                  child: _buildBody(catalog, auth.language),
                ),
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
                BottomNavigation(
                  currentIndex: 1,
                  onTap: _handleNavigation,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildBody(CatalogProvider catalog, String language) {
    if (catalog.isLoading &&
        catalog.collections.isEmpty &&
        catalog.offerings.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (catalog.error != null &&
        catalog.collections.isEmpty &&
        catalog.offerings.isEmpty) {
      return _buildErrorState(catalog);
    }

    final collections = catalog.collections;
    final artists = catalog.artists;
    final trending = catalog.trending;
    final unsupportedLanguage = !const ['en', 'hi', 'mr'].contains(language);

    return RefreshIndicator(
      onRefresh: catalog.refresh,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            if (unsupportedLanguage) ...[
              _buildLanguageNotice(language),
              const SizedBox(height: 12),
            ],
            ExploreSearchBar(
              onSearchTap: () => _showSearchSheet(catalog.offerings),
            ),
            const SizedBox(height: 16),
            if (collections.isNotEmpty)
              ExploreCollections(
                totalCollections: collections.length,
                collections: collections.map(_collectionData).toList(),
                onCollectionTap: (index) =>
                    _showOfferingsSheet(collections[index].title,
                        collections[index].items),
              ),
            if (collections.isNotEmpty) const SizedBox(height: 16),
            if (artists.isNotEmpty)
              ExploreVocalMasters(
                singers: artists
                    .take(10)
                    .map(
                      (artist) => SingerData(
                        name: artist.name,
                        category:
                            '${artist.recordingCount} recording${artist.recordingCount == 1 ? '' : 's'}',
                      ),
                    )
                    .toList(),
                onViewAllTap: () => _showAllArtists(artists, catalog.offerings),
                onSingerTap: (index) {
                  final artist = artists[index];
                  _showOfferingsSheet(
                    artist.name,
                    catalog.offerings
                        .where((offering) => offering.artistId == artist.id)
                        .toList(),
                  );
                },
              ),
            if (artists.isNotEmpty) const SizedBox(height: 16),
            if (trending.isNotEmpty)
              ExploreTrendingBhajans(
                songs: trending.map(_trendingData).toList(),
                onPlaySong: (_, __) => AppRoutes.navigateToPlayer(context),
                onSongPlayed: (song) {
                  final id = int.tryParse(song.id);
                  if (id != null) {
                    context.read<CatalogRepository>().reportPlay(id);
                  }
                },
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorState(CatalogProvider catalog) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.cloud_off, size: 36, color: Color(0xFF9A4100)),
            const SizedBox(height: 12),
            Text(
              catalog.error ?? 'The sacred catalog could not be loaded.',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 13,
                height: 1.5,
                color: Color(0xFF574238),
              ),
            ),
            const SizedBox(height: 12),
            TextButton(
              onPressed: catalog.refresh,
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageNotice(String language) {
    final name = _languageName(language);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF3E0),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE8C9A0)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.info_outline, size: 18, color: Color(0xFF9A4100)),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              '$name is saved, but its interface is still being prepared. '
              'You can browse and play every available recording in the meantime.',
              style: const TextStyle(
                fontSize: 12,
                height: 1.5,
                color: Color(0xFF574238),
              ),
            ),
          ),
        ],
      ),
    );
  }

  CollectionData _collectionData(Collection collection) {
    final accent = _parseColor(collection.accent);
    return CollectionData(
      icon: _iconFor(collection.icon),
      iconBackgroundColor: accent.withValues(alpha: 0.15),
      categoryName: collection.playableCount > 0
          ? '${collection.playableCount} recording${collection.playableCount == 1 ? '' : 's'}'
          : 'Not yet recorded',
      categoryBackgroundColor: accent.withValues(alpha: 0.12),
      categoryTextColor: accent,
      title: collection.title,
      subtitle: collection.subtitle,
      circleColor: accent.withValues(alpha: 0.18),
    );
  }

  TrendingSongData _trendingData(Offering offering) {
    return TrendingSongData(
      title: offering.title,
      artist: offering.artistName,
      duration: _formatDuration(offering.duration),
      category: _categoryLabel(offering.category),
      song: _toSong(offering),
    );
  }

  Song _toSong(Offering offering) {
    return Song(
      id: offering.id.toString(),
      title: offering.title,
      artist: offering.artistName,
      youtubeUrl: offering.youtubeUrl.isNotEmpty
          ? offering.youtubeUrl
          : 'https://www.youtube.com/watch?v=${offering.youtubeVideoId}',
      videoId: offering.youtubeVideoId,
      duration: offering.duration,
      category: _categoryLabel(offering.category),
      thumbnailUrl:
          offering.thumbnailUrl.isNotEmpty ? offering.thumbnailUrl : null,
      isSaptahParayan: offering.offeringType == 'parayan',
    );
  }

  Future<void> _playOffering(Offering offering) async {
    if (!offering.isPlayable) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('This recording is not available yet.')),
      );
      return;
    }

    await context.read<AudioService>().playSong(_toSong(offering));
    if (!mounted) return;
    context.read<CatalogRepository>().reportPlay(offering.id);
    AppRoutes.navigateToPlayer(context);
  }

  void _showSearchSheet(List<Offering> offerings) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) {
        return _CatalogSearchSheet(
          offerings: offerings,
          onPlay: (offering) {
            Navigator.pop(sheetContext);
            _playOffering(offering);
          },
        );
      },
    );
  }

  void _showOfferingsSheet(String title, List<Offering> offerings) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) {
        return _OfferingsSheet(
          title: title,
          offerings: offerings,
          onPlay: (offering) {
            Navigator.pop(sheetContext);
            _playOffering(offering);
          },
        );
      },
    );
  }

  void _showAllArtists(List<ArtistSummary> artists, List<Offering> offerings) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) {
        return _ArtistsSheet(
          artists: artists,
          onTap: (artist) {
            Navigator.pop(sheetContext);
            _showOfferingsSheet(
              artist.name,
              offerings
                  .where((offering) => offering.artistId == artist.id)
                  .toList(),
            );
          },
        );
      },
    );
  }
}

class _CatalogSearchSheet extends StatefulWidget {
  const _CatalogSearchSheet({
    required this.offerings,
    required this.onPlay,
  });

  final List<Offering> offerings;
  final ValueChanged<Offering> onPlay;

  @override
  State<_CatalogSearchSheet> createState() => _CatalogSearchSheetState();
}

class _CatalogSearchSheetState extends State<_CatalogSearchSheet> {
  final TextEditingController _controller = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final query = _query.toLowerCase();
    final results = widget.offerings.where((offering) {
      if (query.isEmpty) return true;
      return [
        offering.title,
        offering.artistName,
        offering.category,
        offering.lang,
        offering.raga,
      ].join(' ').toLowerCase().contains(query);
    }).take(50).toList();

    return _SheetShell(
      title: 'Search the catalog',
      child: Column(
        children: [
          TextField(
            controller: _controller,
            autofocus: true,
            onChanged: (value) => setState(() => _query = value.trim()),
            decoration: InputDecoration(
              hintText: 'Search bhajans, aartis, artists',
              prefixIcon: const Icon(Icons.search),
              filled: true,
              fillColor: const Color(0xFFF8F3EC),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(9999),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: results.isEmpty
                ? const Center(
                    child: Text(
                      'No matching recordings yet.',
                      style: TextStyle(color: Color(0xFF8A7267)),
                    ),
                  )
                : ListView.separated(
                    itemCount: results.length,
                    separatorBuilder: (_, __) => const Divider(height: 1),
                    itemBuilder: (context, index) {
                      return _OfferingRow(
                        offering: results[index],
                        onPlay: () => widget.onPlay(results[index]),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

class _OfferingsSheet extends StatelessWidget {
  const _OfferingsSheet({
    required this.title,
    required this.offerings,
    required this.onPlay,
  });

  final String title;
  final List<Offering> offerings;
  final ValueChanged<Offering> onPlay;

  @override
  Widget build(BuildContext context) {
    return _SheetShell(
      title: title,
      child: offerings.isEmpty
          ? const Center(
              child: Text(
                'No recordings in this collection yet.',
                style: TextStyle(color: Color(0xFF8A7267)),
              ),
            )
          : ListView.separated(
              itemCount: offerings.length,
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemBuilder: (context, index) {
                return _OfferingRow(
                  offering: offerings[index],
                  onPlay: () => onPlay(offerings[index]),
                );
              },
            ),
    );
  }
}

class _ArtistsSheet extends StatelessWidget {
  const _ArtistsSheet({
    required this.artists,
    required this.onTap,
  });

  final List<ArtistSummary> artists;
  final ValueChanged<ArtistSummary> onTap;

  @override
  Widget build(BuildContext context) {
    return _SheetShell(
      title: 'Vocal Masters',
      child: ListView.separated(
        itemCount: artists.length,
        separatorBuilder: (_, __) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final artist = artists[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: const Color(0xFFFFDBCB),
              child: Text(
                artist.initials,
                style: const TextStyle(
                  color: Color(0xFF783100),
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            title: Text(artist.name),
            subtitle: Text(
              '${artist.recordingCount} recording${artist.recordingCount == 1 ? '' : 's'}',
            ),
            onTap: () => onTap(artist),
          );
        },
      ),
    );
  }
}

class _OfferingRow extends StatelessWidget {
  const _OfferingRow({
    required this.offering,
    required this.onPlay,
  });

  final Offering offering;
  final VoidCallback onPlay;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: const Color(0xFFFFDBCB),
        child: const Icon(Icons.music_note, color: Color(0xFF783100)),
      ),
      title: Text(
        offering.title,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        '${offering.artistName} • ${_categoryLabel(offering.category)}',
      ),
      trailing: offering.isPlayable
          ? IconButton(
              icon: const Icon(Icons.play_arrow),
              color: const Color(0xFF9A4100),
              onPressed: onPlay,
            )
          : const Text(
              'Not recorded',
              style: TextStyle(fontSize: 11, color: Color(0xFF8A7267)),
            ),
      onTap: offering.isPlayable ? onPlay : null,
    );
  }
}

class _SheetShell extends StatelessWidget {
  const _SheetShell({
    required this.title,
    required this.child,
  });

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.8,
      minChildSize: 0.4,
      maxChildSize: 0.95,
      expand: false,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: Color(0xFFFFFFFF),
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
          child: Column(
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: const Color(0xFFD9D2C8),
                  borderRadius: BorderRadius.circular(9999),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                        color: Color(0xFF1D1C18),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Expanded(
                child: PrimaryScrollController(
                  controller: scrollController,
                  child: child,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

IconData _iconFor(String name) {
  switch (name) {
    case 'wb_sunny':
      return Icons.wb_sunny;
    case 'music_note':
      return Icons.music_note;
    case 'menu_book':
      return Icons.menu_book;
    case 'self_improvement':
      return Icons.self_improvement;
    case 'wb_twilight':
      return Icons.wb_twilight;
    case 'nights_stay':
      return Icons.nights_stay;
    default:
      return Icons.auto_stories;
  }
}

Color _parseColor(String value) {
  final cleaned = value.replaceFirst('#', '');
  final parsed = int.tryParse(cleaned, radix: 16);
  if (parsed == null) return const Color(0xFF9A4100);
  return Color(0xFF000000 | parsed);
}

String _formatDuration(Duration duration) {
  final minutes = duration.inMinutes;
  final seconds = duration.inSeconds.remainder(60);
  return '$minutes:${seconds.toString().padLeft(2, '0')}';
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

String _languageName(String code) {
  switch (code) {
    case 'hi':
      return 'Hindi';
    case 'mr':
      return 'Marathi';
    case 'te':
      return 'Telugu';
    case 'gu':
      return 'Gujarati';
    case 'or':
      return 'Odia';
    default:
      return 'English';
  }
}
