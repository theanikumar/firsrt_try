import 'package:flutter/material.dart';
import '../../../utils/app_strings.dart';

class SearchAndCategories extends StatelessWidget {
  final String selectedCategory;
  final Function(String) onCategorySelected;
  final Function(String)? onSearchChanged;
  final VoidCallback? onMicTap;
  final TextEditingController? searchController;

  const SearchAndCategories({
    super.key,
    this.selectedCategory = 'All',
    required this.onCategorySelected,
    this.onSearchChanged,
    this.onMicTap,
    this.searchController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, // Fill width
      padding: const EdgeInsets.only(
        left: 16,
        right: 16,
        top: 4,
        bottom: 8,
      ),
      child: Column(
        children: [
          // 1. Search container
          _buildSearchContainer(),

          const SizedBox(height: 8), // Gap 8

          // 2. Categories
          _buildCategories(),
        ],
      ),
    );
  }

  Widget _buildSearchContainer() {
    return Container(
      width: double.infinity, // Fill width
      height: 48,
      decoration: BoxDecoration(
        color: const Color(0xFFF8F3EC),
        borderRadius: BorderRadius.circular(9999),
      ),
      child: TextField(
        controller: searchController,
        onChanged: onSearchChanged,
        style: const TextStyle(
          fontWeight: FontWeight.w400, // regular
          fontSize: 14,
          color: Color(0xFF1D1C18),
        ),
        decoration: InputDecoration(
          hintText: AppStrings.searchHint,
          hintStyle: const TextStyle(
            fontWeight: FontWeight.w400, // regular
            fontSize: 14,
            color: Color(0xFF8A7267),
          ),
          prefixIcon: const Icon(
            Icons.search,
            size: 20,
            color: Color(0xFF8A7267),
          ),
          suffixIcon: GestureDetector(
            onTap: onMicTap,
            child: const Icon(
              Icons.mic,
              size: 20,
              color: Color(0xFF8A7267),
            ),
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
        ),
      ),
    );
  }

  Widget _buildCategories() {
    final categories = [
      {'name': AppStrings.all, 'count': 51},
      {'name': AppStrings.completed, 'count': 14},
      {'name': AppStrings.inProgress, 'count': 1},
      {'name': AppStrings.unread, 'count': 36},
      {'name': AppStrings.famousLeelas, 'count': null},
      {'name': AppStrings.teachings, 'count': null},
      {'name': AppStrings.mahasamadhi, 'count': null},
    ];

    return SizedBox(
      width: double.infinity, // Fill width
      height: 32, // Fixed height for horizontal scrolling
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (context, index) => const SizedBox(width: 6),
        itemBuilder: (context, index) {
          final category = categories[index];
          final isActive = selectedCategory == category['name'];

          return _buildCategoryChip(
            name: category['name'] as String,
            count: category['count'] as int?,
            isActive: isActive,
          );
        },
      ),
    );
  }

  Widget _buildCategoryChip({
    required String name,
    required int? count,
    required bool isActive,
  }) {
    // Check if this should be active (either matches selected or is "All" by default)
    final shouldBeActive = isActive || (selectedCategory == 'All' && name == AppStrings.all);

    return GestureDetector(
      onTap: () => onCategorySelected(name),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: shouldBeActive ? const Color(0xFF9A4100) : const Color(0xFFF8F3EC),
          borderRadius: BorderRadius.circular(9999),
          boxShadow: shouldBeActive
              ? [
                  BoxShadow(
                    color: const Color(0xFF000000).withOpacity(0.05), // 5% opacity
                    offset: const Offset(0, 1),
                    blurRadius: 2,
                    spreadRadius: 0,
                  ),
                ]
              : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Category name
            Text(
              name,
              style: TextStyle(
                fontWeight: FontWeight.w600, // semibold
                fontSize: 12,
                color: shouldBeActive ? const Color(0xFFFFFFFF) : const Color(0xFF574238),
              ),
            ),

            // Count badge (if count is not null)
            if (count != null) ...[
              const SizedBox(width: 4),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: shouldBeActive ? const Color(0xFFBD5611) : const Color(0xFFECE7E1),
                  borderRadius: BorderRadius.circular(9999),
                ),
                child: Text(
                  count.toString(),
                  style: TextStyle(
                    fontWeight: FontWeight.w600, // semibold
                    fontSize: 10,
                    color: shouldBeActive ? const Color(0xFFFFFFFF) : const Color(0xFF574238),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
