import 'package:flutter/material.dart';
import 'dart:math' as math;

class SaiBabCircleBackground extends StatefulWidget {
  const SaiBabCircleBackground({super.key});

  @override
  State<SaiBabCircleBackground> createState() => _SaiBabCircleBackgroundState();
}

class _SaiBabCircleBackgroundState extends State<SaiBabCircleBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 176,
      height: 176,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.rotate(
            angle: _controller.value * 2 * math.pi,
            child: CustomPaint(
              painter: CircleBackgroundPainter(),
              size: const Size(176, 176),
            ),
          );
        },
      ),
    );
  }
}

class CircleBackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final outerRadius = size.width * 0.66; // 1.32 / 2
    final innerRadius = size.width * 0.44; // 0.88 / 2

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
