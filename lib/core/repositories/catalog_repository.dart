import '../models/offering.dart';
import '../network/api_client.dart';

class OfferingPage {
  const OfferingPage({
    required this.items,
    required this.total,
    required this.page,
    required this.perPage,
  });

  final List<Offering> items;
  final int total;
  final int page;
  final int perPage;

  bool get hasMore => page * perPage < total;

  factory OfferingPage.fromJson(Map<String, dynamic> json) {
    final raw = json['items'];
    final items = <Offering>[];
    if (raw is List) {
      for (final item in raw) {
        if (item is Map) {
          items.add(Offering.fromJson(Map<String, dynamic>.from(item)));
        }
      }
    }
    return OfferingPage(
      items: items,
      total: _asInt(json['total']),
      page: _asInt(json['page'], fallback: 1),
      perPage: _asInt(json['per_page'], fallback: items.length),
    );
  }
}

class CatalogRepository {
  CatalogRepository({required ApiClient api}) : _api = api;

  final ApiClient _api;

  Future<OfferingPage> offerings({
    String? type,
    String? category,
    String? lang,
    String? query,
    String? sort,
    int? chapter,
    int limit = 20,
    int page = 1,
  }) async {
    final data = await _api.get(
      '/public/offerings',
      authenticated: false,
      query: {
        'limit': limit,
        'page': page,
        if (type != null && type.isNotEmpty) 'type': type,
        if (category != null && category.isNotEmpty) 'category': category,
        if (lang != null && lang.isNotEmpty) 'lang': lang,
        if (query != null && query.isNotEmpty) 'q': query,
        if (sort != null && sort.isNotEmpty) 'sort': sort,
        if (chapter != null && chapter > 0) 'chapter': chapter,
      },
    );
    return OfferingPage.fromJson(Map<String, dynamic>.from(data as Map));
  }

  Future<Offering> offering(int id) async {
    final data = await _api.get('/public/offerings/$id', authenticated: false);
    return Offering.fromJson(Map<String, dynamic>.from(data as Map));
  }

  /// Best-effort play analytics. A failure here must never interrupt playback.
  Future<void> reportPlay(int offeringId, {int plays = 1}) async {
    if (offeringId <= 0) return;
    try {
      await _api.post(
        '/public/play-events',
        data: {'offering_id': offeringId, 'plays': plays},
        authenticated: true,
      );
    } catch (_) {
      // Analytics is optional.
    }
  }
}

int _asInt(dynamic value, {int fallback = 0}) {
  if (value is int) return value;
  if (value is num) return value.toInt();
  return int.tryParse(value?.toString() ?? '') ?? fallback;
}
