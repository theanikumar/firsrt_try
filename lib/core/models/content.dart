import 'offering.dart';

class Chapter {
  const Chapter({
    required this.number,
    required this.titleEn,
    required this.titleHi,
    required this.titleMr,
    required this.summaryEn,
    required this.summaryHi,
    required this.summaryMr,
    required this.durationMinutes,
    required this.hasAudio,
    this.audio,
  });

  final int number;
  final String titleEn;
  final String titleHi;
  final String titleMr;
  final String summaryEn;
  final String summaryHi;
  final String summaryMr;
  final int durationMinutes;
  final bool hasAudio;
  final Offering? audio;

  String titleFor(String language) {
    switch (language) {
      case 'hi':
        return titleHi.isNotEmpty ? titleHi : titleEn;
      case 'mr':
        return titleMr.isNotEmpty ? titleMr : titleEn;
      default:
        return titleEn;
    }
  }

  String summaryFor(String language) {
    switch (language) {
      case 'hi':
        return summaryHi.isNotEmpty ? summaryHi : summaryEn;
      case 'mr':
        return summaryMr.isNotEmpty ? summaryMr : summaryEn;
      default:
        return summaryEn;
    }
  }

  factory Chapter.fromJson(Map<String, dynamic> json) {
    return Chapter(
      number: _asInt(json['number']),
      titleEn: (json['title_en'] ?? '').toString(),
      titleHi: (json['title_hi'] ?? '').toString(),
      titleMr: (json['title_mr'] ?? '').toString(),
      summaryEn: (json['summary_en'] ?? '').toString(),
      summaryHi: (json['summary_hi'] ?? '').toString(),
      summaryMr: (json['summary_mr'] ?? '').toString(),
      durationMinutes: _asInt(json['duration_minutes']),
      hasAudio: json['has_audio'] == true,
      audio: json['audio'] is Map
          ? Offering.fromJson(Map<String, dynamic>.from(json['audio'] as Map))
          : null,
    );
  }
}

class Collection {
  const Collection({
    required this.id,
    required this.slug,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.accent,
    required this.sortOrder,
    required this.items,
  });

  final int id;
  final String slug;
  final String title;
  final String subtitle;
  final String icon;
  final String accent;
  final int sortOrder;
  final List<Offering> items;

  int get itemCount => items.length;
  int get playableCount => items.where((item) => item.isPlayable).length;

  factory Collection.fromJson(Map<String, dynamic> json) {
    final raw = json['items'];
    final items = <Offering>[];
    if (raw is List) {
      for (final item in raw) {
        if (item is Map) {
          items.add(Offering.fromJson(Map<String, dynamic>.from(item)));
        }
      }
    }
    return Collection(
      id: _asInt(json['id']),
      slug: (json['slug'] ?? '').toString(),
      title: (json['title'] ?? '').toString(),
      subtitle: (json['subtitle'] ?? '').toString(),
      icon: (json['icon'] ?? 'music_note').toString(),
      accent: (json['accent'] ?? '#9A4100').toString(),
      sortOrder: _asInt(json['sort_order']),
      items: items,
    );
  }
}

class DailyQuote {
  const DailyQuote({
    required this.id,
    required this.quoteEn,
    required this.quoteHi,
    required this.quoteMr,
    required this.sourceLabel,
    required this.chapter,
  });

  final int id;
  final String quoteEn;
  final String quoteHi;
  final String quoteMr;
  final String sourceLabel;
  final int chapter;

  String quoteFor(String language) {
    switch (language) {
      case 'hi':
        return quoteHi.isNotEmpty ? quoteHi : quoteEn;
      case 'mr':
        return quoteMr.isNotEmpty ? quoteMr : quoteEn;
      default:
        return quoteEn;
    }
  }

  String get reference =>
      chapter > 0 ? '$sourceLabel, Chapter $chapter' : sourceLabel;

  factory DailyQuote.fromJson(Map<String, dynamic> json) {
    return DailyQuote(
      id: _asInt(json['id']),
      quoteEn: (json['quote_en'] ?? '').toString(),
      quoteHi: (json['quote_hi'] ?? '').toString(),
      quoteMr: (json['quote_mr'] ?? '').toString(),
      sourceLabel: (json['source_label'] ?? '').toString(),
      chapter: _asInt(json['chapter']),
    );
  }
}

class LiveStream {
  const LiveStream({
    required this.id,
    required this.slug,
    required this.title,
    required this.subtitle,
    required this.hlsUrl,
    required this.youtubeUrl,
    required this.isLive,
    required this.scheduleNote,
  });

  final int id;
  final String slug;
  final String title;
  final String subtitle;
  final String hlsUrl;
  final String youtubeUrl;
  final bool isLive;
  final String scheduleNote;

  bool get hasHls => hlsUrl.isNotEmpty;

  factory LiveStream.fromJson(Map<String, dynamic> json) {
    return LiveStream(
      id: _asInt(json['id']),
      slug: (json['slug'] ?? '').toString(),
      title: (json['title'] ?? '').toString(),
      subtitle: (json['subtitle'] ?? '').toString(),
      hlsUrl: (json['hls_url'] ?? '').toString(),
      youtubeUrl: (json['youtube_url'] ?? '').toString(),
      isLive: json['is_live'] == true,
      scheduleNote: (json['schedule_note'] ?? '').toString(),
    );
  }
}

class TeamSocialLink {
  const TeamSocialLink({
    required this.platform,
    required this.username,
    required this.url,
  });

  final String platform;
  final String username;
  final String url;

  factory TeamSocialLink.fromJson(Map<String, dynamic> json) {
    return TeamSocialLink(
      platform: (json['platform'] ?? '').toString(),
      username: (json['username'] ?? '').toString(),
      url: (json['url'] ?? '').toString(),
    );
  }
}

class TeamMember {
  const TeamMember({
    required this.id,
    required this.name,
    required this.badge,
    required this.roleTitle,
    required this.quote,
    required this.description,
    required this.imageUrl,
    required this.roleIcon,
    required this.socialLinks,
  });

  final int id;
  final String name;
  final String badge;
  final String roleTitle;
  final String quote;
  final String description;
  final String imageUrl;
  final String roleIcon;
  final List<TeamSocialLink> socialLinks;

  factory TeamMember.fromJson(Map<String, dynamic> json) {
    final rawLinks = json['social_links'];
    final links = <TeamSocialLink>[];
    if (rawLinks is List) {
      for (final item in rawLinks) {
        if (item is Map) {
          links.add(TeamSocialLink.fromJson(Map<String, dynamic>.from(item)));
        }
      }
    }
    return TeamMember(
      id: _asInt(json['id']),
      name: (json['name'] ?? '').toString(),
      badge: (json['badge'] ?? '').toString(),
      roleTitle: (json['role_title'] ?? '').toString(),
      quote: (json['quote'] ?? '').toString(),
      description: (json['description'] ?? '').toString(),
      imageUrl: (json['image_url'] ?? '').toString(),
      roleIcon: (json['role_icon'] ?? 'person').toString(),
      socialLinks: links,
    );
  }
}

int _asInt(dynamic value) {
  if (value is int) return value;
  if (value is num) return value.toInt();
  return int.tryParse(value?.toString() ?? '') ?? 0;
}
