import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SevakMember {
  final String name;
  final String badge;
  final String role;
  final String quote;
  final IconData quoteIcon;
  final String description;
  final String imagePath;
  final IconData roleIcon;
  final List<SocialMedia> socialMedias;

  const SevakMember({
    required this.name,
    required this.badge,
    required this.role,
    required this.quote,
    required this.quoteIcon,
    required this.description,
    required this.imagePath,
    required this.roleIcon,
    required this.socialMedias,
  });
}

class SocialMedia {
  final String platform;
  final String username;
  final IconData icon;
  final String url;

  const SocialMedia({
    required this.platform,
    required this.username,
    required this.icon,
    required this.url,
  });
}

class SevakTeam extends StatelessWidget {
  final List<SevakMember> members;

  const SevakTeam({
    super.key,
    required this.members,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, // Fill width
      padding: const EdgeInsets.only(top: 20),
      child: Column(
        children: [
          // 1. Title container
          _buildTitleContainer(),

          // 2-4. Sevak containers
          ...members.map((member) => _buildSevakContainer(member)),
        ],
      ),
    );
  }

  Widget _buildTitleContainer() {
    return Container(
      width: double.infinity, // Fill width
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // a. Left - Icon + Text
          Row(
            children: [
              const Icon(
                Icons.people,
                color: Color(0xFF9A4100),
                size: 20,
              ),
              const SizedBox(width: 4),
              const Text(
                'रचनाकार परिचय (The Devotees)',
                style: TextStyle(
                  fontWeight: FontWeight.w600, // semibold
                  fontSize: 16,
                  height: 24 / 16, // line height 24
                  letterSpacing: 0,
                  color: Color(0xFF1D1C18),
                ),
              ),
            ],
          ),

          // b. Right - Count
          Text(
            '${members.length} Sevaks',
            style: const TextStyle(
              fontWeight: FontWeight.w500, // medium
              fontSize: 10,
              height: 14 / 10, // line height 14
              letterSpacing: 0.5,
              color: Color(0xFF765700),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSevakContainer(SevakMember member) {
    return Container(
      width: double.infinity, // Fill width
      padding: const EdgeInsets.only(top: 12),
      child: Container(
        width: double.infinity, // Fill width
        padding: const EdgeInsets.all(12),
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
            // 1. Top - Image and details
            _buildTopSection(member),

            // 2. Middle - Description
            _buildMiddleSection(member),

            // 3. Bottom - Social media
            _buildBottomSection(member),
          ],
        ),
      ),
    );
  }

  Widget _buildTopSection(SevakMember member) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // a. Left - Image with icon badge
        _buildImageWithBadge(member),

        const SizedBox(width: 12),

        // b. Right - Details
        Expanded(
          child: _buildMemberDetails(member),
        ),
      ],
    );
  }

  Widget _buildImageWithBadge(SevakMember member) {
    return SizedBox(
      width: 72, // Increased to accommodate badge overflow
      height: 72,
      child: Stack(
        clipBehavior: Clip.none, // Allow overflow
        children: [
          // Image
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              member.imagePath,
              width: 64,
              height: 64,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF2EDE6),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.person,
                    color: Color(0xFF9A4100),
                    size: 32,
                  ),
                );
              },
            ),
          ),

          // Icon badge at bottom-right
          Positioned(
            bottom: -3, // 15% outside
            right: -3,
            child: Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: const Color(0xFFFEA619),
                borderRadius: BorderRadius.circular(9999),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF000000).withOpacity(0.05),
                    offset: const Offset(0, 1),
                    blurRadius: 2,
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: Icon(
                member.roleIcon,
                color: const Color(0xFF684000),
                size: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMemberDetails(SevakMember member) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // i. Top - Name and badge
        Row(
          children: [
            // Name
            Expanded(
              child: Text(
                member.name,
                style: const TextStyle(
                  fontWeight: FontWeight.w600, // semibold
                  fontSize: 16,
                  height: 24 / 16, // line height 24
                  letterSpacing: 0,
                  color: Color(0xFF1D1C18),
                ),
              ),
            ),

            const SizedBox(width: 8),

            // Badge
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: const Color(0xFFFFDDB8),
                borderRadius: BorderRadius.circular(9999),
              ),
              child: Text(
                member.badge,
                style: const TextStyle(
                  fontWeight: FontWeight.w500, // medium
                  fontSize: 10,
                  height: 14 / 10, // line height 14
                  letterSpacing: 0.5,
                  color: Color(0xFF2A1700),
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 2),

        // ii. Middle - Role
        Text(
          member.role,
          style: const TextStyle(
            fontWeight: FontWeight.w500, // medium
            fontSize: 10,
            height: 14 / 10, // line height 14
            letterSpacing: 0.25,
            color: Color(0xFF9A4100),
          ),
        ),

        const SizedBox(height: 4),

        // iii. Bottom - Quote with icon
        Row(
          children: [
            Icon(
              member.quoteIcon,
              color: const Color(0xFF765700),
              size: 12,
            ),
            const SizedBox(width: 4),
            Expanded(
              child: Text(
                member.quote,
                style: const TextStyle(
                  fontWeight: FontWeight.w600, // semibold
                  fontSize: 10,
                  height: 14 / 10, // line height 14
                  letterSpacing: 0.5,
                  color: Color(0xFF574238),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMiddleSection(SevakMember member) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 8),
      child: Text(
        member.description,
        textAlign: TextAlign.left,
        style: const TextStyle(
          fontWeight: FontWeight.w400, // regular
          fontSize: 12,
          height: 19.5 / 12, // line height 19.5
          letterSpacing: 0,
          color: Color(0xFF574238),
        ),
      ),
    );
  }

  Widget _buildBottomSection(SevakMember member) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 12),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 8),
        decoration: BoxDecoration(
          color: const Color(0xFFFFFFFF).withOpacity(0.60), // 60% opacity
          borderRadius: BorderRadius.circular(8),
        ),
        child: Wrap(
          spacing: 8,
          runSpacing: 8,
          children: member.socialMedias.map((social) {
            return _buildSocialMediaButton(social);
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildSocialMediaButton(SocialMedia social) {
    return GestureDetector(
      onTap: () async {
        final uri = Uri.parse(social.url);
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri, mode: LaunchMode.externalApplication);
        }
      },
      child: Container(
        height: 28,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: const Color(0xFFF2EDE6),
          borderRadius: BorderRadius.circular(9999),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              social.icon,
              color: const Color(0xFF574238),
              size: 14,
            ),
            const SizedBox(width: 6),
            Flexible(
              child: Text(
                social.username,
                style: const TextStyle(
                  fontWeight: FontWeight.w600, // semibold
                  fontSize: 10,
                  height: 14 / 10, // line height 14
                  letterSpacing: 0.5,
                  color: Color(0xFF574238),
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Sample data for 3 Sevaks
class SevakTeamData {
  static final List<SevakMember> members = [
    // Aniket Kumar
    SevakMember(
      name: 'Aniket Kumar',
      badge: 'Developer',
      role: 'Founder & Sacred Product Architect',
      quote: 'Following Baba\'s path, to get Baba.',
      quoteIcon: Icons.directions_walk_outlined,
      description: 'Dedicated to crafting serene digital spaces with sacred multilingual support, intuitive audio-reading synchrony, and fluid meditative mobile experiences for Baba\'s devotees.',
      imagePath: 'assets/image/sevak/model.png',
      roleIcon: Icons.architecture,
      socialMedias: [
        const SocialMedia(
          platform: 'Instagram',
          username: 'sai.nkt.exe',
          icon: Icons.camera_alt,
          url: 'https://www.instagram.com/sai.nkt.exe',
        ),
        const SocialMedia(
          platform: 'LinkedIn',
          username: 'theanikumar',
          icon: Icons.work,
          url: 'https://www.linkedin.com/in/theanikumar',
        ),
        const SocialMedia(
          platform: 'Email',
          username: 'aniket@saivani.com',
          icon: Icons.email,
          url: 'mailto:aniket@saivani.com',
        ),
      ],
    ),

    // Souvviek Kabi
    SevakMember(
      name: 'Souvviek Kabi',
      badge: 'Singer',
      role: 'Co-Founder & Devotional Audio Lead',
      quote: 'Spreading Baba\'s glory worldwide.',
      quoteIcon: Icons.public,
      description: 'A devoted voice bringing Sai Baba\'s leelas and bhajans to life, creating soul-stirring audio experiences that touch hearts across continents and connect devotees through sacred melodies.',
      imagePath: 'assets/image/sevak/model.png',
      roleIcon: Icons.graphic_eq,
      socialMedias: [
        const SocialMedia(
          platform: 'Instagram',
          username: 'souvviekkabi18',
          icon: Icons.camera_alt,
          url: 'https://www.instagram.com/souvviekkabi18',
        ),
        const SocialMedia(
          platform: 'LinkedIn',
          username: 'souvviek-kabi',
          icon: Icons.work,
          url: 'https://www.linkedin.com/in/souvviek-kabi',
        ),
        const SocialMedia(
          platform: 'Email',
          username: 'souvviek@saivani.com',
          icon: Icons.email,
          url: 'mailto:souvviek@saivani.com',
        ),
      ],
    ),

    // Dr. Mukesh Bathre
    SevakMember(
      name: 'Dr. Mukesh Bathre',
      badge: 'Volunteer Help',
      role: 'Community Guide & Content Advisor',
      quote: 'Sharing Baba\'s wisdom with all.',
      quoteIcon: Icons.menu_book,
      description: 'A learned devotee offering guidance on authentic Satcharitra interpretations, ensuring content accuracy, and helping shape Sai Vani as a trustworthy spiritual companion for the global parivar.',
      imagePath: 'assets/image/sevak/model.png',
      roleIcon: Icons.verified,
      socialMedias: [
        const SocialMedia(
          platform: 'Email',
          username: 'mukesh@saivani.com',
          icon: Icons.email,
          url: 'mailto:mukesh@saivani.com',
        ),
      ],
    ),
  ];
}
