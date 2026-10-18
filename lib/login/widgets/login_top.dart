import 'package:flutter/material.dart';
import 'dart:math' as math;

class LoginTop extends StatefulWidget {
  const LoginTop({super.key});

  @override
  State<LoginTop> createState() => _LoginTopState();
}

class _LoginTopState extends State<LoginTop>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 10),
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
      padding: const EdgeInsets.only(top: 50, bottom: 8),
      child: Column(
        children: [
          // 1. First container - Image with rotating background
          _buildImageContainer(),

          // 2. Second container - App name
          const Text(
            'Sai Vani',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w600, // semibold
              fontSize: 22,
              height: 30 / 22, // line height 30
              letterSpacing: -0.55,
              color: Color(0xFF1D1C18),
            ),
          ),

          // 3. Third container - Shraddha • Saburi
          _buildSubtitleContainer(),

          // 4. Fourth container - Welcome message
          _buildWelcomeContainer(),
        ],
      ),
    );
  }

  Widget _buildImageContainer() {
    return Container(
      width: 96,
      height: 108,
      padding: const EdgeInsets.only(bottom: 12),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Rotating background effect - using CustomPainter
          SizedBox(
            width: 96,
            height: 96,
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Transform.rotate(
                  angle: _controller.value * 2 * math.pi,
                  child: CustomPaint(
                    painter: _LoginCircleBackgroundPainter(),
                    size: const Size(96, 96),
                  ),
                );
              },
            ),
          ),

          // Sai Baba image
          ClipOval(
            child: Image.asset(
              'assets/image/onboarding/sai_baba.png',
              width: 80,
              height: 80,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 80,
                  height: 80,
                  decoration: const BoxDecoration(
                    color: Color(0xFFF2EDE6),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.person,
                    color: Color(0xFF9A4100),
                    size: 40,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubtitleContainer() {
    return Container(
      padding: const EdgeInsets.only(top: 2),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // a. Left - Hindi text
          const Text(
            'श्रद्धा • सबुरी',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w600, // semibold
              fontSize: 12,
              height: 16 / 12, // line height 16
              letterSpacing: 1.2,
              color: Color(0xFF765700),
            ),
          ),

          const SizedBox(width: 4),

          // b. Right - English text
          const Text(
            'FAITH & PATIENCE',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w600, // semibold
              fontSize: 12,
              height: 16 / 12, // line height 16
              letterSpacing: 1.2,
              color: Color(0xFF765700),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWelcomeContainer() {
    return Container(
      padding: const EdgeInsets.only(top: 12),
      child: Column(
        children: [
          // a. Top - Welcome text
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              // i. Left - Welcome, Devotee
              const Text(
                'Welcome, Devotee',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w600, // semibold
                  fontSize: 16,
                  height: 24 / 16, // line height 24
                  letterSpacing: 0,
                  color: Color(0xFF1D1C18),
                ),
              ),

              const SizedBox(width: 0.01),

              // ii. Right - Hindi text
              const Text(
                ' (भक्त प्रवेश)',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w400, // regular
                  fontSize: 14,
                  height: 22 / 14, // line height 22
                  letterSpacing: 0,
                  color: Color(0xFF9A4100),
                ),
              ),
            ],
          ),

          const SizedBox(height: 6),

          // b. Bottom - Description text
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: const Text(
              'Sign in to preserve your daily Sadhana, Parayan reading progress, and Aartis across all your sacred devices.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w400, // regular
                fontSize: 12,
                height: 19.5 / 12, // line height 19.5
                letterSpacing: 0,
                color: Color(0xFF574238),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LoginCircleBackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final outerRadius = size.width * 0.66; // Same proportion as onboarding
    final innerRadius = size.width * 0.44;

    final strokeColor = const Color(0xFFFFB95F).withOpacity(0.4);

    // Paint for outer circle (dashed)
    final outerPaint = Paint()
      ..color = strokeColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    // Paint for inner circle and connecting lines (continuous)
    final innerPaint = Paint()
      ..color = strokeColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    // Draw outer circle with dashed lines
    _drawDashedCircle(canvas, center, outerRadius, outerPaint);

    // Draw inner circle (continuous)
    canvas.drawCircle(center, innerRadius, innerPaint);

    // Draw 8 connecting lines between circles
    for (int i = 0; i < 8; i++) {
      final angle = (i * math.pi * 2) / 8;
      final innerPoint = Offset(
        center.dx + innerRadius * math.cos(angle),
        center.dy + innerRadius * math.sin(angle),
      );
      final outerPoint = Offset(
        center.dx + outerRadius * math.cos(angle),
        center.dy + outerRadius * math.sin(angle),
      );
      canvas.drawLine(innerPoint, outerPoint, innerPaint);
    }
  }

  void _drawDashedCircle(Canvas canvas, Offset center, double radius, Paint paint) {
    const dashLength = 10.0;
    const gapLength = 5.0;
    final circumference = 2 * math.pi * radius;
    final dashCount = (circumference / (dashLength + gapLength)).floor();

    for (int i = 0; i < dashCount; i++) {
      final startAngle = (i * (dashLength + gapLength)) / radius;
      final sweepAngle = dashLength / radius;

      final path = Path()
        ..addArc(
          Rect.fromCircle(center: center, radius: radius),
          startAngle,
          sweepAngle,
        );
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
