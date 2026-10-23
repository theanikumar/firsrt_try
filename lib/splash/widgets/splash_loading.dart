import 'package:flutter/material.dart';

class SplashLoading extends StatefulWidget {
  final VoidCallback? onLoadingComplete;

  const SplashLoading({
    super.key,
    this.onLoadingComplete,
  });

  @override
  State<SplashLoading> createState() => _SplashLoadingState();
}

class _SplashLoadingState extends State<SplashLoading>
    with TickerProviderStateMixin {
  late AnimationController _dotController;
  late AnimationController _progressController;
  int _currentStage = 0;
  double _progress = 0.0;

  final List<String> _loadingTexts = [
    'Connecting to Shirdi Sanctum...',
    'Awakening Sacred Presence...',
    'Loading Shri Sai Satcharitra...',
  ];

  @override
  void initState() {
    super.initState();

    // Blinking dot animation
    _dotController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    )..repeat(reverse: true);

    // Progress bar animation
    _progressController = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );

    _startLoadingSequence();
  }

  void _startLoadingSequence() async {
    // Stage 1: 0% to 30%
    await _animateProgress(0.0, 0.30, const Duration(milliseconds: 300));
    await Future.delayed(const Duration(milliseconds: 100));

    // Stage 2: 30% to 60%
    setState(() => _currentStage = 1);
    await _animateProgress(0.30, 0.60, const Duration(milliseconds: 300));
    await Future.delayed(const Duration(milliseconds: 100));

    // Stage 3: 60% to 95%
    setState(() => _currentStage = 2);
    await _animateProgress(0.60, 0.95, const Duration(milliseconds: 300));
    await Future.delayed(const Duration(milliseconds: 100));

    // Final: 95% to 100%
    await _animateProgress(0.95, 1.0, const Duration(milliseconds: 200));

    // Notify completion
    if (widget.onLoadingComplete != null) {
      widget.onLoadingComplete!();
    }
  }

  Future<void> _animateProgress(double start, double end, Duration duration) async {
    final startProgress = start;
    final endProgress = end;
    final range = endProgress - startProgress;

    _progressController.duration = duration;
    _progressController.reset();

    _progressController.addListener(() {
      setState(() {
        _progress = startProgress + (range * _progressController.value);
      });
    });

    await _progressController.forward();
  }

  @override
  void dispose() {
    _dotController.dispose();
    _progressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 340,
      padding: const EdgeInsets.only(bottom: 4),
      child: Column(
        children: [
          // 1. Top container - Loading progress
          _buildTopContainer(),

          // 2. Middle container - Security info
          _buildMiddleContainer(),

          // 3. Bottom container - Version info
          _buildBottomContainer(),
        ],
      ),
    );
  }

  Widget _buildTopContainer() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(bottom: 8),
      child: Column(
        children: [
          // a. Up - Blinking dot and text
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Blinking dot
              FadeTransition(
                opacity: _dotController,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: const Color(0xFF9A4100),
                    borderRadius: BorderRadius.circular(9999),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              // Loading text
              Text(
                _loadingTexts[_currentStage],
                style: const TextStyle(
                  fontWeight: FontWeight.w500, // medium
                  fontSize: 12,
                  height: 16 / 12, // line height 16
                  letterSpacing: 0.3,
                  color: Color(0xFF9A4100),
                ),
              ),
            ],
          ),

          const SizedBox(height: 4),

          // b. Down - Progress bar
          Container(
            width: 192,
            height: 4,
            decoration: BoxDecoration(
              color: const Color(0xFFECE2DB),
              borderRadius: BorderRadius.circular(9999),
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                width: 192 * _progress,
                height: 4,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(9999),
                  gradient: const LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    stops: [0.0, 0.5, 1.0],
                    colors: [
                      Color(0xFFfea619),
                      Color(0xFF9a4100),
                      Color(0xFFfea619),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMiddleContainer() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(
          Icons.verified_user,
          color: Color(0xFF765700),
          size: 14,
        ),
        const SizedBox(width: 6),
        Text(
          'Free Devotional Seva • साई वाणी श्रद्धा भाव',
          style: TextStyle(
            fontWeight: FontWeight.w400, // regular
            fontSize: 10,
            height: 14 / 10, // line height 14
            letterSpacing: 0.5,
            color: const Color(0xFF574238).withOpacity(0.80), // 80% opacity
          ),
        ),
      ],
    );
  }

  Widget _buildBottomContainer() {
    return Container(
      padding: const EdgeInsets.only(top: 4),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Left - Version
          const Text(
            'V1.0.0',
            style: TextStyle(
              fontWeight: FontWeight.w600, // semibold
              fontSize: 10,
              height: 14 / 10, // line height 14
              letterSpacing: 0.5,
              color: Color(0xFF574238),
            ),
          ),

          const SizedBox(width: 8),

          // Middle - Dot
          const Text(
            '•',
            style: TextStyle(
              fontWeight: FontWeight.w400, // regular
              fontSize: 16,
              height: 24 / 16, // line height 24
              color: Color(0xFF1D1C18),
            ),
          ),

          const SizedBox(width: 8),

          // Right - Message
          const Text(
            'Blessed with Love & Surrender',
            style: TextStyle(
              fontWeight: FontWeight.w600, // semibold
              fontSize: 10,
              height: 14 / 10, // line height 14
              letterSpacing: 0.5,
              color: Color(0xFF574238),
            ),
          ),
        ],
      ),
    );
  }
}
