class Offering {
  const Offering({
    required this.id,
    required this.artistId,
    required this.artistName,
    required this.artistInitials,
    required this.title,
    required this.offeringType,
    required this.category,
    required this.lang,
    required this.raga,
    required this.accompaniment,
    required this.source,
    required this.youtubeUrl,
    required this.youtubeVideoId,
    required this.thumbnailUrl,
    required this.durationSeconds,
    required this.description,
    required this.lyrics,
    required this.satcharitraChapter,
    required this.leelaReference,
    required this.isTempleBroadcast,
    required this.playCount,
  });

  final int id;
  final int artistId;
  final String artistName;
  final String artistInitials;
  final String title;
  final String offeringType;
  final String category;
  final String lang;
  final String raga;
  final String accompaniment;
  final String source;
  final String youtubeUrl;
  final String youtubeVideoId;
  final String thumbnailUrl;
  final int durationSeconds;
  final String description;
  final String lyrics;
  final int satcharitraChapter;
  final String leelaReference;
  final bool isTempleBroadcast;
  final int playCount;

  bool get isPlayable => youtubeVideoId.isNotEmpty;

  Duration get duration => Duration(seconds: durationSeconds);

  factory Offering.fromJson(Map<String, dynamic> json) {
    return Offering(
      id: _asInt(json['id']),
      artistId: _asInt(json['artist_id']),
      artistName: (json['artist_name'] ?? '').toString(),
      artistInitials: (json['artist_initials'] ?? 'SV').toString(),
      title: (json['title'] ?? '').toString(),
      offeringType: (json['offering_type'] ?? '').toString(),
      category: (json['category'] ?? '').toString(),
      lang: (json['lang'] ?? '').toString(),
      raga: (json['raga'] ?? '').toString(),
      accompaniment: (json['accompaniment'] ?? '').toString(),
      source: (json['source'] ?? '').toString(),
      youtubeUrl: (json['youtube_url'] ?? '').toString(),
      youtubeVideoId: (json['youtube_video_id'] ?? '').toString(),
      thumbnailUrl: (json['thumbnail_url'] ?? '').toString(),
      durationSeconds: _asInt(json['duration_seconds']),
      description: (json['description'] ?? '').toString(),
      lyrics: (json['lyrics'] ?? '').toString(),
      satcharitraChapter: _asInt(json['satcharitra_chapter']),
      leelaReference: (json['leela_reference'] ?? '').toString(),
      isTempleBroadcast: json['is_temple_broadcast'] == true,
      playCount: _asInt(json['play_count']),
    );
  }
}

int _asInt(dynamic value) {
  if (value is int) return value;
  if (value is num) return value.toInt();
  return int.tryParse(value?.toString() ?? '') ?? 0;
}
