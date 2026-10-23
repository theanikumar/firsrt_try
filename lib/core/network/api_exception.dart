import 'package:dio/dio.dart';

/// A user-presentable error returned by the Sai Vani API.
class ApiException implements Exception {
  ApiException({
    required this.message,
    this.statusCode,
    this.code = 'network_error',
    this.fields = const {},
  });

  final String message;
  final int? statusCode;
  final String code;
  final Map<String, String> fields;

  bool get isUnauthorized => statusCode == 401;

  factory ApiException.fromDio(DioException error) {
    final response = error.response;
    final data = response?.data;

    if (data is Map && data['error'] is Map) {
      final body = data['error'] as Map;
      final rawFields = body['fields'];
      final fields = <String, String>{};
      if (rawFields is Map) {
        for (final entry in rawFields.entries) {
          fields[entry.key.toString()] = entry.value.toString();
        }
      }
      return ApiException(
        statusCode: response?.statusCode,
        code: (body['code'] ?? 'request_failed').toString(),
        message: (body['message'] ?? 'Something went wrong.').toString(),
        fields: fields,
      );
    }

    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return ApiException(
          message: 'The connection timed out. Please try again.',
          statusCode: response?.statusCode,
        );
      case DioExceptionType.connectionError:
        return ApiException(
          message: 'Could not reach Sai Vani. Check your connection.',
          statusCode: response?.statusCode,
        );
      default:
        return ApiException(
          message: 'Something went wrong. Please try again.',
          statusCode: response?.statusCode,
        );
    }
  }

  @override
  String toString() => message;
}
