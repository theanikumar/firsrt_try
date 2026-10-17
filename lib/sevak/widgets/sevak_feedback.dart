import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialChannel {
  final String platform;
  final IconData icon;
  final String description;
  final String url;

  const SocialChannel({
    required this.platform,
    required this.icon,
    required this.description,
    required this.url,
  });
}

class SevakFeedback extends StatelessWidget {
  final VoidCallback? onSendFeedback;
  final VoidCallback? onJoinVolunteer;
  final List<SocialChannel> socialChannels;

  const SevakFeedback({
    super.key,
    this.onSendFeedback,
    this.onJoinVolunteer,
    required this.socialChannels,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, // Fill width
      padding: const EdgeInsets.only(top: 20),
      child: Container(
        width: double.infinity, // Fill width
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color(0xFFF8F3EC),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF000000).withOpacity(0.05), // 5% opacity
              offset: const Offset(0, 1),
              blurRadius: 2,
              spreadRadius: 0,
            ),
          ],
        ),
        child: Column(
          children: [
            // 1. Message container
            _buildMessageContainer(),

            // 2. Button container
            _buildButtonContainer(context),

            // 3. Social container
            _buildSocialContainer(),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageContainer() {
    return Container(
      width: double.infinity, // Fill width
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // a. Top - Icon and title
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(
                Icons.handshake,
                color: Color(0xFF9A4100),
                size: 20,
              ),
              const SizedBox(width: 8),
              const Expanded(
                child: Text(
                  'Have a Suggestion or Want to Volunteer?',
                  style: TextStyle(
                    fontWeight: FontWeight.w600, // semibold
                    fontSize: 16,
                    height: 24 / 16, // line height 24
                    letterSpacing: 0,
                    color: Color(0xFF1D1C18),
                  ),
                ),
              ),
            ],
          ),

          // b. Bottom - Message
          Container(
            padding: const EdgeInsets.only(top: 4),
            child: const Text(
              'We rely on the worldwide family of Sai devotees to help verify translations, contribute audio recordings, and share miraculous Baba experiences.',
              textAlign: TextAlign.left,
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

  Widget _buildButtonContainer(BuildContext context) {
    return Container(
      width: double.infinity, // Fill width
      padding: const EdgeInsets.only(top: 12),
      child: Column(
        children: [
          // Button 1 - Send Feedback
          _buildButton(
            icon: Icons.send,
            label: 'Send Feedback / Baba Leela Story',
            backgroundColor: const Color(0xFF9A4100),
            textColor: const Color(0xFFFFFFFF),
            iconColor: const Color(0xFFFFFFFF),
            onTap: onSendFeedback,
          ),

          const SizedBox(height: 8), // Gap 8

          // Button 2 - Join as Volunteer
          _buildButton(
            icon: Icons.person_add_alt_1,
            label: 'Join as Volunteer Sevaak (Audio/Translation)',
            backgroundColor: const Color(0xFFECE7E1),
            textColor: const Color(0xFF1D1C18),
            iconColor: const Color(0xFF765700),
            onTap: onJoinVolunteer,
          ),
        ],
      ),
    );
  }

  Widget _buildButton({
    required IconData icon,
    required String label,
    required Color backgroundColor,
    required Color textColor,
    required Color iconColor,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity, // Fill width
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF000000).withOpacity(0.05),
              offset: const Offset(0, 1),
              blurRadius: 2,
              spreadRadius: 0,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: iconColor,
              size: 18,
            ),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                label,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w600, // semibold
                  fontSize: 14,
                  height: 20 / 14, // line height 20
                  letterSpacing: 0.28,
                  color: textColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSocialContainer() {
    return Container(
      width: double.infinity, // Fill width
      padding: const EdgeInsets.only(top: 12),
      child: Container(
        width: double.infinity, // Fill width
        padding: const EdgeInsets.only(top: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // a. Top - Title
            const Text(
              'DEVOTEE SATSANG CHANNELS',
              style: TextStyle(
                fontWeight: FontWeight.w600, // semibold
                fontSize: 10,
                height: 14 / 10, // line height 14
                letterSpacing: 0.5,
                color: Color(0xFF765700),
              ),
            ),

            // b. Bottom - Social channels (horizontal)
            Container(
              width: double.infinity, // Fill width
              padding: const EdgeInsets.only(top: 8),
              child: Row(
                children: socialChannels.asMap().entries.map((entry) {
                  final isLast = entry.key == socialChannels.length - 1;
                  return Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(right: isLast ? 0 : 8),
                      child: _buildSocialChannelCard(entry.value),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSocialChannelCard(SocialChannel channel) {
    return GestureDetector(
      onTap: () async {
        final uri = Uri.parse(channel.url);
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri, mode: LaunchMode.externalApplication);
        }
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: const Color(0xFFFFFFFF),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            // i. Icon container
            Container(
              width: 32,
              height: 36,
              padding: const EdgeInsets.only(bottom: 4),
              child: Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: const Color(0xFFFFDDB8),
                  borderRadius: BorderRadius.circular(9999),
                ),
                child: Icon(
                  channel.icon,
                  color: const Color(0xFF9A4100),
                  size: 18,
                ),
              ),
            ),

            // ii. Platform name container
            SizedBox(
              width: double.infinity,
              child: Text(
                channel.platform,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.w500, // medium
                  fontSize: 10,
                  height: 14 / 10, // line height 14
                  letterSpacing: 0.5,
                  color: Color(0xFF1D1C18),
                ),
              ),
            ),

            // iii. Description container
            SizedBox(
              width: double.infinity,
              child: Text(
                channel.description,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.w400, // regular
                  fontSize: 10,
                  height: 15 / 10, // line height 15
                  letterSpacing: 0,
                  color: Color(0xFF574238),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Sample data for social channels
class SevakFeedbackData {
  static final List<SocialChannel> channels = [
    const SocialChannel(
      platform: 'Instagram',
      icon: Icons.camera_alt,
      description: 'Daily Updates',
      url: 'https://www.instagram.com/saivani.app',
    ),
    const SocialChannel(
      platform: 'YouTube',
      icon: Icons.play_circle_outline,
      description: 'Video Content',
      url: 'https://www.youtube.com/@saivani',
    ),
    const SocialChannel(
      platform: 'Telegram',
      icon: Icons.send_rounded,
      description: 'Community Chat',
      url: 'https://t.me/saivani',
    ),
  ];
}
