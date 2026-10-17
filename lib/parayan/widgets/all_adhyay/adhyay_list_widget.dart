import 'package:flutter/material.dart';
import '../../../utils/app_strings.dart';
import '../../../data/adhyay_data.dart';
import '../../../data/adhyay_youtube_links.dart';

enum AdhyayStatus { completed, readingNow, upNext, unread }

class AdhyayListWidget extends StatelessWidget {
  final Function(int adhyayNumber, String videoId)? onReadTap;

  const AdhyayListWidget({
    super.key,
    this.onReadTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Section title
        _buildSectionTitle(),

        // Main container with chapter widgets
        Container(
          width: double.infinity, // Fill width
          padding: const EdgeInsets.only(
            left: 16,
            right: 16,
            top: 4,
            bottom: 20,
          ),
          child: Column(
            children: List.generate(
              51,
              (index) {
                final adhyayNumber = index + 1;
                AdhyayStatus status;

                if (adhyayNumber <= 2) {
                  status = AdhyayStatus.completed;
                } else if (adhyayNumber == 3) {
                  status = AdhyayStatus.readingNow;
                } else if (adhyayNumber == 4) {
                  status = AdhyayStatus.upNext;
                } else {
                  status = AdhyayStatus.unread;
                }

                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: _buildChapterCard(adhyayNumber, status),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSectionTitle() {
    return Container(
      width: double.infinity, // Fill width
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Left - Title and count
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppStrings.satcharitaIndex,
                style: const TextStyle(
                  fontWeight: FontWeight.w700, // bold
                  fontSize: 14,
                  height: 20 / 14, // line height 20
                  letterSpacing: 0.28,
                  color: Color(0xFF1D1C18),
                ),
              ),
              Text(
                AppStrings.adhyaysCount,
                style: const TextStyle(
                  fontWeight: FontWeight.w600, // semibold
                  fontSize: 10,
                  color: Color(0xFF8A7267),
                ),
              ),
            ],
          ),

          // Right - Order with icon
          Row(
            children: [
              const Icon(
                Icons.reorder,
                size: 16,
                color: Color(0xFF765700),
              ),
              const SizedBox(width: 4),
              Text(
                AppStrings.order,
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
        ],
      ),
    );
  }

  Widget _buildChapterCard(int adhyayNumber, AdhyayStatus status) {
    return Container(
      width: double.infinity, // Fill width
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF),
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
          // 1. Adhyay number widget
          _buildAdhyayNumberWidget(adhyayNumber, status),

          const SizedBox(height: 4),

          // 2. Adhyay Detail Widget
          _buildAdhyayDetailWidget(adhyayNumber, status),

          const SizedBox(height: 4),

          // 3. CTA Widget
          _buildCTAWidget(adhyayNumber, status),
        ],
      ),
    );
  }

  Widget _buildCTAWidget(int adhyayNumber, AdhyayStatus status) {
    return Container(
      width: double.infinity, // Fill width
      padding: const EdgeInsets.only(top: 4),
      child: Row(
        children: [
          // Left - CTA Button
          _buildCTAButton(adhyayNumber, status),

          // Right - Empty for now (can be used for additional actions)
          const Spacer(),
        ],
      ),
    );
  }

  Widget _buildCTAButton(int adhyayNumber, AdhyayStatus status) {
    final languageCode = AppStrings.currentLanguage;
    final videoId = AdhyayYoutubeLinks.getVideoIdForAdhyay(adhyayNumber, languageCode);

    String buttonText;
    Color backgroundColor;
    Color textColor;
    Color iconColor;
    EdgeInsets padding;
    double fontSize;
    FontWeight fontWeight;
    double letterSpacing;
    double gap;
    List<BoxShadow>? boxShadow;

    switch (status) {
      case AdhyayStatus.completed:
        buttonText = AppStrings.readAgain;
        backgroundColor = const Color(0xFFFFDDB8).withOpacity(0.30); // 30% opacity
        textColor = const Color(0xFF9A4100);
        iconColor = const Color(0xFF9A4100);
        padding = const EdgeInsets.symmetric(horizontal: 12, vertical: 6);
        fontSize = 10;
        fontWeight = FontWeight.w600; // semibold
        letterSpacing = 0.5;
        gap = 4;
        break;

      case AdhyayStatus.readingNow:
        buttonText = AppStrings.resumeReading;
        backgroundColor = const Color(0xFF9A4100);
        textColor = const Color(0xFFFFFFFF);
        iconColor = const Color(0xFFFFFFFF);
        padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 8);
        fontSize = 12;
        fontWeight = FontWeight.w700; // bold
        letterSpacing = 0.36;
        gap = 6;
        boxShadow = [
          BoxShadow(
            color: const Color(0xFF000000).withOpacity(0.05), // 5% opacity
            offset: const Offset(0, 1),
            blurRadius: 2,
            spreadRadius: 0,
          ),
        ];
        break;

      case AdhyayStatus.upNext:
      case AdhyayStatus.unread:
        buttonText = AppStrings.read;
        backgroundColor = const Color(0xFFF2EDE6);
        textColor = const Color(0xFF1D1C18);
        iconColor = const Color(0xFF1D1C18);
        padding = const EdgeInsets.symmetric(horizontal: 12, vertical: 6);
        fontSize = 10;
        fontWeight = FontWeight.w600; // semibold
        letterSpacing = 0.5;
        gap = 4;
        break;
    }

    return GestureDetector(
      onTap: () {
        if (onReadTap != null) {
          onReadTap!(adhyayNumber, videoId);
        }
        print('Playing Adhyay $adhyayNumber with video ID: $videoId');
      },
      child: Container(
        padding: padding,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(9999),
          boxShadow: boxShadow,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.menu_book,
              size: 16,
              color: iconColor,
            ),
            SizedBox(width: gap),
            Text(
              buttonText,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: fontWeight,
                fontSize: fontSize,
                height: 14 / fontSize, // proportional line height
                letterSpacing: letterSpacing,
                color: textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAdhyayNumberWidget(int adhyayNumber, AdhyayStatus status) {
    // Generate duration (for demo purposes, varying between 12-18 mins)
    final duration = 12 + (adhyayNumber % 7);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Left - Adhyay number and status
        Row(
          children: [
            // Adhyay number container
            _buildAdhyayNumberContainer(adhyayNumber, status),

            const SizedBox(width: 8),

            // Status widget
            _buildStatusWidget(status),
          ],
        ),

        // Right - Duration
        Row(
          children: [
            const Icon(
              Icons.watch_later_outlined,
              size: 14,
              color: Color(0xFF8A7267),
            ),
            const SizedBox(width: 4),
            Text(
              '$duration mins',
              style: const TextStyle(
                fontWeight: FontWeight.w600, // semibold
                fontSize: 10,
                height: 14 / 10, // line height 14
                letterSpacing: 0.5,
                color: Color(0xFF8A7267),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildAdhyayNumberContainer(int adhyayNumber, AdhyayStatus status) {
    Color backgroundColor;
    Color textColor;
    List<BoxShadow>? boxShadow;

    switch (status) {
      case AdhyayStatus.completed:
        backgroundColor = const Color(0xFFFFDDB8).withOpacity(0.50); // 50% opacity
        textColor = const Color(0xFF2A1700);
        break;
      case AdhyayStatus.readingNow:
        backgroundColor = const Color(0xFF9A4100);
        textColor = const Color(0xFFFFFFFF);
        boxShadow = [
          BoxShadow(
            color: const Color(0xFF000000).withOpacity(0.05), // 5% opacity
            offset: const Offset(0, 1),
            blurRadius: 2,
            spreadRadius: 0,
          ),
        ];
        break;
      case AdhyayStatus.upNext:
      case AdhyayStatus.unread:
        backgroundColor = const Color(0xFFECE7E1);
        textColor = const Color(0xFF1D1C18);
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(4),
        boxShadow: boxShadow,
      ),
      child: Text(
        '${AppStrings.adhyay} $adhyayNumber',
        style: TextStyle(
          fontWeight: FontWeight.w700, // bold
          fontSize: 10,
          height: 14 / 10, // line height 14
          letterSpacing: 0.5,
          color: textColor,
        ),
      ),
    );
  }

  Widget _buildAdhyayDetailWidget(int adhyayNumber, AdhyayStatus status) {
    final adhyayData = AdhyayData.getAdhyay(adhyayNumber);
    final isReadingNow = status == AdhyayStatus.readingNow;

    return Container(
      width: double.infinity, // Fill width
      padding: const EdgeInsets.only(top: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left - Chapter name and summary
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Chapter name
                Text(
                  adhyayData.title,
                  style: TextStyle(
                    fontFamily: 'SF Pro Display', // Display ExtraCondensed
                    fontWeight: FontWeight.w600, // semibold
                    fontSize: 20,
                    height: 28 / 20, // line height 28
                    letterSpacing: 0,
                    color: isReadingNow ? const Color(0xFF9A4100) : const Color(0xFF1D1C18),
                  ),
                ),

                const SizedBox(height: 4), // Gap 4 (14 would be too much for this layout)

                // Chapter summary
                Text(
                  adhyayData.summary,
                  style: const TextStyle(
                    fontWeight: FontWeight.w400, // regular
                    fontSize: 12,
                    height: 18 / 12, // line height 18
                    letterSpacing: 0,
                    color: Color(0xFF574238),
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),

          const SizedBox(width: 12),

          // Right - Chapter image
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: const Color(0xFFF2EDE6),
              borderRadius: BorderRadius.circular(8),
            ),
            child: adhyayData.imageUrl != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      adhyayData.imageUrl!,
                      fit: BoxFit.cover,
                    ),
                  )
                : const Icon(
                    Icons.auto_stories,
                    size: 28,
                    color: Color(0xFF8A7267),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusWidget(AdhyayStatus status) {
    switch (status) {
      case AdhyayStatus.completed:
        return Row(
          children: [
            Container(
              width: 14,
              height: 14,
              decoration: const BoxDecoration(
                color: Color(0xFF765700),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.check,
                size: 10,
                color: Color(0xFFFFFFFF),
              ),
            ),
            const SizedBox(width: 6),
            Text(
              AppStrings.completedStatus,
              style: const TextStyle(
                fontWeight: FontWeight.w600, // semibold
                fontSize: 10,
                height: 14 / 10, // line height 14
                letterSpacing: 0.5,
                color: Color(0xFF765700),
              ),
            ),
          ],
        );

      case AdhyayStatus.readingNow:
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          decoration: BoxDecoration(
            color: const Color(0xFFFFDDB8),
            borderRadius: BorderRadius.circular(9999),
          ),
          child: Row(
            children: [
              // Blinking red dot
              Container(
                width: 6,
                height: 6,
                decoration: const BoxDecoration(
                  color: Color(0xFFBA1A1A),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 6),
              Text(
                AppStrings.readingNow,
                style: const TextStyle(
                  fontWeight: FontWeight.w700, // bold
                  fontSize: 10,
                  height: 14 / 10, // line height 14
                  letterSpacing: 0.5,
                  color: Color(0xFF2A1700),
                ),
              ),
            ],
          ),
        );

      case AdhyayStatus.upNext:
        return Row(
          children: [
            Container(
              width: 6,
              height: 6,
              decoration: const BoxDecoration(
                color: Color(0xFFFEA619),
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 6),
            Text(
              AppStrings.upNext,
              style: const TextStyle(
                fontWeight: FontWeight.w500, // medium
                fontSize: 10,
                height: 14 / 10, // line height 14
                letterSpacing: 0.5,
                color: Color(0xFF765700),
              ),
            ),
          ],
        );

      case AdhyayStatus.unread:
        return Text(
          AppStrings.unreadStatus,
          style: const TextStyle(
            fontWeight: FontWeight.w600, // semibold
            fontSize: 10,
            height: 14 / 10, // line height 14
            letterSpacing: 0.5,
            color: Color(0xFF8A7267),
          ),
        );
    }
  }
}
