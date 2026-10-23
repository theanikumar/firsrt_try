import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../common/app_header.dart';
import '../../common/bottom_navigation.dart';
import '../../core/auth/auth_provider.dart';
import '../../core/bootstrap/bootstrap_provider.dart';
import '../../core/favorites/favorites_provider.dart';
import '../../core/models/bootstrap.dart';
import '../../core/models/offering.dart';
import '../../core/repositories/catalog_repository.dart';
import '../../routes/app_routes.dart';
import '../../services/audio_service.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _updatingLanguage = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<FavoritesProvider>().ensureLoaded();
      }
    });
  }

  Future<void> _selectLanguage(LanguageOption option) async {
    if (_updatingLanguage) return;
    final auth = context.read<AuthProvider>();
    if (auth.language == option.code) return;

    setState(() => _updatingLanguage = true);
    try {
      await auth.updateProfile(language: option.code);
      if (!mounted) return;
      final message = option.uiReady
          ? '${option.nativeName} selected.'
          : '${option.nativeName} saved. The app will use English until this language is ready.';
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Language could not be saved.')),
      );
    } finally {
      if (mounted) setState(() => _updatingLanguage = false);
    }
  }

  Future<void> _signOut() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Sign out?'),
        content: const Text(
          'You will need a new phone OTP to sign in again.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text('Sign out'),
          ),
        ],
      ),
    );
    if (confirmed != true || !mounted) return;

    context.read<FavoritesProvider>().clear();
    await context.read<AuthProvider>().logout();
    if (!mounted) return;
    Navigator.of(context).pushNamedAndRemoveUntil(
      AppRoutes.login,
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    final bootstrap = context.watch<BootstrapProvider>();
    final favorites = context.watch<FavoritesProvider>();
    final devotee = auth.devotee;
    final languages = bootstrap.languages;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F3EC),
      body: SafeArea(
        child: Column(
          children: [
            AppHeader(
              streakCount: 0,
              profileImageUrl: devotee?.avatarUrl.isNotEmpty == true
                  ? devotee!.avatarUrl
                  : null,
              onBackPressed: () => AppRoutes.replaceWithHome(context),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildProfileCard(auth),
                    const SizedBox(height: 20),
                    _buildSectionTitle(
                      favorites.count == 0
                          ? 'Saved offerings'
                          : 'Saved offerings (${favorites.count})',
                    ),
                    const SizedBox(height: 8),
                    _buildSavedCard(favorites),
                    const SizedBox(height: 20),
                    _buildSectionTitle('Language'),
                    const SizedBox(height: 8),
                    _buildLanguageCard(languages),
                    const SizedBox(height: 20),
                    _buildSectionTitle('Sankalp'),
                    const SizedBox(height: 8),
                    _buildSankalpCard(),
                    const SizedBox(height: 20),
                    _buildSectionTitle('About'),
                    const SizedBox(height: 8),
                    _buildAboutCard(bootstrap),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        onPressed: auth.isBusy ? null : _signOut,
                        icon: const Icon(Icons.logout),
                        label: const Text('Sign out'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: const Color(0xFF9A4100),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          side: const BorderSide(color: Color(0xFFE8C9A0)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            BottomNavigation(
              currentIndex: 4,
              onTap: _handleNavigation,
            ),
          ],
        ),
      ),
    );
  }

  void _handleNavigation(int index) {
    if (index == 4) return;

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
      case 3:
        AppRoutes.replaceWithSevak(context);
        break;
    }
  }

  Widget _buildProfileCard(AuthProvider auth) {
    final devotee = auth.devotee;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            offset: const Offset(0, 1),
            blurRadius: 2,
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 28,
            backgroundColor: const Color(0xFFFFDBCB),
            backgroundImage: devotee?.avatarUrl.isNotEmpty == true
                ? NetworkImage(devotee!.avatarUrl)
                : null,
            child: devotee?.avatarUrl.isNotEmpty == true
                ? null
                : Text(
                    auth.initials,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF783100),
                    ),
                  ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  auth.displayName,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                    color: Color(0xFF1D1C18),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  devotee?.phone.isNotEmpty == true
                      ? devotee!.phone
                      : 'Phone not set',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF574238),
                  ),
                ),
                if (devotee?.email.isNotEmpty == true) ...[
                  const SizedBox(height: 2),
                  Text(
                    devotee!.email,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF8A7267),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSavedCard(FavoritesProvider favorites) {
    if (favorites.isLoading && favorites.items.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(24),
        child: Center(child: CircularProgressIndicator()),
      );
    }

    if (favorites.items.isEmpty) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFFFFFFFF),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              offset: const Offset(0, 1),
              blurRadius: 2,
            ),
          ],
        ),
        child: const Text(
          'No saved offerings yet. Tap the heart on any recording to keep it here.',
          style: TextStyle(
            fontSize: 12,
            height: 1.5,
            color: Color(0xFF574238),
          ),
        ),
      );
    }

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            offset: const Offset(0, 1),
            blurRadius: 2,
          ),
        ],
      ),
      child: Column(
        children: [
          for (var index = 0; index < favorites.items.length; index++) ...[
            if (index > 0) const Divider(height: 1),
            _buildSavedRow(favorites.items[index]),
          ],
        ],
      ),
    );
  }

  Widget _buildSavedRow(Offering offering) {
    return ListTile(
      leading: const CircleAvatar(
        backgroundColor: Color(0xFFFFDBCB),
        child: Icon(Icons.music_note, color: Color(0xFF783100)),
      ),
      title: Text(
        offering.title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        offering.artistName.isEmpty ? 'Saved offering' : offering.artistName,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: IconButton(
        icon: const Icon(Icons.favorite, color: Color(0xFF9A4100)),
        tooltip: 'Remove from saved',
        onPressed: () async {
          try {
            await context
                .read<FavoritesProvider>()
                .toggle(offering.id, offering: offering);
          } catch (_) {
            if (!mounted) return;
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Saved offerings could not be updated.'),
              ),
            );
          }
        },
      ),
      onTap: offering.isPlayable ? () => _playOffering(offering) : null,
    );
  }

  Future<void> _playOffering(Offering offering) async {
    final song = Song(
      id: offering.id.toString(),
      title: offering.title,
      artist: offering.artistName,
      youtubeUrl: offering.youtubeUrl,
      videoId: offering.youtubeVideoId,
      duration: offering.duration,
      category: offering.category,
      thumbnailUrl: offering.thumbnailUrl,
      isSaptahParayan: offering.offeringType == 'parayan',
    );

    await context.read<AudioService>().playSong(song);
    if (!mounted) return;
    unawaited(context.read<CatalogRepository>().reportPlay(offering.id));
    AppRoutes.navigateToPlayer(context);
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 13,
        letterSpacing: 0.4,
        color: Color(0xFF765700),
      ),
    );
  }

  Widget _buildLanguageCard(List<LanguageOption> languages) {
    final current = context.watch<AuthProvider>().language;
    final items = languages.isEmpty ? _fallbackLanguages : languages;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            offset: const Offset(0, 1),
            blurRadius: 2,
          ),
        ],
      ),
      child: Column(
        children: [
          for (var index = 0; index < items.length; index++) ...[
            if (index > 0) const Divider(height: 1),
            _buildLanguageRow(items[index], current),
          ],
        ],
      ),
    );
  }

  Widget _buildLanguageRow(LanguageOption option, String current) {
    final selected = option.code == current;
    return ListTile(
      onTap: _updatingLanguage ? null : () => _selectLanguage(option),
      title: Text(
        option.nativeName,
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
      subtitle: Text(option.name),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (!option.uiReady)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: const Color(0xFFF2EDE6),
                borderRadius: BorderRadius.circular(9999),
              ),
              child: const Text(
                'Coming soon',
                style: TextStyle(fontSize: 10, color: Color(0xFF8A7267)),
              ),
            ),
          if (selected) ...[
            const SizedBox(width: 8),
            const Icon(Icons.check_circle, color: Color(0xFF9A4100)),
          ],
        ],
      ),
    );
  }

  Widget _buildSankalpCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            offset: const Offset(0, 1),
            blurRadius: 2,
          ),
        ],
      ),
      child: const Row(
        children: [
          Icon(Icons.self_improvement, color: Color(0xFF9A4100)),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              'Set your Saptah Parayan sankalp here in an upcoming update. '
              'Until then, you can listen to every recorded adhyay from Parayan.',
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

  Widget _buildAboutCard(BootstrapProvider bootstrap) {
    final app = bootstrap.data?.app;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            offset: const Offset(0, 1),
            blurRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            app?.name ?? 'Sai Vani',
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 16,
              color: Color(0xFF1D1C18),
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'A quiet companion for Sai Satcharitra, bhajans and daily darshan.',
            style: TextStyle(
              fontSize: 12,
              height: 1.5,
              color: Color(0xFF574238),
            ),
          ),
          if (app?.supportEmail.isNotEmpty == true) ...[
            const SizedBox(height: 8),
            Text(
              app!.supportEmail,
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xFF9A4100),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

const _fallbackLanguages = [
  LanguageOption(
    code: 'hi',
    name: 'Hindi',
    nativeName: 'हिन्दी',
    uiReady: true,
    audioReady: true,
  ),
  LanguageOption(
    code: 'mr',
    name: 'Marathi',
    nativeName: 'मराठी',
    uiReady: true,
    audioReady: true,
  ),
  LanguageOption(
    code: 'te',
    name: 'Telugu',
    nativeName: 'తెలుగు',
    uiReady: false,
    audioReady: false,
  ),
  LanguageOption(
    code: 'en',
    name: 'English',
    nativeName: 'English',
    uiReady: true,
    audioReady: true,
  ),
  LanguageOption(
    code: 'gu',
    name: 'Gujarati',
    nativeName: 'ગુજરાતી',
    uiReady: false,
    audioReady: false,
  ),
  LanguageOption(
    code: 'or',
    name: 'Odia',
    nativeName: 'ଓଡ଼ିଆ',
    uiReady: false,
    audioReady: false,
  ),
];
