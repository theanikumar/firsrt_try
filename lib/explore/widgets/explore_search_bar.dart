import 'package:flutter/material.dart';

class ExploreSearchBar extends StatelessWidget {
  final String hintText;
  final VoidCallback? onSearchTap;
  final VoidCallback? onMicTap;

  const ExploreSearchBar({
    super.key,
    this.hintText = 'Search Bhajans, Arti, Artists',
    this.onSearchTap,
    this.onMicTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, // Fill width
      padding: const EdgeInsets.only(top: 4),
      child: Container(
        width: double.infinity, // Fill width
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: const Color(0xFFF8F3EC),
          borderRadius: BorderRadius.circular(9999),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF000000).withOpacity(0.05), // 5% opacity
              offset: const Offset(0, 1), // x: 0, y: 1
              blurRadius: 2,
              spreadRadius: 0,
            ),
          ],
        ),
        child: Row(
          children: [
            // 1. Search icon container
            _buildSearchIconContainer(),

            // 2. Hint text container
            Expanded(
              child: _buildHintTextContainer(),
            ),

            // 3. Mic icon container
            _buildMicIconContainer(),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchIconContainer() {
    return GestureDetector(
      onTap: onSearchTap,
      child: Container(
        width: 40,
        height: 40,
        alignment: Alignment.center,
        child: const Icon(
          Icons.search,
          size: 18,
          color: Color(0xFF9A4100),
        ),
      ),
    );
  }

  Widget _buildHintTextContainer() {
    return GestureDetector(
      onTap: onSearchTap,
      child: Container(
        width: double.infinity, // Fill width
        padding: const EdgeInsets.symmetric(vertical: 2),
        child: Text(
          hintText,
          textAlign: TextAlign.left,
          style: const TextStyle(
            fontWeight: FontWeight.w400, // regular
            fontSize: 14,
            color: Color(0xFF8A7267),
          ),
        ),
      ),
    );
  }

  Widget _buildMicIconContainer() {
    return Container(
      padding: const EdgeInsets.only(left: 4),
      child: GestureDetector(
        onTap: onMicTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: const Color(0xFFFFDDB8),
            borderRadius: BorderRadius.circular(9999),
          ),
          child: const Icon(
            Icons.mic,
            size: 18,
            color: Color(0xFF9A4100),
          ),
        ),
      ),
    );
  }
}
