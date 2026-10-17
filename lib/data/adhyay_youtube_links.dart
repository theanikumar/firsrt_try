class AdhyayYoutubeLinks {
  final int adhyayNumber;
  final Map<String, String> videoIds; // language code -> YouTube video ID

  const AdhyayYoutubeLinks({
    required this.adhyayNumber,
    required this.videoIds,
  });

  // Get video ID for specific language
  String getVideoId(String languageCode) {
    return videoIds[languageCode] ?? videoIds['en'] ?? '';
  }

  // All 51 Adhyay YouTube links (organized by language)
  static const List<AdhyayYoutubeLinks> allLinks = [
    AdhyayYoutubeLinks(
      adhyayNumber: 1,
      videoIds: {
        'en': 'FI7o2J1o49A', // Just the video ID, not full URL
        'hi': '',
        'mr': '',
      },
    ),
    AdhyayYoutubeLinks(
      adhyayNumber: 2,
      videoIds: {
        'en': 'example_adhyay2_en',
        'hi': 'example_adhyay2_hi',
        'mr': 'example_adhyay2_mr',
      },
    ),
    AdhyayYoutubeLinks(
      adhyayNumber: 3,
      videoIds: {
        'en': 'example_adhyay3_en',
        'hi': 'example_adhyay3_hi',
        'mr': 'example_adhyay3_mr',
      },
    ),
    AdhyayYoutubeLinks(
      adhyayNumber: 4,
      videoIds: {
        'en': 'example_adhyay4_en',
        'hi': 'example_adhyay4_hi',
        'mr': 'example_adhyay4_mr',
      },
    ),
    AdhyayYoutubeLinks(
      adhyayNumber: 5,
      videoIds: {
        'en': 'example_adhyay5_en',
        'hi': 'example_adhyay5_hi',
        'mr': 'example_adhyay5_mr',
      },
    ),
    AdhyayYoutubeLinks(
      adhyayNumber: 6,
      videoIds: {
        'en': 'example_adhyay6_en',
        'hi': 'example_adhyay6_hi',
        'mr': 'example_adhyay6_mr',
      },
    ),
    AdhyayYoutubeLinks(
      adhyayNumber: 7,
      videoIds: {
        'en': 'example_adhyay7_en',
        'hi': 'example_adhyay7_hi',
        'mr': 'example_adhyay7_mr',
      },
    ),
    // Template for chapters 8-51
    AdhyayYoutubeLinks(
      adhyayNumber: 8,
      videoIds: {
        'en': 'example_adhyay8_en',
        'hi': 'example_adhyay8_hi',
        'mr': 'example_adhyay8_mr',
      },
    ),
    AdhyayYoutubeLinks(
      adhyayNumber: 9,
      videoIds: {
        'en': 'example_adhyay9_en',
        'hi': 'example_adhyay9_hi',
        'mr': 'example_adhyay9_mr',
      },
    ),
    AdhyayYoutubeLinks(
      adhyayNumber: 10,
      videoIds: {
        'en': 'example_adhyay10_en',
        'hi': 'example_adhyay10_hi',
        'mr': 'example_adhyay10_mr',
      },
    ),
    // Add remaining chapters 11-51 here following the same pattern
    // For now, using a fallback pattern for demo
  ];

  // Get YouTube video ID for a specific adhyay and language
  static String getVideoIdForAdhyay(int adhyayNumber, String languageCode) {
    try {
      final link = allLinks.firstWhere(
        (link) => link.adhyayNumber == adhyayNumber,
      );
      return link.getVideoId(languageCode);
    } catch (e) {
      // Return a default demo video if not found (just video ID, not full URL)
      return 'y2KRU8Avb0A'; // Default to first bhajan as fallback
    }
  }

  // Get full YouTube URL
  static String getYoutubeUrl(int adhyayNumber, String languageCode) {
    final videoId = getVideoIdForAdhyay(adhyayNumber, languageCode);
    return 'https://www.youtube.com/watch?v=$videoId';
  }
}
