import 'package:culcul/core/utils/format_utils.dart';
import 'package:culcul/core/contracts/search_result_contract.dart';
import 'package:culcul/ui/widgets/app_network_image.dart';
import 'package:culcul/ui/widgets/video_list_card.dart';
import 'package:flutter/material.dart';

class SearchBangumiItem extends StatelessWidget {
  final SearchBangumiEntry item;

  const SearchBangumiItem({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return VideoListCard(
      onTap: () {},
      height: 110,
      padding: const EdgeInsets.symmetric(vertical: 4),
      coverUrl: '', // Not used
      title: FormatUtils.stripHtmlTags(item.title),
      leading: AspectRatio(
        aspectRatio: 3 / 4,
        child: AppNetworkImage(url: item.coverUrl, borderRadius: BorderRadius.circular(8)),
      ),
      middleContent: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${item.seasonTypeName} · ${item.areas}',
            style: theme.textTheme.labelSmall?.copyWith(
              color: colorScheme.onSurfaceVariant.withValues(alpha: 0.7),
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            FormatUtils.stripHtmlTags(item.styles),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.labelSmall?.copyWith(
              color: colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
              fontSize: 11,
            ),
          ),
        ],
      ),
      author: item.label != null
          ? Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: colorScheme.primaryContainer.withValues(alpha: 0.4),
                borderRadius: BorderRadius.circular(4),
                border: Border.all(
                  color: colorScheme.primary.withValues(alpha: 0.2),
                  width: 0.5,
                ),
              ),
              child: Text(
                item.label!,
                style: theme.textTheme.labelSmall?.copyWith(
                  color: colorScheme.primary,
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                ),
              ),
            )
          : null,
    );
  }
}
