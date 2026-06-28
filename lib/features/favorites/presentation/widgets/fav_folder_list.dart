import 'package:culcul/features/favorites/state/favorites_view_model.dart';
import 'package:culcul/features/favorites/models/favorite_folder.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/ui/widgets/buttons/app_clickable.dart';
import 'package:culcul/ui/widgets/feedback/app_shimmer.dart';
import 'package:culcul/ui/widgets/media/app_network_image.dart';
import 'package:culcul/ui/widgets/smart_paging_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

enum FavFolderType { created, collected }

class FavFolderList extends HookConsumerWidget {
  final FavFolderType type;
  final ValueChanged<FavoriteFolder> onOpenFolder;

  const FavFolderList({super.key, required this.type, required this.onOpenFolder});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useAutomaticKeepAlive();

    final isCreated = type == FavFolderType.created;
    final provider = isCreated ? favCreatedFoldersProvider : favCollectedFoldersProvider;
    final asyncValue = ref.watch(provider);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final t = context.t;
    final onLoadMore = isCreated
        ? null
        : () => ref.read(favCollectedFoldersProvider.notifier).loadNextCollectedPage();

    return SmartPagingView<FavoriteFolder>(
      asyncValue: asyncValue,
      onRefresh: () async {
        ref.invalidate(provider);
      },
      onLoadMore: onLoadMore,
      itemCount: () => ref.read(provider).value?.length ?? 0,
      builder: (context, list) {
        return ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          itemCount: list.length,
          separatorBuilder: (context, index) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final item = list[index];
            return KeyedSubtree(
              key: ValueKey('fav_folder_${item.id}_$index'),
              child: AppClickable(
                onTap: () => onOpenFolder(item),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(color: colorScheme.surface),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 160,
                        height: 90,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: colorScheme.surfaceContainerHighest.withValues(
                            alpha: 0.5,
                          ),
                          border: Border.all(
                            color: colorScheme.outlineVariant.withValues(alpha: 0.2),
                            width: 0.5,
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: item.cover != null && item.cover!.isNotEmpty
                              ? AppNetworkImage(url: item.cover!, width: 160, height: 90)
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
                      Expanded(
                        child: SizedBox(
                          height: 90,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
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
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
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
                                                style: theme.textTheme.labelSmall
                                                    ?.copyWith(
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
                                  if (item.upper != null) ...[
                                    const SizedBox(height: 4),
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
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
      skeleton: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: 10,
        separatorBuilder: (context, index) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          return AppShimmer(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 88,
                  height: 88,
                  decoration: BoxDecoration(
                    color: colorScheme.surfaceContainerHigh,
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(height: 16, color: colorScheme.surfaceContainerHigh),
                      const SizedBox(height: 8),
                      Container(
                        height: 14,
                        width: 100,
                        color: colorScheme.surfaceContainerHigh,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
