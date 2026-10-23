import 'package:flutter/foundation.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class Song {
  final String id;
  final String title;
  final String artist;
  final String youtubeUrl;
  final String videoId;
  final Duration duration;
  final String category;
  final String? thumbnailUrl;
  final bool isSaptahParayan;

  Song({
    required this.id,
    required this.title,
    required this.artist,
    required this.youtubeUrl,
    required this.videoId,
    required this.duration,
    required this.category,
    this.thumbnailUrl,
    this.isSaptahParayan = false,
  });
}

class AudioService extends ChangeNotifier {
  static final AudioService _instance = AudioService._internal();
  factory AudioService() => _instance;
  AudioService._internal();

  YoutubePlayerController? _controller;
  Song? _currentSong;
  bool _isPlaying = false;
  Duration _currentPosition = Duration.zero;
  bool _isInitialized = false;
  List<Song> _playlist = [];
  int _currentIndex = 0;

  // Getters
  YoutubePlayerController? get controller => _controller;
  Song? get currentSong => _currentSong;
  bool get isPlaying => _isPlaying;
  Duration get currentPosition => _currentPosition;
  bool get isInitialized => _isInitialized;
  List<Song> get playlist => _playlist;
  int get currentIndex => _currentIndex;

  // Initialize controller
  void initializeController() {
    if (_controller == null) {
      _controller = YoutubePlayerController(
        params: const YoutubePlayerParams(
          showControls: false,
          mute: false,
          showFullscreenButton: false,
          loop: false,
          enableJavaScript: true,
        ),
      );
      _isInitialized = true;
      _setupListeners();
      notifyListeners();
    }
  }

  // Setup listeners for controller
  void _setupListeners() {
    if (_controller == null) return;

    print('🎵 AudioService: Setting up listeners...');

    // Listen to player state changes
    _controller!.listen((event) {
      print('🎵 AudioService: Player state changed: ${event.playerState}');
      if (event.playerState == PlayerState.playing) {
        _isPlaying = true;
        print('🎵 AudioService: State = PLAYING');
      } else if (event.playerState == PlayerState.paused) {
        _isPlaying = false;
        print('🎵 AudioService: State = PAUSED');
      } else if (event.playerState == PlayerState.ended) {
        _isPlaying = false;
        print('🎵 AudioService: State = ENDED, playing next...');
        playNext(); // Auto play next song
      }
      notifyListeners();
    });

    // Update current position periodically
    Stream.periodic(const Duration(seconds: 1)).listen((_) async {
      if (_controller != null && _isPlaying) {
        try {
          final position = await _controller!.currentTime;
          _currentPosition = Duration(seconds: position.toInt());
          notifyListeners();
        } catch (e) {
          // Ignore errors when controller is not ready
        }
      }
    });
  }

  // Play a song
  Future<void> playSong(Song song, {List<Song>? playlist, int? index}) async {
    print('🎵 AudioService: Playing song: ${song.title}');
    print('🎵 AudioService: Video ID: ${song.videoId}');

    initializeController();

    // Stop current playback if any
    if (_controller != null && _isPlaying) {
      print('🎵 AudioService: Stopping current playback...');
      await _controller?.pauseVideo();
      _isPlaying = false;
    }

    if (playlist != null) {
      _playlist = playlist;
      _currentIndex = index ?? 0;
    } else {
      _playlist = [song];
      _currentIndex = 0;
    }

    _currentSong = song;
    _currentPosition = Duration.zero;
    notifyListeners(); // Update UI immediately with new song info

    print('🎵 AudioService: Loading video...');
    try {
      await _controller?.loadVideoById(videoId: song.videoId);

      // Wait for video to be ready
      await Future.delayed(const Duration(milliseconds: 800));

      print('🎵 AudioService: Starting playback...');
      await _controller?.playVideo();

      _isPlaying = true;
      print('🎵 AudioService: Playback started, isPlaying = $_isPlaying');
    } catch (e) {
      print('🎵 AudioService: Error playing video: $e');
      _isPlaying = false;
    }

    notifyListeners();
  }

  // Pause
  Future<void> pause() async {
    await _controller?.pauseVideo();
    _isPlaying = false;
    notifyListeners();
  }

  // Resume
  Future<void> resume() async {
    await _controller?.playVideo();
    _isPlaying = true;
    notifyListeners();
  }

  // Toggle play/pause
  Future<void> togglePlayPause() async {
    if (_isPlaying) {
      await pause();
    } else {
      await resume();
    }
  }

  // Play next song
  Future<void> playNext() async {
    if (_playlist.isEmpty) return;

    _currentIndex = (_currentIndex + 1) % _playlist.length;
    await playSong(_playlist[_currentIndex], playlist: _playlist, index: _currentIndex);
  }

  // Play previous song
  Future<void> playPrevious() async {
    if (_playlist.isEmpty) return;

    _currentIndex = (_currentIndex - 1 + _playlist.length) % _playlist.length;
    await playSong(_playlist[_currentIndex], playlist: _playlist, index: _currentIndex);
  }

  // Seek to position
  Future<void> seekTo(Duration position) async {
    final wasPlaying = _isPlaying;
    await _controller?.seekTo(seconds: position.inSeconds.toDouble());
    _currentPosition = position;

    // Resume playback if it was playing before seeking
    if (wasPlaying) {
      await Future.delayed(const Duration(milliseconds: 300));
      await _controller?.playVideo();
    }

    notifyListeners();
  }

  // Rewind 15 seconds
  Future<void> rewind() async {
    final newPosition = _currentPosition - const Duration(seconds: 10);
    await seekTo(newPosition < Duration.zero ? Duration.zero : newPosition);
  }

  // Forward 15 seconds
  Future<void> forward() async {
    final newPosition = _currentPosition + const Duration(seconds: 10);
    final maxDuration = _currentSong?.duration ?? Duration.zero;
    await seekTo(newPosition > maxDuration ? maxDuration : newPosition);
  }

  // Stop and clear
  void stop() {
    _controller?.pauseVideo();
    _isPlaying = false;
    _currentPosition = Duration.zero;
    notifyListeners();
  }

  // Dispose
  @override
  void dispose() {
    _controller?.close();
    super.dispose();
  }
}
