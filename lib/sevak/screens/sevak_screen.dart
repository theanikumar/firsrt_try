import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../common/app_header.dart';
import '../../common/bottom_navigation.dart';
import '../../core/auth/auth_provider.dart';
import '../../core/models/content.dart';
import '../../core/team/team_provider.dart';
import '../../routes/app_routes.dart';
import '../widgets/sevak_end_greeting.dart';
import '../widgets/sevak_greeting.dart';
import '../widgets/sevak_sankalp.dart';
import '../widgets/sevak_team.dart';

class SevakScreen extends StatefulWidget {
  const SevakScreen({super.key});

  @override
  State<SevakScreen> createState() => _SevakScreenState();
}

class _SevakScreenState extends State<SevakScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<TeamProvider>().ensureLoaded();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    final team = context.watch<TeamProvider>();

    return Scaffold(
      backgroundColor: const Color(0xFFF8F3EC),
      body: SafeArea(
        child: Column(
          children: [
            AppHeader(
              streakCount: 0,
              profileImageUrl: auth.devotee?.avatarUrl.isNotEmpty == true
                  ? auth.devotee!.avatarUrl
                  : null,
              onBackPressed: () => AppRoutes.replaceWithHome(context),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(
                  left: 16,
                  right: 16,
                  bottom: 32,
                ),
                child: Column(
                  children: [
                    const SevakGreeting(),
                    const SevakSankalp(),
                    if (team.isLoading && team.members.isEmpty)
                      const Padding(
                        padding: EdgeInsets.all(32),
                        child: CircularProgressIndicator(),
                      )
                    else if (team.error != null && team.members.isEmpty)
                      _buildErrorState(team)
                    else if (team.members.isEmpty)
                      _buildEmptyState()
                    else
                      SevakTeam(
                        members: team.members.map(_toSevakMember).toList(),
                      ),
                    const SizedBox(height: 20),
                    _buildFeedbackComingSoon(),
                    const SevakEndGreeting(),
                  ],
                ),
              ),
            ),
            BottomNavigation(
              currentIndex: 3,
              onTap: _handleNavigation,
            ),
          ],
        ),
      ),
    );
  }

  void _handleNavigation(int index) {
    if (index == 3) return;

    switch (index) {
      case 0:
        AppRoutes.replaceWithParayan(context);
        break;
      case 1:
        AppRoutes.replaceWithExplore(context);
        break;
      case 2:
        AppRoutes.navigateToPlayer(context);
        break;
      case 4:
        AppRoutes.replaceWithSettings(context);
        break;
    }
  }

  Widget _buildErrorState(TeamProvider team) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          const Icon(Icons.cloud_off, size: 32, color: Color(0xFF9A4100)),
          const SizedBox(height: 8),
          Text(
            team.error ?? 'The seva team could not be loaded.',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 13,
              height: 1.5,
              color: Color(0xFF574238),
            ),
          ),
          const SizedBox(height: 8),
          TextButton(onPressed: team.refresh, child: const Text('Retry')),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return const Padding(
      padding: EdgeInsets.all(24),
      child: Text(
        'The seva team is being updated.',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 13, color: Color(0xFF8A7267)),
      ),
    );
  }

  Widget _buildFeedbackComingSoon() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF000000).withValues(alpha: 0.05),
            offset: const Offset(0, 1),
            blurRadius: 2,
          ),
        ],
      ),
      child: const Row(
        children: [
          Icon(Icons.mark_email_unread_outlined, color: Color(0xFF9A4100)),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              'Feedback and volunteer sign-up are coming in a future update.',
              style: TextStyle(
                fontSize: 12,
                height: 1.5,
                color: Color(0xFF574238),
              ),
            ),
          ),
        ],
      ),
    );
  }

  SevakMember _toSevakMember(TeamMember member) {
    return SevakMember(
      name: member.name,
      badge: member.badge,
      role: member.roleTitle,
      quote: member.quote,
      quoteIcon: Icons.format_quote,
      description: member.description,
      imagePath: 'assets/image/sevak/model.png',
      roleIcon: _roleIcon(member.roleIcon),
      socialMedias: member.socialLinks
          .map(
            (link) => SocialMedia(
              platform: link.platform,
              username: link.username,
              icon: _socialIcon(link.platform),
              url: link.url,
            ),
          )
          .toList(),
    );
  }
}

IconData _roleIcon(String name) {
  switch (name) {
    case 'architecture':
      return Icons.architecture;
    case 'graphic_eq':
      return Icons.graphic_eq;
    case 'verified':
      return Icons.verified;
    default:
      return Icons.person;
  }
}

IconData _socialIcon(String platform) {
  switch (platform.toLowerCase()) {
    case 'instagram':
      return Icons.camera_alt;
    case 'linkedin':
      return Icons.work;
    case 'email':
      return Icons.email;
    case 'youtube':
      return Icons.play_circle_outline;
    case 'telegram':
      return Icons.send_rounded;
    default:
      return Icons.link;
  }
}
