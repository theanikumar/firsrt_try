import 'package:flutter/foundation.dart';

import '../../utils/app_strings.dart';
import '../models/devotee.dart';
import '../network/api_client.dart';
import '../network/api_exception.dart';
import '../repositories/auth_repository.dart';
import '../storage/token_store.dart';

/// Owns the devotee session: restore on launch, OTP sign-in, refresh and
/// onboarding state. The UI listens to this provider.
class AuthProvider extends ChangeNotifier {
  AuthProvider({
    required AuthRepository auth,
    required TokenStore tokenStore,
    required ApiClient api,
  })  : _auth = auth,
        _tokenStore = tokenStore,
        _api = api {
    _api.onRefresh = _refreshSession;
  }

  final AuthRepository _auth;
  final TokenStore _tokenStore;
  final ApiClient _api;

  Devotee? _devotee;
  bool _initialized = false;
  bool _busy = false;
  String? _error;
  Future<void>? _restoreFuture;
  Future<String?>? _refreshFuture;

  Devotee? get devotee => _devotee;
  bool get isInitialized => _initialized;
  bool get isBusy => _busy;
  String? get error => _error;
  bool get isAuthenticated => _devotee != null;
  bool get needsOnboarding =>
      _devotee != null && !_devotee!.onboardingCompleted;
  String get language => _devotee?.language ?? 'en';
  String get displayName => _devotee?.name ?? 'Devotee';
  String get initials => _devotee?.initials ?? 'SV';

  /// Called by the splash screen. Safe to call more than once.
  Future<void> ensureInitialized() {
    return _restoreFuture ??= _restore();
  }

  Future<void> _restore() async {
    try {
      final access = await _tokenStore.readAccess();
      if (access == null || access.isEmpty) {
        _devotee = null;
        return;
      }

      final cached = await _tokenStore.readDevotee();
      if (cached != null) {
        _devotee = Devotee.fromJson(cached);
        AppStrings.setLanguage(_devotee!.language);
      }

      try {
        await _loadMe();
      } on ApiException catch (error) {
        if (error.isUnauthorized) {
          final token = await _refreshSession();
          if (token != null) {
            await _loadMe();
          } else {
            await _clearSession();
          }
        }
        // Network failures keep the cached profile; the next request retries.
      }
    } finally {
      _initialized = true;
      notifyListeners();
    }
  }

  Future<void> _loadMe() async {
    final response = await _auth.me();
    final raw = response['devotee'];
    if (raw is Map) {
      _devotee = Devotee.fromJson(Map<String, dynamic>.from(raw));
      AppStrings.setLanguage(_devotee!.language);
      await _tokenStore.saveDevotee(_devotee!.toJson());
      notifyListeners();
    }
  }

  /// Requests a code. Returns the development code when the API exposes one.
  Future<String?> requestOtp(String phone) async {
    _setBusy(true);
    try {
      final response = await _auth.requestOtp(phone);
      final code = response['dev_code'];
      return code is String && code.isNotEmpty ? code : null;
    } on ApiException catch (error) {
      _error = error.message;
      rethrow;
    } finally {
      _setBusy(false);
    }
  }

  Future<void> verifyOtp(
    String phone,
    String code, {
    String? name,
  }) async {
    _setBusy(true);
    try {
      final session = await _auth.verifyOtp(phone, code, name: name);
      await _applySession(session);
    } on ApiException catch (error) {
      _error = error.message;
      rethrow;
    } finally {
      _setBusy(false);
    }
  }

  Future<void> completeOnboarding(String language) async {
    _setBusy(true);
    try {
      final response = await _auth.completeOnboarding(language);
      final raw = response['devotee'];
      if (raw is Map) {
        _devotee = Devotee.fromJson(Map<String, dynamic>.from(raw));
        AppStrings.setLanguage(_devotee!.language);
        await _tokenStore.saveDevotee(_devotee!.toJson());
        notifyListeners();
      }
    } on ApiException catch (error) {
      _error = error.message;
      rethrow;
    } finally {
      _setBusy(false);
    }
  }

  Future<void> updateProfile({
    String? displayName,
    String? email,
    String? language,
  }) async {
    _setBusy(true);
    try {
      final response = await _auth.updateMe(
        displayName: displayName,
        email: email,
        language: language,
      );
      final raw = response['devotee'];
      if (raw is Map) {
        _devotee = Devotee.fromJson(Map<String, dynamic>.from(raw));
        AppStrings.setLanguage(_devotee!.language);
        await _tokenStore.saveDevotee(_devotee!.toJson());
        notifyListeners();
      }
    } on ApiException catch (error) {
      _error = error.message;
      rethrow;
    } finally {
      _setBusy(false);
    }
  }

  Future<void> logout() async {
    final refresh = await _tokenStore.readRefresh();
    if (refresh != null && refresh.isNotEmpty) {
      try {
        await _auth.logout(refresh);
      } catch (_) {
        // Local sign-out must succeed even if the network is down.
      }
    }
    await _clearSession();
  }

  Future<void> _applySession(Map<String, dynamic> session) async {
    final raw = session['devotee'];
    if (raw is Map) {
      _devotee = Devotee.fromJson(Map<String, dynamic>.from(raw));
      AppStrings.setLanguage(_devotee!.language);
    }
    await _tokenStore.saveSession(session);
    notifyListeners();
  }

  Future<String?> _refreshSession() {
    return _refreshFuture ??= _doRefresh().whenComplete(() {
      _refreshFuture = null;
    });
  }

  Future<String?> _doRefresh() async {
    final refresh = await _tokenStore.readRefresh();
    if (refresh == null || refresh.isEmpty) return null;
    try {
      final session = await _auth.refresh(refresh);
      await _applySession(session);
      final token = session['access_token'];
      return token is String ? token : null;
    } on ApiException {
      await _clearSession();
      return null;
    }
  }

  Future<void> _clearSession() async {
    await _tokenStore.clear();
    _devotee = null;
    notifyListeners();
  }

  void _setBusy(bool value) {
    _busy = value;
    if (value) _error = null;
    notifyListeners();
  }
}
