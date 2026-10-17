import 'package:flutter/material.dart';

class CollectionData {
  final IconData icon;
  final Color iconBackgroundColor;
  final String categoryName;
  final Color categoryBackgroundColor;
  final Color categoryTextColor;
  final String title;
  final String subtitle;
  final Color circleColor;

  const CollectionData({
    required this.icon,
    required this.iconBackgroundColor,
    required this.categoryName,
    required this.categoryBackgroundColor,
    required this.categoryTextColor,
    required this.title,
    required this.subtitle,
    required this.circleColor,
  });
}

class ExploreCollections extends StatelessWidget {
  final String sectionTitle;
  final int totalCollections;
  final List<CollectionData> collections;
  final Function(int)? onCollectionTap;

  const ExploreCollections({
    super.key,
    this.sectionTitle = 'Sacred Portals',
    this.totalCollections = 6,
    required this.collections,
    this.onCollectionTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, // Fill width
      child: Column(
        children: [
          // 1. Title widget
          _buildTitleWidget(),

          const SizedBox(height: 8), // Gap 8

          // 2. Collection grid widget
          _buildCollectionGrid(),
        ],
      ),
    );
  }

  Widget _buildTitleWidget() {
    return Container(
      width: double.infinity, // Fill width
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // 1_a. Left - Dot + Title
          Row(
            children: [
              // Dot
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: const Color(0xFFFEA619),
                  borderRadius: BorderRadius.circular(9999),
                ),
              ),

              const SizedBox(width: 8), // Gap 8

              // Text "Sacred Portals"
              const Text(
                'Sacred Portals',
                textAlign: TextAlign.left,
                style: TextStyle(
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

          // 1_b. Right - Collection count
          Text(
            '$totalCollections COLLECTION',
            textAlign: TextAlign.left,
            style: const TextStyle(
              fontWeight: FontWeight.w600, // semibold
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

  Widget _buildCollectionGrid() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final cardWidth = (constraints.maxWidth - 8) / 2; // (available width - gap) / 2 columns

        return Wrap(
          spacing: 8, // Horizontal gap
          runSpacing: 8, // Vertical gap
          children: collections.asMap().entries.map((entry) {
            final index = entry.key;
            final data = entry.value;
            return SizedBox(
              width: cardWidth,
              child: _buildCollectionCard(data, index),
            );
          }).toList(),
        );
      },
    );
  }

  Widget _buildCollectionCard(CollectionData data, int index) {
    return GestureDetector(
      onTap: () {
        if (onCollectionTap != null) {
          onCollectionTap!(index);
        }
      },
      child: Container(
        width: double.infinity, // Fill width
        margin: const EdgeInsets.symmetric(vertical: 8), // Top and bottom spacing 8
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
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Stack(
            children: [
              // Circle in bottom right (70% inside, 30% outside)
              Positioned(
                bottom: -24, // 30% of 80 = 24
                right: -24,
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: data.circleColor,
                    borderRadius: BorderRadius.circular(9999),
                  ),
                ),
              ),

              // Content
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 1. Top widget - Icon and Category
                  _buildTopWidget(data),

                  const SizedBox(height: 8),

                  // 2. Bottom widget - Title and Subtitle
                  _buildBottomWidget(data),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopWidget(CollectionData data) {
    return Row(
      children: [
        // a. Icon widget
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: data.iconBackgroundColor,
            borderRadius: BorderRadius.circular(9999),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF000000).withOpacity(0.05), // 5% opacity
                offset: const Offset(0, 1),
                blurRadius: 2,
                spreadRadius: 0,
              ),
            ],
          ),
          child: Icon(
            data.icon,
            color: const Color(0xFFFFFFFF), // White
            size: 20,
          ),
        ),

        const SizedBox(width: 8),

        // b. Text widget - Category name
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          decoration: BoxDecoration(
            color: data.categoryBackgroundColor,
            borderRadius: BorderRadius.circular(9999),
          ),
          child: Text(
            data.categoryName,
            textAlign: TextAlign.left,
            style: TextStyle(
              fontWeight: FontWeight.w600, // semibold
              fontSize: 10,
              height: 14 / 10, // line height 14
              letterSpacing: 0.5,
              color: data.categoryTextColor,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomWidget(CollectionData data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Upper text - Title
        Text(
          data.title,
          textAlign: TextAlign.left,
          style: const TextStyle(
            fontFamily: 'SF Pro Display', // Display extracondensed
            fontWeight: FontWeight.w600, // semibold
            fontSize: 20,
            height: 25 / 20, // line height 25
            letterSpacing: 0,
            color: Color(0xFF1D1C18),
          ),
        ),

        const SizedBox(height: 4),

        // Lower text - Subtitle
        Text(
          data.subtitle,
          textAlign: TextAlign.left,
          style: const TextStyle(
            fontWeight: FontWeight.w400, // regular
            fontSize: 12,
            color: Color(0xFF574238),
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}

// Sample data for 6 collections
class ExploreCollectionsData {
  static final List<CollectionData> collections = [
    // Collection 1
    CollectionData(
      icon: Icons.auto_awesome,
      iconBackgroundColor: const Color(0xFF9A4100),
      categoryName: 'Aarti',
      categoryBackgroundColor: const Color(0xFFFEA619).withOpacity(0.20),
      categoryTextColor: const Color(0xFF855300),
      title: 'The 4 Daily Aartis',
      subtitle: 'Kakad • Madhiayan • Dhoop • Sej',
      circleColor: const Color(0xFFFFDDB8).withOpacity(0.50),
    ),

    // Collection 2
    CollectionData(
      icon: Icons.menu_book,
      iconBackgroundColor: const Color(0xFF765700),
      categoryName: 'Bhajan',
      categoryBackgroundColor: const Color(0xFFFFDF9F),
      categoryTextColor: const Color(0xFF5C4300),
      title: 'Popular Bhajans',
      subtitle: 'Most loved devotional songs',
      circleColor: const Color(0xFFFFDF9F).withOpacity(0.60),
    ),

    // Collection 3
    CollectionData(
      icon: Icons.wb_sunny,
      iconBackgroundColor: const Color(0xFF855300),
      categoryName: 'Morning',
      categoryBackgroundColor: const Color(0xFFFFDDB8),
      categoryTextColor: const Color(0xFF2A1700),
      title: 'Morning Prayers',
      subtitle: 'Start your day with blessings',
      circleColor: const Color(0xFFFFDBCB).withOpacity(0.60),
    ),

    // Collection 4
    CollectionData(
      icon: Icons.nights_stay,
      iconBackgroundColor: const Color(0xFFBD5611),
      categoryName: 'Evening',
      categoryBackgroundColor: const Color(0xFFFFDDB8),
      categoryTextColor: const Color(0xFF2A1700),
      title: 'Evening Aartis',
      subtitle: 'Peaceful evening rituals',
      circleColor: const Color(0xFFFEA619).withOpacity(0.25),
    ),

    // Collection 5
    CollectionData(
      icon: Icons.favorite,
      iconBackgroundColor: const Color(0xFF956E00),
      categoryName: 'Favorite',
      categoryBackgroundColor: const Color(0xFFECE7E1),
      categoryTextColor: const Color(0xFF574238),
      title: 'Most Loved',
      subtitle: 'Community favorites collection',
      circleColor: const Color(0xFFFFDDB8).withOpacity(0.50),
    ),

    // Collection 6
    CollectionData(
      icon: Icons.star,
      iconBackgroundColor: const Color(0xFF9A4100),
      categoryName: 'Special',
      categoryBackgroundColor: const Color(0xFFFFDDB8),
      categoryTextColor: const Color(0xFF2A1700),
      title: 'Festival Specials',
      subtitle: 'Celebrate with devotion',
      circleColor: const Color(0xFFFFB690).withOpacity(0.40),
    ),
  ];
}
