import 'package:flutter_test/flutter_test.dart';

import 'package:first_try/core/models/content.dart';
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

  test('chapter parses recording availability and audio', () {
    final chapter = Chapter.fromJson({
      'number': 1,
      'title_en': 'The Divine Wheat Grinding Leela',
      'title_hi': 'गेहूं पीसने की लीला',
      'title_mr': 'गहू दळण्याची लीला',
      'summary_en': 'Kakasaheb gets the idea to grind wheat.',
      'summary_hi': '',
      'summary_mr': '',
      'duration_minutes': 25,
      'has_audio': true,
      'audio': {
        'id': 2,
        'artist_name': 'Anuradha Sharma',
        'title': 'Sai Satcharitra Adhyay 1',
        'youtube_video_id': 'FI7o2J1o49A',
        'youtube_url': 'https://www.youtube.com/watch?v=FI7o2J1o49A',
        'duration_seconds': 1458,
      },
    });

    expect(chapter.number, 1);
    expect(chapter.hasAudio, isTrue);
    expect(chapter.audio?.id, 2);
    expect(chapter.audio?.isPlayable, isTrue);
    expect(chapter.titleFor('mr'), 'गहू दळण्याची लीला');
    expect(chapter.titleFor('te'), 'The Divine Wheat Grinding Leela');
  });
}
