import 'package:flutter/material.dart';

class SplashMain extends StatefulWidget {
  const SplashMain({super.key});

  @override
  State<SplashMain> createState() => _SplashMainState();
}

class _SplashMainState extends State<SplashMain>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 74.25),
      child: Column(
        children: [
          // 1. Top container - Image with badge
          _buildTopContainer(),

          const SizedBox(height: 12),

          // 2. Middle container - Title and subtitle
          _buildMiddleContainer(),

          // 3. Bottom container - Quote card
          _buildBottomContainer(),
        ],
      ),
    );
  }

  Widget _buildTopContainer() {
    return SizedBox(
      width: 176,
      height: 176,
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          // Animated circular wave background - single pulsing wave from center
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              final progress = _controller.value;
              final scale = 0.8 + (progress * 0.8); // Scale from 0.8 to 1.6 (larger radius)
              final opacity = 1.0 - progress; // Opacity decreases as it expands

              return Transform.scale(
                scale: scale,
                child: Container(
                  width: 220,
                  height: 220,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      center: Alignment.center,
                      radius: 0.5,
                      colors: [
                        Color(0xFFfea619).withOpacity(0.30 * opacity),
                        Color(0xFFFFDF9F).withOpacity(opacity),
                        Color(0xFF9a4100).withOpacity(0.20 * opacity),
                      ],
                      stops: const [0.0, 0.5, 1.0],
                    ),
                  ),
                ),
              );
            },
          ),

          // Image container
          Container(
            width: 160,
            height: 160,
            padding: const EdgeInsets.all(4),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: ClipOval(
              child: Image.asset(
                '/Users/admin/flutter_prac/first_try/assets/image/splash/splash-baba.png',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: const Color(0xFFF2EDE6),
                    child: const Icon(
                      Icons.person,
                      color: Color(0xFF9A4100),
                      size: 80,
                    ),
                  );
                },
              ),
            ),
          ),

          // Badge (50% overlapping from top)
          Positioned(
            bottom: -12, // Half of badge height overlaps
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: const Color(0xFFFFFFFF),
                borderRadius: BorderRadius.circular(9999),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.local_fire_department,
                    color: Color(0xFF855300),
                    size: 16,
                  ),
                  const SizedBox(width: 4),
                  const Text(
                    'अखण्ड ज्योत',
                    style: TextStyle(
                      fontWeight: FontWeight.w600, // semibold
                      fontSize: 16,
                      height: 24 / 16, // line height 24
                      letterSpacing: 0.8,
                      color: Color(0xFF855300),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMiddleContainer() {
    return Column(
      children: [
        // a. Top - App name (horizontal layout)
        Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Sai Vani',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w600, // semibold
                fontSize: 28,
                height: 36 / 28, // line height 36
                letterSpacing: -0.7,
                color: Color(0xFF9A4100),
              ),
            ),
            const SizedBox(width: 6),
            const Text(
              'वाणी',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w400, // regular
                fontSize: 18,
                height: 26 / 18, // line height 26
                letterSpacing: -0.7,
                color: Color(0xFF855300),
              ),
            ),
          ],
        ),

        // b. Middle - Shraddha • Saburi
        Container(
          padding: const EdgeInsets.only(top: 4, bottom: 8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'श्रद्धा',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w400, // regular
                  fontSize: 16,
                  height: 26 / 16, // line height 26
                  letterSpacing: 0.4,
                  color: Color(0xFF574238),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                width: 6,
                height: 6,
                decoration: BoxDecoration(
                  color: const Color(0xFFfea619),
                  borderRadius: BorderRadius.circular(9999),
                ),
              ),
              const SizedBox(width: 8),
              const Text(
                'सबुरी',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w400, // regular
                  fontSize: 16,
                  height: 26 / 16, // line height 26
                  letterSpacing: 0.4,
                  color: Color(0xFF574238),
                ),
              ),
            ],
          ),
        ),

        // c. Bottom - Description text
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 26),
          child: const Text(
            'Your Daily Spiritual Companion for Sri Sai Satcharitra, Aarti & Sacred Naam Jaap',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w400, // regular
              fontSize: 12,
              height: 20 / 12, // line height 20
              letterSpacing: 0,
              color: Color(0xFF574238),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomContainer() {
    return Container(
      width: 340,
      height: 142,
      padding: const EdgeInsets.only(top: 20),
      child: Container(
        width: 340,
        decoration: BoxDecoration(
          color: const Color(0xFFFFFFFF),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF000000).withOpacity(0.10), // 10%
              offset: const Offset(0, 4),
              blurRadius: 6,
              spreadRadius: -1,
            ),
            BoxShadow(
              color: const Color(0xFF000000).withOpacity(0.10), // 10%
              offset: const Offset(0, 2),
              blurRadius: 4,
              spreadRadius: -2,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // i. Top - Title with badge
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Left - Quote icon and text
                  Row(
                    children: [
                      const Icon(
                        Icons.format_quote,
                        color: Color(0xFF855300),
                        size: 16,
                      ),
                      const SizedBox(width: 6),
                      const Text(
                        'सबका मालिक एक',
                        style: TextStyle(
                          fontWeight: FontWeight.w600, // semibold
                          fontSize: 14,
                          height: 22 / 14, // line height 22
                          letterSpacing: 0.35,
                          color: Color(0xFF855300),
                        ),
                      ),
                    ],
                  ),

                  // Right - Location badge
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFDDB8).withOpacity(0.50), // 50%
                      borderRadius: BorderRadius.circular(9999),
                    ),
                    child: const Text(
                      'शिर्डी वेगाहे',
                      style: TextStyle(
                        fontWeight: FontWeight.w600, // semibold
                        fontSize: 10,
                        height: 14 / 10, // line height 14
                        letterSpacing: 0.5,
                        color: Color(0xFF2A1700),
                      ),
                    ),
                  ),
                ],
              ),

              // ii. Middle - Quote text
              Container(
                width: double.infinity,
                padding: const EdgeInsets.only(top: 4),
                child: const Text(
                  '"Why fear when I am here? Cast all your burdens upon Me, and I shall surely bear them."',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w400, // regular
                    fontSize: 14,
                    height: 22.8 / 14, // line height 22.8
                    letterSpacing: 0,
                    color: Color(0xFF1D1C18),
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),

              // iii. Bottom - Attribution
              Container(
                width: double.infinity,
                padding: const EdgeInsets.only(top: 4),
                alignment: Alignment.centerRight,
                child: const Text(
                  '- सद्गुरु साईं नाथ',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontWeight: FontWeight.w400, // regular
                    fontSize: 10,
                    height: 14 / 10, // line height 14
                    letterSpacing: 0.5,
                    color: Color(0xFF574238),
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
