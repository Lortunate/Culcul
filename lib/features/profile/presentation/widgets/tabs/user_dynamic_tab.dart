import 'package:culcul/features/dynamic/presentation/view_models/user_dynamic_view_model.dart';
import 'package:culcul/features/dynamic/presentation/widgets/dynamic_post_card.dart';
import 'package:culcul/i18n/strings.g.dart';
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
    final t = Translations.of(context);
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
              return SliverFillRemaining(child: Center(child: Text(t.common.no_content)));
            }
            final contentCount = items.length * 2 - 1;
            final totalCount = contentCount + 1;
            return SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  if (index == contentCount) {
                    notifier.loadMore();
                    return const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }
                  if (index.isOdd) {
                    return const SizedBox(height: 16);
                  }
                  final item = items[index ~/ 2];
                  return DynamicPostCard(
                    post: item,
                    onLike: (post) => notifier.toggleLike(
                      post.idStr,
                      post.modules.moduleStat?.like.status ?? false,
                    ),
                  );
                }, childCount: totalCount),
              ),
            );
          },
          error: (err, stack) => SliverFillRemaining(
            child: AppErrorWidget(
              error: err,
              stackTrace: stack,
              onRetry: () => ref.refresh(userDynamicProvider(widget.mid)),
            ),
          ),
          loading: () {
            const skeletonCount = 5;
            const childCount = skeletonCount * 2 - 1;
            return SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  if (index.isOdd) {
                    return const SizedBox(height: 16);
                  }
                  return const DynamicSkeleton();
                }, childCount: childCount),
              ),
            );
          },
        ),
      ],
    );
  }
}
