import 'package:flutter/material.dart';

import '../../../core/models/content.dart';
import '../../../utils/app_strings.dart';

/// The Satcharitra index. Every chapter is shown; only chapters with a real
/// approved recording expose a Listen action.
class AdhyayListWidget extends StatelessWidget {
  final List<Chapter> chapters;
  final String language;
  final ValueChanged<Chapter> onListen;
  final String? emptyMessage;

  const AdhyayListWidget({
    super.key,
    required this.chapters,
    required this.language,
    required this.onListen,
    this.emptyMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildSectionTitle(),
        if (chapters.isEmpty)
          _buildEmptyState()
        else
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(
              left: 16,
              right: 16,
              top: 4,
              bottom: 20,
            ),
            child: ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: chapters.length,
              separatorBuilder: (_, __) => const SizedBox(height: 8),
              itemBuilder: (context, index) {
                return _buildChapterCard(chapters[index]);
              },
            ),
          ),
      ],
    );
  }

  Widget _buildSectionTitle() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppStrings.satcharitaIndex,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                  height: 20 / 14,
                  letterSpacing: 0.28,
                  color: Color(0xFF1D1C18),
                ),
              ),
              Text(
                chapters.isEmpty
                    ? AppStrings.adhyaysCount
                    : '${chapters.length} ${AppStrings.adhyaysCount}',
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 10,
                  color: Color(0xFF8A7267),
                ),
              ),
            ],
          ),
          Row(
            children: [
              const Icon(
                Icons.menu_book_outlined,
                size: 16,
                color: Color(0xFF765700),
              ),
              const SizedBox(width: 4),
              Text(
                AppStrings.order,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 10,
                  height: 14 / 10,
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

  Widget _buildEmptyState() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 20),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 28),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        emptyMessage ?? 'The Satcharitra index is not available yet.',
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 13,
          height: 1.5,
          color: Color(0xFF8A7267),
        ),
      ),
    );
  }

  Widget _buildChapterCard(Chapter chapter) {
    final title = chapter.titleFor(language);
    final summary = chapter.summaryFor(language);
    final minutes = chapter.hasAudio && chapter.audio != null
        ? (chapter.audio!.durationSeconds / 60).ceil()
        : chapter.durationMinutes;
    final durationLabel =
        chapter.hasAudio ? '$minutes min audio' : '$minutes min read';

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF000000).withValues(alpha: 0.05),
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
              _buildNumberBadge(chapter.number, chapter.hasAudio),
              const SizedBox(width: 8),
              _buildStatusChip(chapter.hasAudio),
              const Spacer(),
              const Icon(
                Icons.watch_later_outlined,
                size: 14,
                color: Color(0xFF8A7267),
              ),
              const SizedBox(width: 4),
              Text(
                durationLabel,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 10,
                  height: 14 / 10,
                  letterSpacing: 0.5,
                  color: Color(0xFF8A7267),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            title.isEmpty ? 'Adhyay ${chapter.number}' : title,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 18,
              height: 1.3,
              color: Color(0xFF1D1C18),
            ),
          ),
          if (summary.isNotEmpty) ...[
            const SizedBox(height: 4),
            Text(
              summary,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 12,
                height: 18 / 12,
                color: Color(0xFF574238),
              ),
            ),
          ],
          const SizedBox(height: 10),
          Align(
            alignment: Alignment.centerLeft,
            child: chapter.hasAudio
                ? _buildListenButton(chapter)
                : _buildNotRecordedLabel(),
          ),
        ],
      ),
    );
  }

  Widget _buildNumberBadge(int number, bool hasAudio) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: hasAudio
            ? const Color(0xFFFFDDB8).withValues(alpha: 0.5)
            : const Color(0xFFECE7E1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        '${AppStrings.adhyay} $number',
        style: const TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 10,
          height: 14 / 10,
          letterSpacing: 0.5,
          color: Color(0xFF2A1700),
        ),
      ),
    );
  }

  Widget _buildStatusChip(bool hasAudio) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: hasAudio ? const Color(0xFFE7F3E8) : const Color(0xFFF2EDE6),
        borderRadius: BorderRadius.circular(9999),
      ),
      child: Text(
        hasAudio ? AppStrings.recorded : AppStrings.notRecorded,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 10,
          height: 14 / 10,
          letterSpacing: 0.3,
          color: hasAudio ? const Color(0xFF2E6B34) : const Color(0xFF8A7267),
        ),
      ),
    );
  }

  Widget _buildListenButton(Chapter chapter) {
    return GestureDetector(
      onTap: () => onListen(chapter),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: const Color(0xFF9A4100),
          borderRadius: BorderRadius.circular(9999),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF000000).withValues(alpha: 0.05),
              offset: const Offset(0, 1),
              blurRadius: 2,
              spreadRadius: 0,
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.play_arrow_rounded,
              size: 16,
              color: Color(0xFFFFFFFF),
            ),
            const SizedBox(width: 6),
            Text(
              AppStrings.listen,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 12,
                height: 14 / 12,
                letterSpacing: 0.36,
                color: Color(0xFFFFFFFF),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotRecordedLabel() {
    return const Text(
      'This adhyay will be added when its recording is ready.',
      style: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 10,
        height: 14 / 10,
        color: Color(0xFF8A7267),
      ),
    );
  }
}
