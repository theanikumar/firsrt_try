import 'package:flutter/material.dart';

class SingerData {
  final String name;
  final String category;
  final String? imageUrl;

  const SingerData({
    required this.name,
    required this.category,
    this.imageUrl,
  });
}

class ExploreVocalMasters extends StatelessWidget {
  final String title;
  final List<SingerData> singers;
  final VoidCallback? onViewAllTap;
  final Function(int)? onSingerTap;

  const ExploreVocalMasters({
    super.key,
    this.title = 'Vocal Masters',
    required this.singers,
    this.onViewAllTap,
    this.onSingerTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, // Fill width
      child: Column(
        children: [
          // 1. Upper widget - Title and View All
          _buildUpperWidget(),

          const SizedBox(height: 8), // Gap 8

          // 2. Lower widget - Horizontal singers list
          _buildLowerWidget(),
        ],
      ),
    );
  }

  Widget _buildUpperWidget() {
    return Container(
      width: double.infinity, // Fill width
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // a. Left - Dot + Title
          Row(
            children: [
              // Dot
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: const Color(0xFF9A4100),
                  borderRadius: BorderRadius.circular(9999),
                ),
              ),

              const SizedBox(width: 8), // Gap 8

              // Text "Vocal Masters"
              Text(
                title,
                textAlign: TextAlign.left,
                style: const TextStyle(
                  fontFamily: 'SF Pro Display', // Display extracondensed
                  fontWeight: FontWeight.w600, // semibold
                  fontSize: 20,
                  height: 28 / 20, // line height 28
                  letterSpacing: 0,
                  color: Color(0xFF1D1C18),
                ),
              ),
            ],
          ),

          // b. Right - View All
          GestureDetector(
            onTap: onViewAllTap,
            child: const Text(
              'View All',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w500, // medium
                fontSize: 12,
                height: 16 / 12, // line height 16
                letterSpacing: 0.36,
                color: Color(0xFF9A4100),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLowerWidget() {
    return SizedBox(
      width: double.infinity, // Fill width
      height: 126, // Fixed height for singer profile
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: singers.length,
        separatorBuilder: (context, index) => const SizedBox(width: 12), // Spacing 12
        itemBuilder: (context, index) {
          return _buildSingerProfile(singers[index], index);
        },
      ),
    );
  }

  Widget _buildSingerProfile(SingerData singer, int index) {
    return GestureDetector(
      onTap: () {
        if (onSingerTap != null) {
          onSingerTap!(index);
        }
      },
      child: SizedBox(
        width: 96, // Fixed width
        height: 126, // Fixed height
        child: Column(
          children: [
            // Singer picture
            Container(
              width: 80,
              height: 80,
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: const Color(0xFFF2EDE6),
                borderRadius: BorderRadius.circular(9999),
              ),
              child: ClipOval(
                child: singer.imageUrl != null
                    ? Image.network(
                        singer.imageUrl!,
                        width: 72,
                        height: 72,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return _defaultSingerIcon();
                        },
                      )
                    : _defaultSingerIcon(),
              ),
            ),

            // Singer name container
            Container(
              width: 96, // Fixed width
              padding: const EdgeInsets.only(top: 8),
              child: Column(
                children: [
                  // Singer name
                  SizedBox(
                    width: 96,
                    child: Text(
                      singer.name,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600, // semibold
                        fontSize: 16,
                        height: 24 / 16, // line height 24
                        color: Color(0xFF1D1C18),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),

                  // Singer category
                  Text(
                    singer.category,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600, // semibold
                      fontSize: 10,
                      height: 14 / 10, // line height 14
                      letterSpacing: 0.5,
                      color: Color(0xFF765700),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _defaultSingerIcon() {
    return Container(
      width: 72,
      height: 72,
      decoration: BoxDecoration(
        color: const Color(0xFFFEA619).withOpacity(0.2),
        shape: BoxShape.circle,
      ),
      child: const Icon(
        Icons.person,
        color: Color(0xFF9A4100),
        size: 36,
      ),
    );
  }
}

// Sample data for singers
class ExploreVocalMastersData {
  static final List<SingerData> singers = [
    const SingerData(
      name: 'Souvviek Kabi',
      category: 'Bhajan Singer',
    ),
    const SingerData(
      name: 'Lata Mangeshkar',
      category: 'Classical',
    ),
    const SingerData(
      name: 'Suresh Wadkar',
      category: 'Devotional',
    ),
    const SingerData(
      name: 'Anuradha Paudwal',
      category: 'Aarti',
    ),
    const SingerData(
      name: 'Ravindra Sathe',
      category: 'Bhajan',
    ),
  ];
}
