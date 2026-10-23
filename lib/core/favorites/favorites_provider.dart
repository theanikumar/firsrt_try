import 'package:flutter/foundation.dart';

import '../models/offering.dart';
import '../network/api_exception.dart';
import '../repositories/favorites_repository.dart';

/// Keeps the devotee's saved offerings in sync with the server. The heart
/// state is optimistic; a failed request rolls the local change back.
class FavoritesProvider extends ChangeNotifier {
  FavoritesProvider({required FavoritesRepository favorites})
      : _favorites = favorites;

  final FavoritesRepository _favorites;

  List<Offering> _items = const [];
  final Set<int> _ids = {};
  bool _loading = false;
  String? _error;
  Future<void>? _loadFuture;

  List<Offering> get items => _items;
  bool get isLoading => _loading;
  String? get error => _error;
  int get count => _ids.length;

  bool isFavorite(int? offeringId) =>
      offeringId != null && _ids.contains(offeringId);

  Future<void> ensureLoaded() => _loadFuture ??= _load();

  Future<void> refresh() {
    _loadFuture = null;
    return ensureLoaded();
  }

  /// Clears the in-memory cache when the devotee signs out.
  void clear() {
    _items = const [];
    _ids.clear();
    _loadFuture = null;
    _error = null;
    _loading = false;
    notifyListeners();
  }

  Future<void> _load() async {
    _loading = true;
    _error = null;
    notifyListeners();

    try {
      final items = await _favorites.list();
      _items = items;
      _ids
        ..clear()
        ..addAll(items.map((item) => item.id));
    } on ApiException catch (error) {
      _error = error.message;
    } catch (_) {
      _error = 'Your saved offerings could not be loaded.';
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  /// Toggles a favorite. Pass [offering] when available so the Saved list can
  /// update without a round-trip; otherwise it is refreshed after saving.
  Future<void> toggle(int offeringId, {Offering? offering}) async {
    final wasFavorite = _ids.contains(offeringId);
    final previousItems = _items;

    if (wasFavorite) {
      _ids.remove(offeringId);
      _items = _items.where((item) => item.id != offeringId).toList();
    } else {
      _ids.add(offeringId);
      if (offering != null) {
        _items = [offering, ..._items];
      }
    }
    notifyListeners();

    try {
      if (wasFavorite) {
        await _favorites.remove(offeringId);
      } else {
        await _favorites.add(offeringId);
        if (offering == null) {
          await refresh();
        }
      }
    } catch (_) {
      _items = previousItems;
      if (wasFavorite) {
        _ids.add(offeringId);
      } else {
        _ids.remove(offeringId);
      }
      notifyListeners();
      rethrow;
    }
  }
}
