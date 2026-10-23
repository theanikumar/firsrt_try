import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Persists the mobile session. Tokens are kept in the platform keystore; the
/// cached devotee profile is stored alongside them so the first frame can show
/// the right name before the network answers.
class TokenStore {
  TokenStore({FlutterSecureStorage? storage})
      : _storage = storage ?? const FlutterSecureStorage();

  static const _accessKey = 'sv_access_token';
  static const _refreshKey = 'sv_refresh_token';
  static const _devoteeKey = 'sv_devotee';

  final FlutterSecureStorage _storage;

  Future<String?> readAccess() => _read(_accessKey);

  Future<String?> readRefresh() => _read(_refreshKey);

  Future<Map<String, dynamic>?> readDevotee() async {
    final raw = await _read(_devoteeKey);
    if (raw == null || raw.isEmpty) return null;
    try {
      final decoded = jsonDecode(raw);
      if (decoded is Map<String, dynamic>) return decoded;
    } catch (_) {
      // A corrupt cache is safe to discard.
    }
    return null;
  }

  Future<void> saveSession(Map<String, dynamic> session) async {
    final access = session['access_token'];
    final refresh = session['refresh_token'];
    final devotee = session['devotee'];

    if (access is String && access.isNotEmpty) {
      await _write(_accessKey, access);
    }
    if (refresh is String && refresh.isNotEmpty) {
      await _write(_refreshKey, refresh);
    }
    if (devotee is Map) {
      await saveDevotee(Map<String, dynamic>.from(devotee));
    }
  }

  Future<void> saveDevotee(Map<String, dynamic> devotee) async {
    await _write(_devoteeKey, jsonEncode(devotee));
  }

  Future<void> clear() async {
    await _delete(_accessKey);
    await _delete(_refreshKey);
    await _delete(_devoteeKey);
  }

  Future<String?> _read(String key) async {
    try {
      return await _storage.read(key: key);
    } catch (_) {
      // Keystore can be unavailable on a fresh desktop boot. Treat it as a
      // signed-out session rather than crashing the splash screen.
      return null;
    }
  }

  Future<void> _write(String key, String value) async {
    try {
      await _storage.write(key: key, value: value);
    } catch (_) {
      // The in-memory session still works for this launch.
    }
  }

  Future<void> _delete(String key) async {
    try {
      await _storage.delete(key: key);
    } catch (_) {
      // Nothing to clean up.
    }
  }
}
