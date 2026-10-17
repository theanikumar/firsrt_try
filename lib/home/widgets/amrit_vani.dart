import 'package:flutter/material.dart';

class AmritVani extends StatelessWidget {
  const AmritVani({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        // Decorative circle in bottom right (30% outside) - placed first so it's behind
        Positioned(
          right: -33.6, // 30% of 112 = 33.6
          bottom: -33.6,
          child: Container(
            width: 112,
            height: 112,
            decoration: BoxDecoration(
              color: const Color(0xFFFEA619).withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
          ),
        ),
        // Main container
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color(0xFFFFDDB8).withValues(alpha: 0.8),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                offset: const Offset(0, 1),
                blurRadius: 2,
                spreadRadius: 0,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // 1. Section Title (placeholder)
              _buildSectionTitle(),
              const SizedBox(height: 12),

              // 2. Hindi Vani (placeholder)
              _buildHindiVani(),
              const SizedBox(height: 12),

              // 3. English Vani (placeholder)
              _buildEnglishVani(),
              const SizedBox(height: 12),

              // 4. Chapter Name (placeholder)
              _buildChapterName(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSectionTitle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // 1. Left
        Expanded(
          child: Row(
            children: [
              // 1_a. Quote icon
              const Icon(
                Icons.format_quote,
                color: Color(0xFF855300),
                size: 20,
              ),
              const SizedBox(width: 8),
              // 1_b. Text
              const Expanded(
                child: Text(
                  'DAILY AMRIT VANI • अमृत विचार',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 10,
                    height: 1.4, // Line height 14 / font size 10 = 1.4
                    letterSpacing: 0.5,
                    color: Color(0xFF855300),
                    decoration: TextDecoration.none,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        // 2. Right - Share button
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: const Color(0xFFFFFFFF).withValues(alpha: 0.8),
            borderRadius: BorderRadius.circular(9999),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                offset: const Offset(0, 1),
                blurRadius: 2,
                spreadRadius: 0,
              ),
            ],
          ),
          child: const Icon(
            Icons.share,
            color: Color(0xFF855300),
            size: 16,
          ),
        ),
      ],
    );
  }

  Widget _buildHindiVani() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(bottom: 0.63),
      child: const Text(
        '"श्रद्धा और सबुरी रखो, तुम्हारे सब कष्ट दूर होंगे ।"',
        textAlign: TextAlign.left,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 22,
          height: 1.627, // Line height 35.8 / font size 22 = 1.627
          letterSpacing: -0.55,
          color: Color(0xFF1D1C18),
          decoration: TextDecoration.none,
        ),
      ),
    );
  }

  Widget _buildEnglishVani() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 1.1),
      child: Text(
        '"Have unwavering faith and patient endurance; every sincere prayer offered is received at the feet of the Lord."',
        textAlign: TextAlign.left,
        style: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 14,
          height: 1.571, // Line height 22 / font size 14 = 1.571
          letterSpacing: 0,
          color: Color(0xFF3D2B1F), // Darker brown for better visibility
          decoration: TextDecoration.none,
          fontFamily: 'Roboto',
        ),
      ),
    );
  }

  Widget _buildChapterName() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 9.1),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // 1. Left - Chapter reference
          Expanded(
            child: const Text(
              '-Shri Sai Satcharitra, Chapter 19',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 10,
                height: 1.4, // Line height 14 / font size 10 = 1.4
                letterSpacing: 0.5,
                color: Color(0xFF765700),
                decoration: TextDecoration.none,
              ),
            ),
          ),
          const SizedBox(width: 8),
          // 2. Right - Contemplate button
          GestureDetector(
            onTap: () {
              // Handle contemplate action
              print('Contemplate tapped');
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Text(
                  'Contemplate',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 10,
                    height: 1.4, // Line height 14 / font size 10 = 1.4
                    letterSpacing: 0.5,
                    color: Color(0xFF9A4100),
                    decoration: TextDecoration.none,
                  ),
                ),
                SizedBox(width: 4),
                Icon(
                  Icons.arrow_forward,
                  color: Color(0xFF9A4100),
                  size: 12,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
