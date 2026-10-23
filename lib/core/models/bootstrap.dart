import 'content.dart';

class AppInfo {
  const AppInfo({
    required this.name,
    required this.minVersion,
    required this.supportEmail,
    required this.maintenance,
  });

  final String name;
  final String minVersion;
  final String supportEmail;
  final bool maintenance;

  factory AppInfo.fromJson(Map<String, dynamic> json) {
    return AppInfo(
      name: (json['name'] ?? 'Sai Vani').toString(),
      minVersion: (json['min_version'] ?? '1.0.0').toString(),
      supportEmail: (json['support_email'] ?? '').toString(),
      maintenance: json['maintenance'] == true,
    );
  }
}

class FeatureFlags {
  const FeatureFlags({
    required this.favorites,
    required this.sankalp,
    required this.offline,
    required this.googleSignIn,
    required this.feedback,
    required this.liveDarshan,
    required this.parayan,
    required this.dailyQuote,
  });

  final bool favorites;
  final bool sankalp;
  final bool offline;
  final bool googleSignIn;
  final bool feedback;
  final bool liveDarshan;
  final bool parayan;
  final bool dailyQuote;

  factory FeatureFlags.fromJson(Map<String, dynamic> json) {
    return FeatureFlags(
      favorites: json['favorites'] == true,
      sankalp: json['sankalp'] == true,
      offline: json['offline'] == true,
      googleSignIn: json['google_signin'] == true,
      feedback: json['feedback'] == true,
      liveDarshan: json['live_darshan'] == true,
      parayan: json['parayan'] == true,
      dailyQuote: json['daily_quote'] == true,
    );
  }
}

class LanguageOption {
  const LanguageOption({
    required this.code,
    required this.name,
    required this.nativeName,
    required this.uiReady,
    required this.audioReady,
  });

  final String code;
  final String name;
  final String nativeName;
  final bool uiReady;
  final bool audioReady;

  factory LanguageOption.fromJson(Map<String, dynamic> json) {
    return LanguageOption(
      code: (json['code'] ?? '').toString(),
      name: (json['name'] ?? '').toString(),
      nativeName: (json['native_name'] ?? '').toString(),
      uiReady: json['ui_ready'] == true,
      audioReady: json['audio_ready'] == true,
    );
  }
}

class SaptahInfo {
  const SaptahInfo({required this.days, required this.chapters});

  final int days;
  final int chapters;

  factory SaptahInfo.fromJson(Map<String, dynamic> json) {
    return SaptahInfo(
      days: _asInt(json['days'], fallback: 7),
      chapters: _asInt(json['chapters'], fallback: 51),
    );
  }
}

class BootstrapData {
  const BootstrapData({
    required this.app,
    required this.features,
    required this.languages,
    required this.defaultLanguage,
    required this.liveStreams,
    required this.saptah,
  });

  final AppInfo app;
  final FeatureFlags features;
  final List<LanguageOption> languages;
  final String defaultLanguage;
  final List<LiveStream> liveStreams;
  final SaptahInfo saptah;

  LanguageOption? language(String code) {
    for (final item in languages) {
      if (item.code == code) return item;
    }
    return null;
  }

  LiveStream? get primaryLiveStream {
    for (final stream in liveStreams) {
      if (stream.isLive && stream.hasHls) return stream;
    }
    for (final stream in liveStreams) {
      if (stream.isLive) return stream;
    }
    return liveStreams.isEmpty ? null : liveStreams.first;
  }

  factory BootstrapData.fromJson(Map<String, dynamic> json) {
    final rawApp = json['app'];
    final rawFeatures = json['features'];
    final rawLanguages = json['languages'];
    final rawStreams = json['live_streams'];
    final rawSaptah = json['saptah'];

    final languages = <LanguageOption>[];
    if (rawLanguages is List) {
      for (final item in rawLanguages) {
        if (item is Map) {
          languages.add(LanguageOption.fromJson(Map<String, dynamic>.from(item)));
        }
      }
    }

    final streams = <LiveStream>[];
    if (rawStreams is List) {
      for (final item in rawStreams) {
        if (item is Map) {
          streams.add(LiveStream.fromJson(Map<String, dynamic>.from(item)));
        }
      }
    }

    return BootstrapData(
      app: rawApp is Map
          ? AppInfo.fromJson(Map<String, dynamic>.from(rawApp))
          : const AppInfo(
              name: 'Sai Vani',
              minVersion: '1.0.0',
              supportEmail: '',
              maintenance: false,
            ),
      features: rawFeatures is Map
          ? FeatureFlags.fromJson(Map<String, dynamic>.from(rawFeatures))
          : const FeatureFlags(
              favorites: false,
              sankalp: false,
              offline: false,
              googleSignIn: false,
              feedback: false,
              liveDarshan: true,
              parayan: true,
              dailyQuote: true,
            ),
      languages: languages,
      defaultLanguage: (json['default_language'] ?? 'en').toString(),
      liveStreams: streams,
      saptah: rawSaptah is Map
          ? SaptahInfo.fromJson(Map<String, dynamic>.from(rawSaptah))
          : const SaptahInfo(days: 7, chapters: 51),
    );
  }
}

int _asInt(dynamic value, {int fallback = 0}) {
  if (value is int) return value;
  if (value is num) return value.toInt();
  return int.tryParse(value?.toString() ?? '') ?? fallback;
}
