import 'package:culcul/core/models/live_room_summary_contract.dart';
import 'package:culcul/core/data/pagination/paged_async_notifier.dart';
import 'package:culcul/core/hooks/use_managed_easy_refresh_controller.dart';
import 'package:culcul/core/hooks/use_scroll_precache.dart';
import 'package:culcul/core/data/network/network_quality_policy.dart';
import 'package:culcul/core/perf/dev_logger.dart';
import 'package:culcul/core/perf/performance_policy.dart';
import 'package:culcul/core/runtime/runtime_performance_policy_provider.dart';
import 'package:culcul/features/home/presentation/widgets/home_feed_paging_shell.dart';
import 'package:culcul/features/home/presentation/widgets/home_feed_view_utils.dart';
import 'package:culcul/features/home/presentation/widgets/home_layout_spec.dart';
import 'package:culcul/features/home/presentation/widgets/live_room_card.dart';
import 'package:culcul/features/home/presentation/hooks/use_home_scroll_sync.dart';
import 'package:culcul/features/live/data/live_paging_constants.dart';
import 'package:culcul/features/live/data/live_repository_impl.dart';
import 'package:culcul/ui/widgets/cards/app_card_container.dart';
import 'package:culcul/ui/widgets/feedback/app_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final _liveRecommendProvider =
    AsyncNotifierProvider.autoDispose<_LiveRecommend, List<LiveRoomSummary>>(
      _LiveRecommend.new,
    );

class _LiveRecommend extends AsyncNotifier<List<LiveRoomSummary>>
    with OffsetPagedAsyncNotifier<LiveRoomSummary> {
  @override
  Future<List<LiveRoomSummary>> build() async {
    return buildFirstPage();
  }

  @override
  Future<List<LiveRoomSummary>> fetchPage(int page) async {
    final result = await ref
        .read(liveRepositoryProvider)
        .getRecommendList(page: page, pageSize: liveRecommendPageSize);
    return result.when(
      success: (data) => data,
      failure: (error) {
        DevLogger.log('feature', 'live.recommend_feed.load_error', <String, Object?>{
          'error': error,
        });
        return const <LiveRoomSummary>[];
      },
    );
  }

  @override
  Object itemId(LiveRoomSummary item) => item.roomId;

  @override
  bool hasMoreAfterPage(List<LiveRoomSummary> items) =>
      items.length >= liveRecommendPageSize;

  Future<void> refresh() {
    return refreshPage();
  }

  Future<void> loadMore() {
    return loadNextPage();
  }
}

class LiveView extends HookConsumerWidget {
  final ValueChanged<int> onOpenRoom;

  const LiveView({super.key, required this.onOpenRoom});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useAutomaticKeepAlive();

    final layout = HomeGridLayoutSpec.live(context);
    final networkPolicy = ref.watch(networkQualityPolicyProvider);
    final runtimePolicy = ref.watch(runtimePerformancePolicyProvider);
    final perfPolicy = useValueListenable(PerformancePolicyController.notifier);
    final liveAsync = ref.watch(_liveRecommendProvider);
    final liveItems = liveAsync.value ?? const [];
    final scrollController = useScrollController();
    final refreshController = useManagedEasyRefreshController();
    final cacheExtent = resolveHomeFeedCacheExtent(
      layout.cacheExtent,
      networkPolicy: networkPolicy,
      perfPolicy: perfPolicy,
      tuning: homeGridFeedCacheTuning,
    );

    useHomeScrollSync(ref, scrollController, refreshController, 0);

    useEffect(() {
      if (liveItems.isEmpty) {
        return null;
      }

      final width = estimateHomeGridItemWidth(context, layout);
      final pixelRatio = MediaQuery.devicePixelRatioOf(context);
      final prefetchLimit = resolveHomeGridPrefetchLimit(
        layout.gridDelegate.crossAxisCount,
      );
      prefetchHomeFeedImages(
        context,
        specs: buildHomeFeedImagePrefetchSpecs(
          liveItems,
          startIndex: 0,
          count: prefetchLimit,
          logicalWidth: width,
          pixelRatio: pixelRatio,
          aspectRatio: homeLiveFeedImageAspectRatio,
          imageUrl: (room) => room.cover,
        ),
        networkPolicy: networkPolicy,
        limit: prefetchLimit,
      );
      return null;
    }, [liveItems, networkPolicy]);

    useScrollPrecache(
      scrollController: scrollController,
      prefetchCount: resolveHomeGridPrefetchLimit(layout.gridDelegate.crossAxisCount),
      runtimePolicy: runtimePolicy,
      getUpcomingSpecs: (firstIndex, count) {
        if (liveItems.isEmpty) {
          return const [];
        }

        final width = estimateHomeGridItemWidth(context, layout);
        final pixelRatio = MediaQuery.devicePixelRatioOf(context);
        return buildHomeFeedImagePrefetchSpecs(
          liveItems,
          startIndex: firstIndex + 1,
          count: count,
          logicalWidth: width,
          pixelRatio: pixelRatio,
          aspectRatio: homeLiveFeedImageAspectRatio,
          imageUrl: (room) => room.cover,
        );
      },
    );

    return HomeFeedPagingShell(
      maxWidth: homeFeedMaxWidth,
      asyncValue: liveAsync,
      controller: refreshController,
      onRefresh: ref.read(_liveRecommendProvider.notifier).refresh,
      onLoadMore: ref.read(_liveRecommendProvider.notifier).loadMore,
      itemCount: () => ref.read(_liveRecommendProvider).value?.length ?? 0,
      hasMoreAfterLoad: ({required currentCount, required previousCount}) =>
          ref.read(_liveRecommendProvider.notifier).hasMore,
      skeleton: CustomScrollView(
        cacheExtent: cacheExtent,
        controller: scrollController,
        slivers: [
          SliverPadding(
            padding: layout.padding,
            sliver: SliverGrid.builder(
              gridDelegate: layout.gridDelegate,
              itemCount: layout.skeletonCount,
              itemBuilder: (_, _) => const AppCardContainer(
                child: AppShimmer(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AspectRatio(
                        aspectRatio: homeLiveFeedImageAspectRatio,
                        child: AppShimmerBox(borderRadius: 12),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppShimmerBox(height: 14, width: double.infinity),
                            SizedBox(height: 6),
                            AppShimmerBox(height: 14, width: 80),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                AppShimmerBox(width: 20, height: 20, borderRadius: 10),
                                SizedBox(width: 6),
                                Expanded(child: AppShimmerBox(height: 12)),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      builder: (context, items) => CustomScrollView(
        cacheExtent: cacheExtent,
        controller: scrollController,
        slivers: [
          SliverPadding(
            padding: layout.padding,
            sliver: SliverGrid.builder(
              gridDelegate: layout.gridDelegate,
              itemCount: items.length,
              itemBuilder: (context, index) {
                final room = items[index];
                return LiveRoomCard(
                  key: ValueKey('live_room_${room.roomId}'),
                  room: room,
                  onTap: () => onOpenRoom(room.roomId),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
