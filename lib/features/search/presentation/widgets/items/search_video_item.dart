import 'package:culcul/app/router/app_routes.dart';
import 'package:culcul/core/utils/format_utils.dart';
import 'package:culcul/data/models/search/search_result.dart';
import 'package:culcul/core/utils/format_extensions.dart';
import 'package:culcul/ui/widgets/icon_text.dart';
import 'package:culcul/ui/widgets/video_list_card.dart';
import 'package:flutter/material.dart';

class SearchVideoItem extends StatelessWidget {
  final SearchVideoModel item;

  const SearchVideoItem({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return VideoListCard(
      flat: true,
      onTap: () {
        if (item.bvid != null) {
          VideoDetailRoute(bvid: item.bvid!).push(context);
        }
      },
      padding: EdgeInsets.zero,
      coverUrl: item.pic ?? '',
      title: FormatUtils.stripHtmlTags(item.title ?? ''),
      duration: item.duration.parseDuration,
      thumbnailWidth: 160,
      aspectRatio: 16 / 9,
      height: 90,
      author: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              item.typename ?? '视频',
              style: theme.textTheme.labelSmall?.copyWith(
                color: colorScheme.onSurfaceVariant,
                fontSize: 10,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              item.author ?? '',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.labelSmall?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ),
        ],
      ),
      stats: [
        IconText(
          icon: Icons.play_circle_outline_rounded,
          text: FormatUtils.formatAnyNumber(item.play ?? item.view),
        ),
        IconText(
          icon: Icons.list_alt_rounded,
          text: FormatUtils.formatAnyNumber(item.danmaku ?? item.videoReview),
        ),
      ],
    );
  }
}
