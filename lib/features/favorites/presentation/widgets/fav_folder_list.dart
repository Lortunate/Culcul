import 'package:culcul/app/router/app_routes.dart';
import 'package:culcul/features/favorites/application/favorites_controller.dart';
import 'package:culcul/features/favorites/presentation/widgets/fav_folder_item.dart';
import 'package:culcul/features/favorites/domain/entities/favorite_folder.dart';
import 'package:culcul/ui/widgets/feedback/app_shimmer.dart';
import 'package:culcul/ui/widgets/smart_paging_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

enum FavFolderType { created, collected }

class FavFolderList extends HookConsumerWidget {
  final FavFolderType type;
  final int? currentMid;

  const FavFolderList({super.key, required this.type, required this.currentMid});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useAutomaticKeepAlive();
    final mid = currentMid;
    if (mid == null) {
      return const SizedBox.shrink();
    }

    final isCreated = type == FavFolderType.created;
    final provider = isCreated
        ? favCreatedFoldersProvider(mid)
        : favCollectedFoldersProvider(mid);
    final asyncValue = ref.watch(provider);
    final onLoadMore = isCreated
        ? null
        : () => ref.read(favCollectedFoldersProvider(mid).notifier).loadMore();

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
              child: FavFolderItem(
                item: item,
                onTap: () {
                  FavoriteDetailRoute(
                    mediaId: item.id,
                    title: item.title,
                    mid: item.mid,
                  ).push(context);
                },
              ),
            );
          },
        );
      },
      skeleton: const _Skeleton(),
    );
  }
}

class _Skeleton extends StatelessWidget {
  const _Skeleton();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return ListView.separated(
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
    );
  }
}
