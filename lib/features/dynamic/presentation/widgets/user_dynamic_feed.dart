import 'package:culcul/core/data/pagination/pagination_load_gate.dart';
import 'package:culcul/core/data/pagination/nested_feed_paging_defaults.dart';
import 'package:culcul/core/data/pagination/scroll_load_trigger.dart';
import 'package:culcul/features/dynamic/application/models/dynamic_item_extensions.dart';
import 'package:culcul/features/dynamic/application/user_dynamic_provider.dart';
import 'package:culcul/features/dynamic/presentation/widgets/detail/dynamic_post_header.dart';
import 'package:culcul/features/dynamic/presentation/widgets/dynamic_content_widget.dart';
import 'package:culcul/features/dynamic/presentation/widgets/dynamic_post_card.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/ui/widgets/feedback/app_error_widget.dart';
import 'package:culcul/ui/widgets/feedback/app_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class UserDynamicFeed extends ConsumerStatefulWidget {
  final int mid;

  const UserDynamicFeed({super.key, required this.mid});

  @override
  ConsumerState<UserDynamicFeed> createState() => _UserDynamicFeedState();
}

class _UserDynamicFeedState extends ConsumerState<UserDynamicFeed>
    with AutomaticKeepAliveClientMixin {
  final PaginationLoadGate _loadGate = PaginationLoadGate();

  @override
  bool get wantKeepAlive => true;

  @override
  void didUpdateWidget(covariant UserDynamicFeed oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.mid != widget.mid) {
      _loadGate.reset();
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final t = Translations.of(context);
    final feedAsync = ref.watch(userDynamicProvider(widget.mid));
    final notifier = ref.read(userDynamicProvider(widget.mid).notifier);

    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        final provider = userDynamicProvider(widget.mid);
        final providerNotifier = ref.read(provider.notifier);
        return ScrollLoadTrigger.triggerOnScrollNotificationWithGate(
          notification: notification,
          extentAfterThreshold: profileNestedFeedExtentAfterThreshold,
          viewportFactor: 1.1,
          maxThreshold: 820,
          gate: _loadGate,
          hasMore: providerNotifier.hasMore,
          task: providerNotifier.loadMore,
          itemCount: () => ref.read(provider).asData?.value.length ?? 0,
          hasMoreAfter: () => providerNotifier.hasMore,
          source: 'profile.user_dynamic_tab',
          onlyOnScrollEnd: profileNestedFeedOnlyOnScrollEnd,
        );
      },
      child: CustomScrollView(
        cacheExtent: profileNestedFeedCacheExtent,
        key: PageStorageKey<String>('user_dynamic_tab_${widget.mid}'),
        slivers: [
          SliverOverlapInjector(
            handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
          ),
          feedAsync.when(
            data: (items) {
              if (items.isEmpty) {
                return SliverFillRemaining(
                  child: Center(child: Text(t.common.no_content)),
                );
              }
              final contentCount = items.length * 2 - 1;
              final showLoadingFooter = feedAsync.isLoading && items.isNotEmpty;
              final totalCount = contentCount + (showLoadingFooter ? 1 : 0);
              return SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    if (index >= contentCount) {
                      return const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Center(child: CircularProgressIndicator()),
                      );
                    }
                    if (index.isOdd) {
                      return const SizedBox(height: 16);
                    }
                    final post = items[index ~/ 2];
                    return DynamicPostCard(
                      key: ValueKey('user_dynamic_${post.id}_$index'),
                      post: post,
                      header: DynamicPostHeader(post: post),
                      content: DynamicContentWidget(post: post),
                      onLike: () => notifier.toggleLike(post.id, post.isLiked),
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
                    return const _DynamicSkeleton();
                  }, childCount: childCount),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _DynamicSkeleton extends StatelessWidget {
  const _DynamicSkeleton();

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Theme.of(context).colorScheme.surface,
      margin: EdgeInsets.zero,
      shape: const RoundedRectangleBorder(),
      child: const AppShimmer(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  AppShimmerBox(width: 40, height: 40, borderRadius: 20),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppShimmerBox(height: 14, width: 100),
                        SizedBox(height: 6),
                        AppShimmerBox(height: 12, width: 60),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppShimmerBox(height: 14, width: double.infinity),
                  SizedBox(height: 8),
                  AppShimmerBox(height: 14, width: double.infinity),
                  SizedBox(height: 8),
                  AppShimmerBox(height: 14, width: 200),
                ],
              ),
              SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppShimmerBox(height: 20, width: 60),
                  AppShimmerBox(height: 20, width: 60),
                  AppShimmerBox(height: 20, width: 60),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
