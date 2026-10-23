import 'package:flutter/foundation.dart';

import '../models/content.dart';
import '../models/offering.dart';
import '../network/api_exception.dart';
import '../repositories/catalog_repository.dart';
import '../repositories/content_repository.dart';

class ArtistSummary {
  const ArtistSummary({
    required this.id,
    required this.name,
    required this.initials,
    required this.recordingCount,
  });

  final int id;
  final String name;
  final String initials;
  final int recordingCount;

  ArtistSummary copyWith({int? recordingCount}) {
    return ArtistSummary(
      id: id,
      name: name,
      initials: initials,
      recordingCount: recordingCount ?? this.recordingCount,
    );
  }
}

/// The live Explore catalog: curated shelves, trending recordings and the
/// artists who actually have approved audio.
class CatalogProvider extends ChangeNotifier {
  CatalogProvider({
    required ContentRepository content,
    required CatalogRepository catalog,
  })  : _content = content,
        _catalog = catalog;

  final ContentRepository _content;
  final CatalogRepository _catalog;

  List<Collection> _collections = const [];
  List<Offering> _offerings = const [];
  bool _loading = false;
  String? _error;
  Future<void>? _loadFuture;

  List<Collection> get collections => _collections;
  List<Offering> get offerings => _offerings;
  bool get isLoading => _loading;
  String? get error => _error;

  List<Offering> get trending {
    final playable = _offerings.where((offering) => offering.isPlayable).toList();
    playable.sort((a, b) => b.playCount.compareTo(a.playCount));
    return playable.take(10).toList();
  }

  List<ArtistSummary> get artists {
    final byArtist = <int, ArtistSummary>{};
    for (final offering in _offerings) {
      if (!offering.isPlayable) continue;
      final existing = byArtist[offering.artistId];
      if (existing == null) {
        byArtist[offering.artistId] = ArtistSummary(
          id: offering.artistId,
          name: offering.artistName,
          initials: offering.artistInitials,
          recordingCount: 1,
        );
      } else {
        byArtist[offering.artistId] = existing.copyWith(
          recordingCount: existing.recordingCount + 1,
        );
      }
    }
    final list = byArtist.values.toList();
    list.sort((a, b) => b.recordingCount.compareTo(a.recordingCount));
    return list;
  }

  Future<void> ensureLoaded() => _loadFuture ??= _load();

  Future<void> refresh() {
    _loadFuture = null;
    return ensureLoaded();
  }

  Future<void> _load() async {
    _loading = true;
    _error = null;
    notifyListeners();

    try {
      final results = await Future.wait([
        _content.collections(),
        _catalog.offerings(limit: 200),
      ]);
      _collections = results[0] as List<Collection>;
      _offerings = (results[1] as OfferingPage).items;
    } on ApiException catch (error) {
      _error = error.message;
    } catch (_) {
      _error = 'The sacred catalog could not be loaded.';
    } finally {
      _loading = false;
      notifyListeners();
    }
  }
}
