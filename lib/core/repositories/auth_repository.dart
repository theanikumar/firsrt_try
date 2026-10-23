import '../network/api_client.dart';

class AuthRepository {
  AuthRepository({required ApiClient api}) : _api = api;

  final ApiClient _api;

  Future<Map<String, dynamic>> requestOtp(String phone) async {
    final data = await _api.post(
      '/devotee/auth/otp/request',
      data: {'phone': phone},
      authenticated: false,
    );
    return Map<String, dynamic>.from(data as Map);
  }

  Future<Map<String, dynamic>> verifyOtp(
    String phone,
    String code, {
    String? name,
  }) async {
    final data = await _api.post(
      '/devotee/auth/otp/verify',
      data: {
        'phone': phone,
        'code': code,
        if (name != null && name.trim().isNotEmpty) 'name': name.trim(),
      },
      authenticated: false,
    );
    return Map<String, dynamic>.from(data as Map);
  }

  Future<Map<String, dynamic>> refresh(String refreshToken) async {
    final data = await _api.post(
      '/devotee/auth/refresh',
      data: {'refresh_token': refreshToken},
      authenticated: false,
    );
    return Map<String, dynamic>.from(data as Map);
  }

  Future<void> logout(String refreshToken) async {
    if (refreshToken.isEmpty) return;
    await _api.post(
      '/devotee/auth/logout',
      data: {'refresh_token': refreshToken},
      authenticated: false,
    );
  }

  Future<Map<String, dynamic>> me() async {
    final data = await _api.get('/devotee/me');
    return Map<String, dynamic>.from(data as Map);
  }

  Future<Map<String, dynamic>> updateMe({
    String? displayName,
    String? email,
    String? language,
  }) async {
    final data = await _api.patch(
      '/devotee/me',
      data: {
        if (displayName != null) 'display_name': displayName,
        if (email != null) 'email': email,
        if (language != null) 'language': language,
      },
    );
    return Map<String, dynamic>.from(data as Map);
  }

  Future<Map<String, dynamic>> completeOnboarding(String language) async {
    final data = await _api.post(
      '/devotee/onboarding',
      data: {'language': language},
    );
    return Map<String, dynamic>.from(data as Map);
  }
}
