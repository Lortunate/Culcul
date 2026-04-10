import 'package:culcul/features/favorites/domain/entities/favorite_folder.dart';
import 'package:culcul/i18n/i18n.dart';
import 'package:culcul/shared/widgets/app_clickable.dart';
import 'package:culcul/shared/widgets/app_network_image.dart';
import 'package:flutter/material.dart';

class FavFolderItem extends StatelessWidget {
  final FavoriteFolder item;
  final VoidCallback? onTap;

  const FavFolderItem({super.key, required this.item, this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final t = i18n(context);

    return AppClickable(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(color: colorScheme.surface),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Cover
            Container(
              width: 160,
              height: 90,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
                border: Border.all(
                  color: colorScheme.outlineVariant.withValues(alpha: 0.2),
                  width: 0.5,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: item.cover != null && item.cover!.isNotEmpty
                    ? AppNetworkImage(
                        url: item.cover!,
                        fit: BoxFit.cover,
                        width: 160,
                        height: 90,
                      )
                    : Center(
                        child: Icon(
                          Icons.folder_open_rounded,
                          color: colorScheme.primary.withValues(alpha: 0.5),
                          size: 32,
                        ),
                      ),
              ),
            ),
            const SizedBox(width: 12),
            // Content
            Expanded(
              child: SizedBox(
                height: 90, // Match cover height for vertical alignment
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Title
                    Text(
                      item.title,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        height: 1.2,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    // Meta info
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Media count & Privacy
                        Row(
                          children: [
                            Text(
                              t.favorites.folder_item_count(
                                count: item.mediaCount.toString(),
                              ),
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: colorScheme.onSurfaceVariant,
                                fontSize: 11,
                              ),
                            ),
                            if (item.isPrivate) ...[
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 4,
                                  vertical: 1,
                                ),
                                decoration: BoxDecoration(
                                  color: colorScheme.surfaceContainerHigh,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.lock_outline_rounded,
                                      size: 10,
                                      color: colorScheme.onSurfaceVariant,
                                    ),
                                    const SizedBox(width: 2),
                                    Text(
                                      t.favorites.private,
                                      style: theme.textTheme.labelSmall?.copyWith(
                                        color: colorScheme.onSurfaceVariant,
                                        fontSize: 10,
                                        height: 1,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ],
                        ),
                        const SizedBox(height: 4),
                        // Creator info (if available)
                        if (item.upper != null)
                          Row(
                            children: [
                              Text(
                                item.upper!.name,
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: colorScheme.onSurfaceVariant,
                                  fontSize: 12,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          )
                        else
                          // Placeholder to keep layout consistent if needed or remove
                          const SizedBox.shrink(),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
