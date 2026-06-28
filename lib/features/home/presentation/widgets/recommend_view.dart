import 'package:culcul/core/constants/api_constants.dart';
import 'package:culcul/core/models/video_model_contract.dart';
import 'package:culcul/core/data/network/network_quality_policy.dart';
import 'package:culcul/core/data/pagination/paged_async_notifier.dart';
import 'package:culcul/core/hooks/use_managed_easy_refresh_controller.dart';
import 'package:culcul/core/hooks/use_scroll_precache.dart';
import 'package:culcul/core/perf/performance_policy.dart';
import 'package:culcul/core/runtime/runtime_performance_policy_provider.dart';
import 'package:culcul/features/home/data/home_feed_paging_constants.dart';
import 'package:culcul/features/home/data/home_repository_impl.dart';
import 'package:culcul/features/home/presentation/hooks/use_home_scroll_sync.dart';
import 'package:culcul/features/home/presentation/widgets/home_feed_paging_shell.dart';
import 'package:culcul/features/home/presentation/widgets/home_feed_view_utils.dart';
import 'package:culcul/features/home/presentation/widgets/home_layout_spec.dart';
import 'package:culcul/features/home/presentation/widgets/home_video_actions.dart';
import 'package:culcul/features/home/state/home_feed_paging_mixin.dart';
import 'package:culcul/ui/widgets/cards/video_card.dart';
import 'package:culcul/ui/widgets/cards/video_card_skeleton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final _homeRecommendProvider = AsyncNotifierProvider<_HomeRecommend, List<VideoModel>>(
  _HomeRecommend.new,
);

class _HomeRecommend extends AsyncNotifier<List<VideoModel>>
    with OffsetPagedAsyncNotifier<VideoModel>, HomeFeedPagingMixin {
  @override
  Future<List<VideoModel>> build() {
    return buildFirstPageWithSilentRefresh(
      perfChain: 'home.recommend_feed',
      cachePath: ApiConstants.feedRcmd,
      cacheQuery: const <String, Object?>{
        'fresh_type': 4,
        'ps': homeFeedPageSize,
        'fresh_idx': 1,
        'fresh_idx_1h': 1,
      },
      loadPage: _loadPage,
    );
  }

  @override
  Future<List<VideoModel>> fetchPage(int page) =>
      _loadPage(page, forceRefresh: isRefreshing);

  Future<List<VideoModel>> _loadPage(int page, {required bool forceRefresh}) =>
      loadFeedPage(
        perfChain: 'home.recommend_feed',
        page: page,
        forceRefresh: forceRefresh,
        fetchPage: ref.read(homeRepositoryImplProvider).fetchRecommendPage,
      );
}

class RecommendView extends HookConsumerWidget {
  final ValueChanged<String> onOpenVideo;

  const RecommendView({super.key, required this.onOpenVideo});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useAutomaticKeepAlive();

    final layout = HomeGridLayoutSpec.recommend(context);
    final networkPolicy = ref.watch(networkQualityPolicyProvider);
    final runtimePolicy = ref.watch(runtimePerformancePolicyProvider);
    final perfPolicy = useValueListenable(PerformancePolicyController.notifier);
    final recommendAsync = ref.watch(_homeRecommendProvider);
    final scrollController = useScrollController();
    final refreshController = useManagedEasyRefreshController();
    final recommendItems = recommendAsync.value;
    final cacheExtent = resolveHomeFeedCacheExtent(
      layout.cacheExtent,
      networkPolicy: networkPolicy,
      perfPolicy: perfPolicy,
      tuning: homeGridFeedCacheTuning,
    );

    useHomeScrollSync(ref, scrollController, refreshController, 1);
    useEffect(() {
      final items = recommendItems;
      if (items == null || items.isEmpty) return null;

      final width = estimateHomeGridItemWidth(context, layout);
      final pixelRatio = MediaQuery.devicePixelRatioOf(context);
      final prefetchLimit = resolveHomeGridPrefetchLimit(
        layout.gridDelegate.crossAxisCount,
      );
      prefetchHomeFeedImages(
        context,
        specs: buildHomeFeedImagePrefetchSpecs(
          items,
          startIndex: 0,
          count: prefetchLimit,
          logicalWidth: width,
          pixelRatio: pixelRatio,
          aspectRatio: homeVideoFeedImageAspectRatio,
          imageUrl: (video) => video.pic,
        ),
        networkPolicy: networkPolicy,
        limit: prefetchLimit,
      );
      return null;
    }, [recommendItems, networkPolicy]);

    useScrollPrecache(
      scrollController: scrollController,
      prefetchCount: resolveHomeGridPrefetchLimit(layout.gridDelegate.crossAxisCount),
      runtimePolicy: runtimePolicy,
      getUpcomingSpecs: (firstIndex, count) {
        final items = recommendItems;
        if (items == null || items.isEmpty) return const [];

        final width = estimateHomeGridItemWidth(context, layout);
        final pixelRatio = MediaQuery.devicePixelRatioOf(context);
        return buildHomeFeedImagePrefetchSpecs(
          items,
          startIndex: firstIndex + 1,
          count: count,
          logicalWidth: width,
          pixelRatio: pixelRatio,
          aspectRatio: homeVideoFeedImageAspectRatio,
          imageUrl: (video) => video.pic,
        );
      },
    );

    return HomeFeedPagingShell(
      maxWidth: homeFeedMaxWidth,
      asyncValue: recommendAsync,
      controller: refreshController,
      onRefresh: ref.read(_homeRecommendProvider.notifier).refresh,
      onLoadMore: ref.read(_homeRecommendProvider.notifier).loadMore,
      itemCount: () => ref.read(_homeRecommendProvider).value?.length ?? 0,
      skeleton: CustomScrollView(
        physics: const NeverScrollableScrollPhysics(),
        slivers: [
          SliverPadding(
            padding: layout.padding,
            sliver: SliverGrid(
              gridDelegate: layout.gridDelegate,
              delegate: SliverChildBuilderDelegate(
                (context, index) => const VideoCardSkeleton(),
                childCount: layout.skeletonCount,
              ),
            ),
          ),
        ],
      ),
      builder: (context, items) {
        return CustomScrollView(
          cacheExtent: cacheExtent,
          controller: scrollController,
          slivers: [
            SliverPadding(
              padding: layout.padding,
              sliver: SliverGrid.builder(
                gridDelegate: layout.gridDelegate,
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final video = items[index];
                  return VideoCard(
                    key: ValueKey('recommend_v_${video.bvid}'),
                    bvid: video.bvid,
                    title: video.title,
                    coverUrl: video.pic,
                    author: video.owner.name,
                    description: video.desc,
                    duration: video.duration,
                    viewCount: video.stat.view,
                    danmakuCount: video.stat.danmaku,
                    reason: video.rcmdReason,
                    onTap: () => onOpenVideo(video.bvid),
                    onLongPress: () => showHomeVideoActionsBottomSheet(
                      context,
                      ref,
                      bvid: video.bvid,
                      coverUrl: video.pic,
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
