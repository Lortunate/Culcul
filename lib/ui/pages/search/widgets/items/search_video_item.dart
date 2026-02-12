import 'package:culcul/core/router/router.dart';
import 'package:culcul/core/utils/format_utils.dart';
import 'package:culcul/data/models/search/search_result.dart';
import 'package:culcul/shared/extensions/format_extensions.dart';
import 'package:culcul/ui/widgets/index.dart';
import 'package:flutter/material.dart';

class SearchVideoItem extends StatelessWidget {
  final SearchVideoModel item;

  const SearchVideoItem({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return SizedBox(
      height: 100,
      child: VideoListCard(
        onTap: () {
          if (item.bvid != null) {
            VideoDetailRoute(bvid: item.bvid!).push(context);
          }
        },
        padding: EdgeInsets.zero,
        coverUrl: item.pic ?? '',
        title: FormatUtils.stripHtmlTags(item.title ?? ''),
        duration: item.duration.parseDuration,
        thumbnailWidth: 177,
        aspectRatio: 16 / 9,
        author: Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
              decoration: BoxDecoration(
                color: colorScheme.primaryContainer.withValues(alpha: 0.4),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                item.typename ?? '视频',
                style: theme.textTheme.labelSmall?.copyWith(
                  color: colorScheme.primary,
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
                  color: colorScheme.onSurfaceVariant.withValues(alpha: 0.8),
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
      ),
    );
  }
}
