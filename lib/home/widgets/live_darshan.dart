import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'dart:ui';

class LiveDarshan extends StatefulWidget {
  final String videoUrl;

  const LiveDarshan({
    super.key,
    this.videoUrl = 'https://cam3.pc.cdn.bitgravity.com/cam/live/feed006/Saibaba/temple/feed/playlist.m3u8',
  });

  @override
  State<LiveDarshan> createState() => _LiveDarshanState();
}

class _LiveDarshanState extends State<LiveDarshan> with TickerProviderStateMixin {
  late VideoPlayerController _controller;
  bool isMuted = true;
  bool isLoading = true;
  late AnimationController _blinkController;
  late Animation<double> _blinkAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize video player with HLS stream
    _controller = VideoPlayerController.networkUrl(
      Uri.parse(widget.videoUrl),
    );

    // Initialize and configure the player
    _controller.initialize().then((_) {
      if (mounted) {
        setState(() {
          isLoading = false;
        });

        // Set to muted by default
        _controller.setVolume(0.0);

        // Set to loop
        _controller.setLooping(true);

        // Start playing automatically
        _controller.play();
      }
    }).catchError((error) {
      print('Error initializing video player: $error');
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    });

    // Listen for player state changes
    _controller.addListener(() {
      if (mounted && !_controller.value.isPlaying && _controller.value.isInitialized) {
        // Auto-restart if paused
        _controller.play();
      }
    });

    // Blinking animation for live indicator
    _blinkController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat(reverse: true);

    _blinkAnimation = Tween<double>(begin: 0.3, end: 1.0).animate(_blinkController);
  }

  @override
  void dispose() {
    _controller.dispose();
    _blinkController.dispose();
    super.dispose();
  }

  Future<void> _toggleMute() async {
    setState(() {
      isMuted = !isMuted;
    });

    if (isMuted) {
      await _controller.setVolume(0.0);
    } else {
      await _controller.setVolume(1.0);
    }

    print('Live Darshan: Mute toggled to ${isMuted ? "muted" : "unmuted"}');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            offset: const Offset(0, 4),
            blurRadius: 6,
            spreadRadius: -1,
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            offset: const Offset(0, 2),
            blurRadius: 4,
            spreadRadius: -2,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            // Block all taps from reaching YouTube iframe
          },
          child: Stack(
            children: [
            // YouTube Player (wrapped in AspectRatio for proper sizing)
            AbsorbPointer(
              absorbing: true,
              child: SizedBox(
                width: double.infinity,
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Stack(
                    children: [
                      // Black background
                      Container(
                        width: double.infinity,
                        height: double.infinity,
                        color: Colors.black,
                      ),
                      // Video Player
                      if (_controller.value.isInitialized)
                        SizedBox(
                          width: double.infinity,
                          height: double.infinity,
                          child: FittedBox(
                            fit: BoxFit.cover,
                            child: SizedBox(
                              width: _controller.value.size.width,
                              height: _controller.value.size.height,
                              child: VideoPlayer(_controller),
                            ),
                          ),
                        ),
                      // Loading indicator
                      if (isLoading)
                        Container(
                          color: Colors.black87,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const CircularProgressIndicator(
                                  color: Color(0xFFFEA619),
                                ),
                                const SizedBox(height: 16),
                                const Text(
                                  'Loading Live Darshan...',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    decoration: TextDecoration.none,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),

            // Click blocker overlay - covers entire video to prevent YouTube interactions
            // Including clicks on YouTube logo and controls
            Positioned.fill(
              child: Container(
                color: Colors.transparent,
                child: const SizedBox.expand(),
              ),
            ),

            // 1. Top widgets (Live badge and Views badge)
            Positioned(
              top: 12,
              left: 12,
              right: 12,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // 1_a. Live indication badge
                  ClipRRect(
                    borderRadius: BorderRadius.circular(9999),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFBA1A1A),
                          borderRadius: BorderRadius.circular(9999),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Blinking dot
                            AnimatedBuilder(
                              animation: _blinkAnimation,
                              builder: (context, child) {
                                return Opacity(
                                  opacity: _blinkAnimation.value,
                                  child: Container(
                                    width: 8,
                                    height: 8,
                                    decoration: const BoxDecoration(
                                      color: Color(0xFFFFFFFF),
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                );
                              },
                            ),
                            const SizedBox(width: 6),
                            // Text
                            const Text(
                              'LIVE FROM SHIRDI • समाधि मंदिर',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 10,
                                height: 1.4,
                                letterSpacing: 0.5,
                                color: Color(0xFFFFFFFF),
                                decoration: TextDecoration.none,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // 1_b. Views badge
                  ClipRRect(
                    borderRadius: BorderRadius.circular(9999),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF32302C).withOpacity(0.6),
                          borderRadius: BorderRadius.circular(9999),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.visibility,
                              color: Color(0xFFF5F0E9),
                              size: 14,
                            ),
                            SizedBox(width: 3.99),
                            Text(
                              '48.2k watching',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 10,
                                height: 1.4,
                                letterSpacing: 0.5,
                                color: Color(0xFFF5F0E9),
                                decoration: TextDecoration.none,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // 2. Bottom overlay
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  // Prevent tap from passing through to video
                },
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.7),
                    ],
                  ),
                ),
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    // 2_a. Left - Text content
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // 1st text with temple icon
                          Row(
                            children: [
                              const Icon(
                                Icons.temple_hindu,
                                color: Color(0xFFFFB95F),
                                size: 16,
                              ),
                              const SizedBox(width: 4),
                              const Text(
                                'KAKAD AARTI LIVE STREAM',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                  height: 1.33,
                                  letterSpacing: 0.3,
                                  color: Color(0xFFFFB95F),
                                  decoration: TextDecoration.none,
                                ),
                              ),
                            ],
                          ),
                          // 2nd text
                          const Text(
                            'मंगल स्नान व प्रभात आरती दर्शन',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              height: 1.5,
                              letterSpacing: 0,
                              color: Color(0xFFF5F0E9),
                              decoration: TextDecoration.none,
                            ),
                          ),
                          // 3rd text
                          const Text(
                            'Direct audio & visual stream • साईं की महिमा',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                              height: 1.5,
                              letterSpacing: 0,
                              color: Color(0xFFFFDDB8),
                              decoration: TextDecoration.none,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    // 2_b. Right - Mute/Unmute button
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          _toggleMute();
                        },
                        customBorder: const CircleBorder(),
                        child: Container(
                          width: 48,
                          height: 48,
                          decoration: const BoxDecoration(
                            color: Color(0xFFFEA619),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            isMuted ? Icons.volume_off : Icons.volume_up,
                            color: const Color(0xFF684000),
                            size: 24,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              ),
            ),
          ],
          ),
        ),
      ),
    );
  }
}
