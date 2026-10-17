import 'package:flutter/material.dart';
import 'dart:ui';
import '../utils/app_strings.dart';

class AppHeader extends StatelessWidget {
  final int streakCount;
  final String? profileImageUrl;
  final VoidCallback? onBackPressed;

  const AppHeader({
    super.key,
    this.streakCount = 7,
    this.profileImageUrl,
    this.onBackPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFFEF9F2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            offset: const Offset(0, 1),
            blurRadius: 8,
            spreadRadius: 0,
          ),
        ],
      ),
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 24, sigmaY: 24),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // 1. Left side - Back button and App Title
                Expanded(
                  child: Row(
                    children: [
                      // Back button
                      GestureDetector(
                        onTap: () {
                          if (onBackPressed != null) {
                            onBackPressed!();
                          } else {
                            Navigator.of(context).pop();
                          }
                        },
                        child: Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(
                            Icons.arrow_back,
                            color: Color(0xFF1D1C18),
                            size: 24,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      // App Title with tagline
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // App title
                            Text(
                              AppStrings.saiVani,
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 20,
                                height: 1.4, // Line height 28 / font size 20 = 1.4
                                letterSpacing: -0.5,
                                color: Color(0xFF9A4100),
                                decoration: TextDecoration.none,
                              ),
                            ),
                            // Tag line
                            Text(
                              '${AppStrings.shradha} • ${AppStrings.saburi} (Shraddha & Saburi)',
                              textAlign: TextAlign.left,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 10,
                                height: 1.4, // Line height 14 / font size 10 = 1.4
                                letterSpacing: 0.25,
                                color: Color(0xFF8A7267),
                                decoration: TextDecoration.none,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                // 2. Right side - Streak and Profile
                Row(
                  children: [
                    // a. Streak container
                    Container(
                      height: 44,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.8),
                        borderRadius: BorderRadius.circular(9999),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Fire icon
                          const Icon(
                            Icons.local_fire_department,
                            color: Color(0xFFFEA619),
                            size: 20,
                          ),
                          const SizedBox(width: 4),
                          // Streak number
                          Text(
                            '$streakCount',
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 12,
                              color: Color(0xFF9A4100),
                              decoration: TextDecoration.none,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 4),
                    // b. Profile container
                    Container(
                      width: 44,
                      height: 44,
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.8),
                        borderRadius: BorderRadius.circular(9999),
                      ),
                      child: ClipOval(
                        child: profileImageUrl != null
                            ? Image.network(
                                profileImageUrl!,
                                width: 40,
                                height: 40,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return _defaultProfileIcon();
                                },
                              )
                            : _defaultProfileIcon(),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _defaultProfileIcon() {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: const Color(0xFFFEA619).withValues(alpha: 0.2),
        shape: BoxShape.circle,
      ),
      child: const Icon(
        Icons.person,
        color: Color(0xFF9A4100),
        size: 24,
      ),
    );
  }
}
