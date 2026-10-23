import 'package:flutter_test/flutter_test.dart';

import 'package:first_try/core/models/devotee.dart';

void main() {
  test('devotee parses the API payload', () {
    final devotee = Devotee.fromJson({
      'id': 7,
      'display_name': 'Aniket',
      'name': 'Aniket Kumar',
      'email': 'aniket@saivani.com',
      'phone': '+919876543210',
      'language': 'mr',
      'status': 'active',
      'onboarding_completed': true,
      'initials': 'AK',
    });

    expect(devotee.id, 7);
    expect(devotee.name, 'Aniket Kumar');
    expect(devotee.language, 'mr');
    expect(devotee.onboardingCompleted, isTrue);
    expect(devotee.initials, 'AK');
  });
}
