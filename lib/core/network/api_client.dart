import 'package:dio/dio.dart';

import '../config/app_config.dart';
import '../storage/token_store.dart';
import 'api_exception.dart';

typedef RefreshCallback = Future<String?> Function();

/// Thin wrapper around Dio that attaches the devotee access token and retries
/// once after a refresh when a request comes back 401.
class ApiClient {
  ApiClient({required this.tokenStore}) {
    _dio = Dio(
      BaseOptions(
        baseUrl: AppConfig.apiBaseUrl,
        connectTimeout: const Duration(seconds: 12),
        receiveTimeout: const Duration(seconds: 20),
        headers: {'Accept': 'application/json'},
      ),
    );
  }

  final TokenStore tokenStore;
  late final Dio _dio;
  RefreshCallback? onRefresh;

  Future<dynamic> get(
    String path, {
    Map<String, dynamic>? query,
    bool authenticated = true,
  }) {
    return request('GET', path,
        query: query, authenticated: authenticated);
  }

  Future<dynamic> post(
    String path, {
    Object? data,
    bool authenticated = true,
  }) {
    return request('POST', path, data: data, authenticated: authenticated);
  }

  Future<dynamic> patch(
    String path, {
    Object? data,
    bool authenticated = true,
  }) {
    return request('PATCH', path, data: data, authenticated: authenticated);
  }

  Future<dynamic> request(
    String method,
    String path, {
    Object? data,
    Map<String, dynamic>? query,
    bool authenticated = true,
    bool retry = true,
  }) async {
    final headers = <String, dynamic>{};
    if (authenticated) {
      final token = await tokenStore.readAccess();
      if (token != null && token.isNotEmpty) {
        headers['Authorization'] = 'Bearer $token';
      }
    }

    try {
      final response = await _dio.request(
        path,
        data: data,
        queryParameters: query,
        options: Options(method: method, headers: headers),
      );
      return response.data;
    } on DioException catch (error) {
      final canRefresh = authenticated &&
          retry &&
          error.response?.statusCode == 401 &&
          onRefresh != null;
      if (canRefresh) {
        final token = await onRefresh!();
        if (token != null && token.isNotEmpty) {
          return request(
            method,
            path,
            data: data,
            query: query,
            authenticated: authenticated,
            retry: false,
          );
        }
      }
      throw ApiException.fromDio(error);
    }
  }
}
