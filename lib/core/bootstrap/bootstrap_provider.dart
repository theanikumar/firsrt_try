import 'package:flutter/foundation.dart';

import '../models/bootstrap.dart';
import '../models/content.dart';
import '../models/offering.dart';
import '../network/api_exception.dart';
import '../repositories/catalog_repository.dart';
import '../repositories/content_repository.dart';

/// Loads the public bootstrap payload, quote of the day and a few melodies.
/// The home screen renders directly from this provider.
class BootstrapProvider extends ChangeNotifier {
  BootstrapProvider({
    required ContentRepository content,
    required CatalogRepository catalog,
  })  : _content = content,
        _catalog = catalog;

  final ContentRepository _content;
  final CatalogRepository _catalog;

  BootstrapData? _data;
  DailyQuote? _quote;
  List<Offering> _melodies = const [];
  bool _loading = false;
  String? _error;
  Future<void>? _loadFuture;

  BootstrapData? get data => _data;
  DailyQuote? get quote => _quote;
  List<Offering> get melodies => _melodies;
  bool get isLoading => _loading;
  String? get error => _error;
  bool get isReady => _data != null;

  LiveStream? get primaryLiveStream => _data?.primaryLiveStream;

  List<LanguageOption> get languages => _data?.languages ?? const [];

  Future<void> ensureLoaded() {
    if (_data != null) return Future.value();
    return _loadFuture ??= load().whenComplete(() {
      _loadFuture = null;
    });
  }

  Future<void> load() async {
    _loading = true;
    _error = null;
    notifyListeners();

    try {
      _data = await _content.bootstrap();

      try {
        _quote = await _content.dailyQuote();
      } catch (_) {
        _quote = null;
      }

      try {
        final page = await _catalog.offerings(type: 'music', limit: 50);
        _melodies = page.items
            .where((offering) => offering.isPlayable)
            .take(6)
            .toList();
      } catch (_) {
        _melodies = const [];
      }
    } on ApiException catch (error) {
      _error = error.message;
    } catch (_) {
      _error = 'Could not load Sai Vani content. Please try again.';
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<void> refresh() => load();
}
