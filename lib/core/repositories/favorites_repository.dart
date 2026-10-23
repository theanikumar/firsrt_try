import '../models/offering.dart';
import '../network/api_client.dart';

class FavoritesRepository {
  FavoritesRepository({required ApiClient api}) : _api = api;

  final ApiClient _api;

  Future<List<Offering>> list() async {
    final data = await _api.get('/devotee/favorites');
    final body = Map<String, dynamic>.from(data as Map);
    final raw = body['items'];
    if (raw is! List) return [];
    return raw
        .whereType<Map>()
        .map((item) => Offering.fromJson(Map<String, dynamic>.from(item)))
        .toList();
  }

  Future<void> add(int offeringId) {
    return _api.post(
      '/devotee/favorites',
      data: {'offering_id': offeringId},
    );
  }

  Future<void> remove(int offeringId) {
    return _api.request('DELETE', '/devotee/favorites/$offeringId');
  }
}
