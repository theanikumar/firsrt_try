import 'package:flutter/foundation.dart';

/// Build-time configuration.
///
/// Override the API host with:
///   flutter run --dart-define=API_BASE_URL=http://192.168.1.10:8080/api/v1
class AppConfig {
  static const String appName = 'Sai Vani';

  static const String _override = String.fromEnvironment('API_BASE_URL');

  static String get apiBaseUrl {
    if (_override.isNotEmpty) {
      return _override;
    }
    if (kIsWeb) {
      return 'http://127.0.0.1:8080/api/v1';
    }
    if (defaultTargetPlatform == TargetPlatform.android) {
      // Android emulators reach the host machine through 10.0.2.2.
      return 'http://10.0.2.2:8080/api/v1';
    }
    return 'http://127.0.0.1:8080/api/v1';
  }
}
