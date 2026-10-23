import 'package:flutter/foundation.dart';

import '../models/content.dart';
import '../network/api_exception.dart';
import '../repositories/content_repository.dart';

/// Loads the 51 Satcharitra chapters once and keeps them for every parayan
/// surface. Audio availability travels with each chapter.
class ChaptersProvider extends ChangeNotifier {
  ChaptersProvider({required ContentRepository content}) : _content = content;

  final ContentRepository _content;

  List<Chapter> _chapters = const [];
  bool _loading = false;
  String? _error;
  Future<void>? _loadFuture;

  List<Chapter> get chapters => _chapters;
  bool get isLoading => _loading;
  String? get error => _error;
  int get recordedCount => _chapters.where((chapter) => chapter.hasAudio).length;

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
      _chapters = await _content.chapters();
    } on ApiException catch (error) {
      _error = error.message;
    } catch (_) {
      _error = 'The Satcharitra index could not be loaded.';
    } finally {
      _loading = false;
      notifyListeners();
    }
  }
}
