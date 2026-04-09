import 'package:culcul/features/home/domain/entities/home_video.dart';
import 'package:culcul/features/home/presentation/widgets/video_more_bottom_sheet.dart';

import 'package:culcul/ui/widgets/app_tag.dart';
import 'package:culcul/ui/widgets/video_list_card.dart';
import 'package:flutter/material.dart';

class PopularVideoCard extends StatelessWidget {
  final HomeVideo video;
  final VoidCallback? onTap;
  final double cardHeight;
  final double thumbnailWidth;

  const PopularVideoCard({
    super.key,
    required this.video,
    this.onTap,
    this.cardHeight = 100,
    this.thumbnailWidth = 160,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return VideoListCard(
      onTap: onTap,
      padding: const EdgeInsets.all(10),
      onLongPress: () {
        showModalBottomSheet(
          context: context,
          backgroundColor: Colors.transparent,
          barrierColor: Colors.transparent,
          isScrollControlled: true,
          builder: (context) => VideoMoreBottomSheet.homeVideo(video: video),
        );
      },
      height: cardHeight,
      thumbnailWidth: thumbnailWidth,
      coverUrl: video.pic,
      title: video.title,
      duration: video.duration,
      viewCount: video.stats.view,
      danmakuCount: video.stats.danmaku,
      badge: video.rcmdReason.isNotEmpty ? _PopularTag(text: video.rcmdReason) : null,
      author: Row(
        children: [
          Icon(
            Icons.account_circle_outlined,
            size: 14,
            color: colorScheme.onSurfaceVariant,
          ),
          const SizedBox(width: 4),
          Expanded(
            child: Text(
              video.owner.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.labelSmall?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ),
        ],
      ),
      showDefaultStats: true,
    );
  }
}

class _PopularTag extends StatelessWidget {
  final String text;

  const _PopularTag({required this.text});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isMillion = text.contains('M');

    return AppTag(
      text: text,
      color: isMillion
          ? colorScheme.primary.withValues(alpha: 0.1)
          : colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
      textColor: isMillion ? colorScheme.primary : colorScheme.onSurfaceVariant,
      fontSize: 10,
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
      borderRadius: 6,
    );
  }
}
