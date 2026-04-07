import 'package:culcul/features/dynamic/domain/entities/dynamic_entities.dart';
import 'package:culcul/features/dynamic/presentation/view_models/dynamic_view_model.dart';
import 'package:culcul/features/dynamic/presentation/widgets/dynamic_post_card.dart';
import 'package:culcul/features/dynamic/presentation/widgets/recently_followed_widget.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/ui/widgets/skeletons/video_list_skeleton.dart';
import 'package:culcul/ui/widgets/smart_paging_view.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DynamicListView extends HookConsumerWidget {
  final String type;

  const DynamicListView({super.key, required this.type});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = Translations.of(context);
    final provider = dynamicProvider(type);
    final state = ref.watch(provider);
    final notifier = ref.read(provider.notifier);

    return SmartPagingView<DynamicItem>(
      asyncValue: state,
      onRefresh: notifier.refresh,
      onLoadMore: notifier.loadMore,
      itemCount: () => ref.read(provider).value?.length ?? 0,
      skeleton: const VideoListSkeleton(),
      emptyText: t.common.no_content,
      builder: (context, items) {
        return ListView.separated(
          padding: const EdgeInsets.all(8),
          itemCount: items.length + (type == 'all' ? 1 : 0),
          itemBuilder: (context, index) {
            if (type == 'all') {
              if (index == 0) return const RecentlyFollowedWidget();
              final post = items[index - 1];
              return DynamicPostCard(
                post: post,
                onLike: (post) => notifier.toggleLike(post.id, post.isLiked),
              );
            }
            final post = items[index];
            return DynamicPostCard(
              post: post,
              onLike: (post) => notifier.toggleLike(post.id, post.isLiked),
            );
          },
          separatorBuilder: (context, index) => const SizedBox(height: 8),
        );
      },
    );
  }
}
