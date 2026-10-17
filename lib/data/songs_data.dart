import '../services/audio_service.dart';

class SongsData {
  // Extract video ID from YouTube URL
  static String _getVideoId(String url) {
    final uri = Uri.parse(url);
    if (uri.host.contains('youtu.be')) {
      return uri.pathSegments.first;
    }
    return uri.queryParameters['v'] ?? '';
  }

  // Devotional Melodies (Bhajans)
  static final List<Song> devotionalMelodies = [
    Song(
      id: '1',
      title: 'Jai Jai Sai',
      artist: 'Soubbiek Kabi',
      youtubeUrl: 'https://www.youtube.com/watch?v=y2KRU8Avb0A',
      videoId: _getVideoId('https://www.youtube.com/watch?v=y2KRU8Avb0A'),
      duration: const Duration(minutes: 5, seconds: 26),
      category: 'Popular',
      isSaptahParayan: false,
    ),
    Song(
      id: '2',
      title: 'Sainath Tere Hazaron Haath',
      artist: 'Lata Mangeshkar',
      youtubeUrl: 'https://www.youtube.com/watch?v=DUZt1Wcyfas',
      videoId: _getVideoId('https://www.youtube.com/watch?v=DUZt1Wcyfas'),
      duration: const Duration(minutes: 6, seconds: 45),
      category: 'Classic',
      isSaptahParayan: false,
    ),
    Song(
      id: '3',
      title: 'Sai Baba Bol',
      artist: 'Suresh Wadkar',
      youtubeUrl: 'https://www.youtube.com/watch?v=aZaKltXemRs',
      videoId: _getVideoId('https://www.youtube.com/watch?v=aZaKltXemRs'),
      duration: const Duration(minutes: 7, seconds: 54),
      category: 'Devotional',
      isSaptahParayan: false,
    ),
  ];

  // Saptah Parayan
  static final List<Song> saptahParayan = [
    Song(
      id: '4',
      title: 'Shri Sai Satcharitra',
      artist: 'Adhyay 15',
      youtubeUrl: 'https://www.youtube.com/watch?v=B5Rzf0Ucx7Q',
      videoId: _getVideoId('https://www.youtube.com/watch?v=B5Rzf0Ucx7Q'),
      duration: const Duration(minutes: 10, seconds: 23),
      category: 'Saptah Parayan • Day 3 of 7',
      isSaptahParayan: true,
    ),
  ];

  // All songs combined
  static List<Song> get allSongs => [...devotionalMelodies, ...saptahParayan];

  // Get song by ID
  static Song? getSongById(String id) {
    try {
      return allSongs.firstWhere((song) => song.id == id);
    } catch (e) {
      return null;
    }
  }
}
