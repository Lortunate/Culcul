import 'package:culcul/core/utils/format_utils.dart';
import 'package:culcul/features/dynamic/route_entry.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/features/search/application/search_result.dart';
import 'package:culcul/ui/widgets/media/app_network_image.dart';
import 'package:flutter/material.dart';

class SearchTopicItem extends StatelessWidget {
  final SearchTopicEntry item;

  const SearchTopicItem({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final t = Translations.of(context);

    return GestureDetector(
      onTap: () {
        if (item.topicId != 0) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => buildTopicDetailRoutePage(
                topicId: item.topicId,
                topicName: FormatUtils.stripHtmlTags(item.title),
              ),
            ),
          );
        }
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (item.coverUrl != null)
              AppNetworkImage(
                url: item.coverUrl!,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
                borderRadius: BorderRadius.circular(8),
              ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    FormatUtils.stripHtmlTags(item.title),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  if (item.description != null)
                    Text(
                      FormatUtils.stripHtmlTags(item.description!),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  const SizedBox(height: 8),
                  if (item.updateCount != null)
                    Text(
                      t.moments.topic_updates(count: item.updateCount!.toString()),
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: colorScheme.primary,
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
