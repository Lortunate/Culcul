import 'package:culcul/features/dynamic/controllers/user_dynamic_controller.dart';
import 'package:culcul/ui/pages/dynamic/widgets/dynamic_post_card.dart';
import 'package:culcul/ui/widgets/app_error_widget.dart';
import 'package:culcul/ui/widgets/skeletons/dynamic_skeleton.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class UserDynamicTab extends ConsumerStatefulWidget {
  final int mid;
  const UserDynamicTab({super.key, required this.mid});

  @override
  ConsumerState<UserDynamicTab> createState() => _UserDynamicTabState();
}

class _UserDynamicTabState extends ConsumerState<UserDynamicTab>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final feedAsync = ref.watch(userDynamicProvider(widget.mid));
    final notifier = ref.read(userDynamicProvider(widget.mid).notifier);

    return CustomScrollView(
      key: PageStorageKey<String>('user_dynamic_tab_${widget.mid}'),
      slivers: [
        SliverOverlapInjector(
          handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
        ),
        feedAsync.when(
          data: (items) {
            if (items.isEmpty) {
              return const SliverFillRemaining(
                child: Center(child: Text('暂无动态')),
              );
            }
            return SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
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
                  onLike: (post) => notifier.toggleLike(
                    post.idStr,
                    post.modules.moduleStat?.like.status ?? false,
                  ),
                );
              }, childCount: items.length + 1),
            );
          },
          error: (err, stack) => SliverFillRemaining(
            child: AppErrorWidget(
              error: err,
              onRetry: () => ref.refresh(userDynamicProvider(widget.mid)),
            ),
          ),
          loading: () => SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => const DynamicSkeleton(),
              childCount: 5,
            ),
          ),
        ),
      ],
    );
  }
}
