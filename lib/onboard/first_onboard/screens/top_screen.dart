import 'package:flutter/material.dart';
import '../wedigts/sai_bab_circle_background.dart';
import '../wedigts/shradha_saburi.dart';
import '../wedigts/sai_jaikar.dart';
import '../wedigts/sai_vani.dart';
import '../wedigts/sai_vani_tag.dart';

class TopScreen extends StatelessWidget {
  const TopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Color(0xFFF8F3EC),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(40),
          bottomRight: Radius.circular(40),
        ),
      ),
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
        top: 16,
        bottom: 32,
      ),
      child: Container(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.center,
            radius: 0.5,
            colors: [
              Color(0xFFFEA619), // Orange center
              Color(0xF8F3EC),      // White outer
            ],
            stops: [0.0, 1.0],
          ),
        ),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
          // Circle background with Sai Baba image and Shradha Saburi badge
          Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none,
            children: [
              // Rotating circle background
              SaiBabCircleBackground(),

              // Sai Baba image in center
              CircleAvatar(
                radius: 56, // 112 / 2
                backgroundColor: Colors.white,
                child: CircleAvatar(
                  radius: 54, // 56 - 2 (border width)
                  backgroundImage: AssetImage('assets/image/onboarding/sai_baba.png'),
                ),
              ),

              // Shradha Saburi badge at bottom of image
              Positioned(
                bottom: -9, // Half of badge height to attach to bottom
                child: ShradhaSaburi(),
              ),
            ],
          ),

          SizedBox(height: 16),

          // Sai Jaikar
          SaiJaikar(),

          // Sai Vani title
          SaiVani(),

          // Sai Vani tagline
          SaiVaniTag(),
        ],
      ),
      ),
    );
  }
}
