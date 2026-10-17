import 'package:flutter/material.dart';

class PlayerSongDetails extends StatelessWidget {
  final bool isSaptahParayan;
  final String categoryName;
  final IconData categoryIcon;
  final String songName;
  final String singerOrAdhyayTitle;
  final String? readerDetails;

  const PlayerSongDetails({
    super.key,
    this.isSaptahParayan = false,
    this.categoryName = 'Devotional Bhajan',
    this.categoryIcon = Icons.music_note,
    required this.songName,
    required this.singerOrAdhyayTitle,
    this.readerDetails,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 8, bottom: 12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 1. Categories widget
          _buildCategoriesWidget(),
          const SizedBox(height: 8),

          // 2. Song name widget
          _buildSongNameWidget(),
          const SizedBox(height: 4),

          // 3. Singer/Adhyay title widget
          _buildSingerOrAdhyayWidget(),

          // 4. Reader details (only for Saptah Parayan)
          if (isSaptahParayan && readerDetails != null) ...[
            const SizedBox(height: 4),
            _buildReaderDetailsWidget(),
          ],
        ],
      ),
    );
  }

  // 1. Categories widget
  Widget _buildCategoriesWidget() {
    // For Saptah Parayan
    if (isSaptahParayan) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        decoration: BoxDecoration(
          color: const Color(0xFFFFDDB8),
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
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Icon - Open book for Saptah Parayan
            const Icon(
              Icons.menu_book,
              color: Color(0xFF2A1700),
              size: 16,
            ),
            const SizedBox(width: 6),
            // Text - Day info
            Text(
              categoryName,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 12,
                height: 1.33, // Line height 16 / font size 12 = 1.33
                letterSpacing: 0.36,
                color: Color(0xFF2A1700),
                decoration: TextDecoration.none,
              ),
            ),
          ],
        ),
      );
    }

    // For regular bhajan
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFFFDDB8),
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
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Icon
          Icon(
            categoryIcon,
            color: const Color(0xFF2A1700),
            size: 16,
          ),
          const SizedBox(width: 6),
          // Text - Category name
          Text(
            categoryName,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 12,
              height: 1.33, // Line height 16 / font size 12 = 1.33
              letterSpacing: 0.36,
              color: Color(0xFF2A1700),
              decoration: TextDecoration.none,
            ),
          ),
        ],
      ),
    );
  }

  // 2. Song name widget
  Widget _buildSongNameWidget() {
    return Text(
      songName,
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 22,
        height: 1.364, // Line height 30 / font size 22 = 1.364
        letterSpacing: -0.5,
        color: Color(0xFF1D1C18),
        decoration: TextDecoration.none,
      ),
    );
  }

  // 3. Singer/Adhyay title widget
  Widget _buildSingerOrAdhyayWidget() {
    return Padding(
      padding: const EdgeInsets.only(top: 2),
      child: Text(
        singerOrAdhyayTitle,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 16,
          height: 1.5, // Line height 24 / font size 16 = 1.5
          letterSpacing: 0,
          color: Color(0xFF9A4100),
          decoration: TextDecoration.none,
        ),
      ),
    );
  }

  // 4. Reader details widget (only for Saptah Parayan)
  Widget _buildReaderDetailsWidget() {
    return Padding(
      padding: const EdgeInsets.only(top: 4, left: 23.5, right: 23.5),
      child: Text(
        readerDetails!,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 12,
          height: 1.25, // Line height 15 / font size 12 = 1.25
          letterSpacing: 0,
          color: Color(0xFF8A7267),
          decoration: TextDecoration.none,
        ),
      ),
    );
  }
}
