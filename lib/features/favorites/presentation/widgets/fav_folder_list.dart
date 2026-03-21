import 'package:culcul/app/router/app_routes.dart';
import 'package:culcul/data/models/fav/index.dart';
import 'package:culcul/features/favorites/controllers/favorites_controller.dart';
import 'package:culcul/features/favorites/presentation/fav_folder_item.dart';
import 'package:culcul/ui/widgets/app_shimmer.dart';
import 'package:culcul/ui/widgets/smart_paging_view.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

enum FavFolderType { created, collected }

class FavFolderList extends HookConsumerWidget {
  final FavFolderType type;

  const FavFolderList({super.key, required this.type});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<FavFolderModel>> asyncValue;
    final dynamic provider;
    Future<void> Function()? onLoadMore;

    if (type == FavFolderType.created) {
      provider = favCreatedFoldersProvider;
      asyncValue = ref.watch(favCreatedFoldersProvider);
      onLoadMore = null;
    } else {
      provider = favCollectedFoldersProvider;
      asyncValue = ref.watch(favCollectedFoldersProvider);
      onLoadMore = () => ref.read(favCollectedFoldersProvider.notifier).loadMore();
    }

    return SmartPagingView<FavFolderModel>(
      provider: provider,
      asyncValue: asyncValue,
      onRefresh: () async {
        return ref.refresh(
          type == FavFolderType.created
              ? favCreatedFoldersProvider.future
              : favCollectedFoldersProvider.future,
        );
      },
      onLoadMore: onLoadMore,
      builder: (context, list) {
        return ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          itemCount: list.length,
          separatorBuilder: (context, index) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final item = list[index];
            return FavFolderItem(
              item: item,
              onTap: () {
                FavoriteDetailRoute(
                  mediaId: item.id,
                  title: item.title,
                  mid: item.mid,
                ).push(context);
              },
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
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(height: 16, color: Colors.white),
                    const SizedBox(height: 8),
                    Container(height: 14, width: 100, color: Colors.white),
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
