import 'package:culcul/providers/dynamic/user_dynamic_provider.dart';
import 'package:culcul/ui/pages/dynamic/widgets/dynamic_post_card.dart';
import 'package:culcul/ui/widgets/app_shimmer.dart';
import 'package:culcul/ui/widgets/skeletons/dynamic_skeleton.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class UserDynamicTab extends ConsumerWidget {
  final int mid;
  const UserDynamicTab({super.key, required this.mid});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final feedAsync = ref.watch(userDynamicProvider(mid));
    final notifier = ref.read(userDynamicProvider(mid).notifier);

    return feedAsync.when(
      data: (items) {
        if (items.isEmpty) {
          return const Center(child: Text('暂无动态'));
        }
        return CustomScrollView(
          key: PageStorageKey<String>('user_dynamic_tab_$mid'),
          slivers: [
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  if (index == items.length) {
                    notifier.loadMore();
                    return const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }
                  final item = items[index];
                  return DynamicPostCard(
                    post: item,
                    onLike: (post) => notifier.toggleLike(post.id, post.isLiked),
                  );
                },
                childCount: items.length + 1,
              ),
            ),
          ],
        );
      },
      error: (err, stack) => Center(child: Text('Error: $err')),
      loading: () => CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => const AppShimmer(
                child: DynamicSkeleton(),
              ),
              childCount: 5,
            ),
          ),
        ],
      ),
    );
  }
}
