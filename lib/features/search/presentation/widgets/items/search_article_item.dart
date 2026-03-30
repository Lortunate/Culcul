import 'package:culcul/core/utils/format_utils.dart';
import 'package:culcul/features/search/domain/entities/search_result_page.dart';
import 'package:culcul/ui/widgets/app_clickable.dart';
import 'package:culcul/ui/widgets/app_network_image.dart';
import 'package:flutter/material.dart';

class SearchArticleItem extends StatelessWidget {
  final SearchArticleEntry item;

  const SearchArticleItem({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final imageCount = item.imageUrls.length;

    return AppClickable(
      onTap: () {},
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              FormatUtils.stripHtmlTags(item.title),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w500,
                fontSize: 15,
                height: 1.3,
              ),
            ),
            const SizedBox(height: 10),
            if (imageCount >= 3)
              Row(
                children: [
                  for (int i = 0; i < 3; i++)
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(right: i < 2 ? 6.0 : 0),
                        child: AspectRatio(
                          aspectRatio: 3 / 2,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(6),
                            child: AppNetworkImage(
                              url: item.imageUrls[i],
                              borderRadius: 6,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              )
            else if (imageCount > 0)
              AspectRatio(
                aspectRatio: 16 / 9,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: AppNetworkImage(url: item.imageUrls[0], borderRadius: 8),
                ),
              ),
            const SizedBox(height: 10),
            Row(
              children: [
                Icon(
                  Icons.person_outline_rounded,
                  size: 13,
                  color: colorScheme.onSurfaceVariant.withValues(alpha: 0.6),
                ),
                const SizedBox(width: 4),
                Text(
                  item.author,
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: colorScheme.onSurfaceVariant.withValues(alpha: 0.6),
                    fontSize: 11,
                  ),
                ),
                const SizedBox(width: 16),
                _ArticleMetaItem(
                  icon: Icons.remove_red_eye_outlined,
                  value: FormatUtils.formatAnyNumber(item.viewCount),
                ),
                const SizedBox(width: 12),
                _ArticleMetaItem(
                  icon: Icons.chat_bubble_outline_rounded,
                  value: FormatUtils.formatAnyNumber(item.reviewCount),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ArticleMetaItem extends StatelessWidget {
  final IconData icon;
  final String value;

  const _ArticleMetaItem({required this.icon, required this.value});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 12, color: colorScheme.onSurfaceVariant.withValues(alpha: 0.4)),
        const SizedBox(width: 4),
        Text(
          value,
          style: theme.textTheme.labelSmall?.copyWith(
            color: colorScheme.onSurfaceVariant.withValues(alpha: 0.4),
            fontSize: 11,
          ),
        ),
      ],
    );
  }
}
