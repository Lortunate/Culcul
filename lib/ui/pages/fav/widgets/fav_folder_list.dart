import 'package:culcul/data/models/fav/index.dart';
import 'package:culcul/providers/fav/fav_provider.dart';
import 'package:culcul/ui/pages/fav/fav_folder_item.dart';
import 'package:culcul/ui/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

enum FavFolderType { created, collected }

class FavFolderList extends ConsumerWidget {
  final FavFolderType type;

  const FavFolderList({super.key, required this.type});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncValue = type == FavFolderType.created
        ? ref.watch(favCreatedFoldersProvider)
        : ref.watch(favCollectedFoldersProvider);

    return SmartPagingView<FavFolderModel>(
      asyncValue: asyncValue,
      provider: type == FavFolderType.created
          ? favCreatedFoldersProvider
          : favCollectedFoldersProvider,
      skeleton: const SizedBox(), // TODO: Add skeleton
      onRefresh: () async {
        if (type == FavFolderType.created) {
          return ref.refresh(favCreatedFoldersProvider.future);
        } else {
          return ref.refresh(favCollectedFoldersProvider.future);
        }
      },
      onLoadMore: () async {
        if (type == FavFolderType.collected) {
          await ref.read(favCollectedFoldersProvider.notifier).loadMore();
        }
      },
      builder: (context, list) {
        if (list.isEmpty) {
          return const Center(child: Text('No favorites'));
        }
        return ListView.separated(
          padding: const EdgeInsets.symmetric(vertical: 8),
          itemCount: list.length,
          separatorBuilder: (_, __) => const Divider(
            height: 1,
            indent: 106, // 16 padding + 90 cover
            endIndent: 16,
            thickness: 0.5,
          ),
          itemBuilder: (context, index) {
            final folder = list[index];
            return FavFolderItem(
              item: folder,
              onTap: () {
                context.push('/fav/detail/${folder.id}');
              },
            );
          },
        );
      },
    );
  }
}
