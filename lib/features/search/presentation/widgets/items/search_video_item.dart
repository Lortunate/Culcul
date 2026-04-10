import 'package:culcul/app/router/app_routes.dart';
import 'package:culcul/shared/utils/format_utils.dart';
import 'package:culcul/shared/utils/format_extensions.dart';
import 'package:culcul/shared/contracts/search_result_contract.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/shared/widgets/icon_text.dart';
import 'package:culcul/shared/widgets/video_list_card.dart';
import 'package:flutter/material.dart';

class SearchVideoItem extends StatelessWidget {
  final SearchVideoEntry item;

  const SearchVideoItem({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final t = Translations.of(context);

    return VideoListCard(
      flat: true,
      onTap: () {
        if (item.bvid.isNotEmpty) {
          VideoDetailRoute(bvid: item.bvid).push(context);
        }
      },
      padding: EdgeInsets.zero,
      coverUrl: item.coverUrl,
      title: FormatUtils.stripHtmlTags(item.title),
      duration: item.durationText.parseDuration,
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
              item.typeName.isEmpty ? t.search.tabs.video : item.typeName,
              style: theme.textTheme.labelSmall?.copyWith(
                color: colorScheme.onSurfaceVariant,
                fontSize: 10,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              item.author,
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
          text: FormatUtils.formatAnyNumber(item.playCount ?? item.viewCount),
        ),
        IconText(
          icon: Icons.list_alt_rounded,
          text: FormatUtils.formatAnyNumber(item.danmakuCount ?? item.videoReviewCount),
        ),
      ],
    );
  }
}
