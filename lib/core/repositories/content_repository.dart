import '../models/bootstrap.dart';
import '../models/content.dart';
import '../network/api_client.dart';

class ContentRepository {
  ContentRepository({required ApiClient api}) : _api = api;

  final ApiClient _api;

  Future<BootstrapData> bootstrap() async {
    final data = await _api.get('/public/bootstrap', authenticated: false);
    return BootstrapData.fromJson(Map<String, dynamic>.from(data as Map));
  }

  Future<List<Chapter>> chapters() async {
    final data = await _api.get('/public/chapters', authenticated: false);
    final body = Map<String, dynamic>.from(data as Map);
    final raw = body['items'];
    if (raw is! List) return [];
    return raw
        .whereType<Map>()
        .map((item) => Chapter.fromJson(Map<String, dynamic>.from(item)))
        .toList();
  }

  Future<DailyQuote> dailyQuote() async {
    final data = await _api.get('/public/daily-quote', authenticated: false);
    final body = Map<String, dynamic>.from(data as Map);
    return DailyQuote.fromJson(Map<String, dynamic>.from(body['quote'] as Map));
  }

  Future<List<LiveStream>> liveStreams() async {
    final data = await _api.get('/public/live-streams', authenticated: false);
    final body = Map<String, dynamic>.from(data as Map);
    final raw = body['items'];
    if (raw is! List) return [];
    return raw
        .whereType<Map>()
        .map((item) => LiveStream.fromJson(Map<String, dynamic>.from(item)))
        .toList();
  }

  Future<List<TeamMember>> team() async {
    final data = await _api.get('/public/team', authenticated: false);
    final body = Map<String, dynamic>.from(data as Map);
    final raw = body['items'];
    if (raw is! List) return [];
    return raw
        .whereType<Map>()
        .map((item) => TeamMember.fromJson(Map<String, dynamic>.from(item)))
        .toList();
  }

  Future<List<Collection>> collections() async {
    final data = await _api.get('/public/collections', authenticated: false);
    final body = Map<String, dynamic>.from(data as Map);
    final raw = body['items'];
    if (raw is! List) return [];
    return raw
        .whereType<Map>()
        .map((item) => Collection.fromJson(Map<String, dynamic>.from(item)))
        .toList();
  }
}
