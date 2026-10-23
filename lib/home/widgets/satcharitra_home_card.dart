import 'package:flutter/material.dart';

/// Honest home summary for the Satcharitra index. It reports how many
/// chapters exist and how many have approved audio, instead of inventing a
/// personal saptah streak.
class SatcharitraHomeCard extends StatelessWidget {
  const SatcharitraHomeCard({
    super.key,
    required this.totalChapters,
    required this.recordedChapters,
    required this.onPressed,
    this.isLoading = false,
  });

  final int totalChapters;
  final int recordedChapters;
  final VoidCallback onPressed;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final progress = totalChapters <= 0
        ? 0.0
        : (recordedChapters / totalChapters).clamp(0.0, 1.0);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            offset: const Offset(0, 1),
            blurRadius: 2,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: const Color(0xFFFFDBCB),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.menu_book,
                  color: Color(0xFF9A4100),
                  size: 20,
                ),
              ),
              const SizedBox(width: 8),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Shri Sai Satcharitra',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: Color(0xFF1D1C18),
                      ),
                    ),
                    Text(
                      'The complete 51-adhyay index',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 10,
                        letterSpacing: 0.5,
                        color: Color(0xFF765700),
                      ),
                    ),
                  ],
                ),
              ),
              if (isLoading)
                const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(9999),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 6,
              backgroundColor: const Color(0xFFECE7E1),
              valueColor: const AlwaysStoppedAnimation<Color>(
                Color(0xFF9A4100),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '$recordedChapters of $totalChapters chapters with audio',
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 11,
                  color: Color(0xFF574238),
                ),
              ),
              TextButton(
                onPressed: onPressed,
                child: const Text('Open Parayan'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
