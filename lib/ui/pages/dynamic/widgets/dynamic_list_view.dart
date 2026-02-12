import 'package:culcul/providers/dynamic/dynamic_provider.dart';
import 'package:culcul/data/models/dynamic/dynamic_extension.dart';
import 'package:culcul/ui/pages/dynamic/widgets/dynamic_post_card.dart';
import 'package:culcul/ui/pages/dynamic/widgets/recently_followed_widget.dart';
import 'package:culcul/ui/widgets/app_error_widget.dart';
import 'package:culcul/ui/widgets/refresh_header_footer.dart';
import 'package:culcul/ui/widgets/skeletons/video_list_skeleton.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DynamicListView extends HookConsumerWidget {
  final String type;

  const DynamicListView({super.key, required this.type});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = dynamicProvider(type);
    final state = ref.watch(provider);
    final notifier = ref.read(provider.notifier);

    if (state.isLoading && !state.hasValue) {
      return const VideoListSkeleton();
    }

    if (state.hasError && !state.hasValue) {
      return Center(
        child: AppErrorWidget(error: state.error!, onRetry: notifier.refresh),
      );
    }

    final items = state.value ?? [];

    return EasyRefresh(
      header: AppRefreshHeader(),
      footer: AppLoadFooter(),
      onRefresh: () async {
        await notifier.refresh();
        if (ref.read(provider).hasError) {
          throw Exception('Refresh failed');
        }
      },
      onLoad: () async {
        await notifier.loadMore();
        if (ref.read(provider).hasError) {
          throw Exception('Load more failed');
        }
      },
      child: items.isEmpty
          ? CustomScrollView(
              slivers: [
                SliverFillRemaining(
                  child: Center(
                    child: AppErrorWidget(
                      message: '暂无内容',
                      onRetry: notifier.refresh,
                    ),
                  ),
                ),
              ],
            )
          : ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: items.length + (type == 'all' ? 1 : 0),
              itemBuilder: (context, index) {
                if (type == 'all') {
                  if (index == 0) {
                    return const RecentlyFollowedWidget();
                  }
                  final post = items[index - 1];
                  return DynamicPostCard(
                    post: post,
                    onLike: (post) =>
                        notifier.toggleLike(post.id, post.isLiked),
                  );
                }
                return DynamicPostCard(
                  post: items[index],
                  onLike: (post) => notifier.toggleLike(post.id, post.isLiked),
                );
              },
            ),
    );
  }
}
