import 'package:flutter/material.dart';

class LanguageOptionBox extends StatelessWidget {
  final String languageNameLocal;
  final String languageNameEnglish;
  final String audioBadgeText;
  final bool isSelected;
  final VoidCallback onTap;

  const LanguageOptionBox({
    super.key,
    required this.languageNameLocal,
    required this.languageNameEnglish,
    required this.audioBadgeText,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFFFFCF7) : const Color(0xFFF8F3EC),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              offset: const Offset(0, 1),
              blurRadius: 2,
              spreadRadius: 0,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Widget 1: Language name in local format with circle indicator
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    languageNameLocal,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      height: 1.5,
                      letterSpacing: 0,
                      color: isSelected
                          ? const Color(0xFF9A4100)
                          : const Color(0xFF1D1C18),
                      decoration: TextDecoration.none,
                    ),
                  ),
                ),
                // Circle with tick mark
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: isSelected
                        ? const Color(0xFF9A4100)
                        : const Color(0xFFE6E2DB),
                    shape: BoxShape.circle,
                  ),
                  child: isSelected
                      ? const Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 14,
                        )
                      : null,
                ),
              ],
            ),
            // Widget 2: English name and badge
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Language name in English
                  Text(
                    languageNameEnglish,
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      height: 1.5, // Line height 18 / font size 12 = 1.5
                      letterSpacing: 0,
                      color: Color(0xFF574238),
                      decoration: TextDecoration.none,
                    ),
                  ),
                  // Audio badge
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? const Color(0xFFFFDDB8)
                          : const Color(0xFFE6E2DB),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      audioBadgeText,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 10,
                        height: 1.4, // Line height 14 / font size 10 = 1.4
                        letterSpacing: 0.5,
                        color: isSelected
                            ? const Color(0xFF2A1700)
                            : const Color(0xFF574238),
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
