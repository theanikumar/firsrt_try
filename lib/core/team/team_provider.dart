import 'package:flutter/foundation.dart';

import '../models/content.dart';
import '../network/api_exception.dart';
import '../repositories/content_repository.dart';

class TeamProvider extends ChangeNotifier {
  TeamProvider({required ContentRepository content}) : _content = content;

  final ContentRepository _content;

  List<TeamMember> _members = const [];
  bool _loading = false;
  String? _error;
  Future<void>? _loadFuture;

  List<TeamMember> get members => _members;
  bool get isLoading => _loading;
  String? get error => _error;

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
      _members = await _content.team();
    } on ApiException catch (error) {
      _error = error.message;
    } catch (_) {
      _error = 'The seva team could not be loaded.';
    } finally {
      _loading = false;
      notifyListeners();
    }
  }
}
