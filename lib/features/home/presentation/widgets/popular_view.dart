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
import 'package:culcul/features/home/presentation/widgets/popular_video_card.dart';
import 'package:culcul/features/home/state/home_feed_paging_mixin.dart';
import 'package:culcul/ui/widgets/cards/video_list_skeleton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final _homePopularProvider = AsyncNotifierProvider<_HomePopular, List<VideoModel>>(
  _HomePopular.new,
);

class _HomePopular extends AsyncNotifier<List<VideoModel>>
    with OffsetPagedAsyncNotifier<VideoModel>, HomeFeedPagingMixin {
  @override
  Future<List<VideoModel>> build() {
    return buildFirstPageWithSilentRefresh(
      perfChain: 'home.popular_feed',
      cachePath: ApiConstants.popular,
      cacheQuery: const <String, Object?>{'pn': 1, 'ps': homeFeedPageSize},
      loadPage: _loadPage,
    );
  }

  @override
  Future<List<VideoModel>> fetchPage(int page) =>
      _loadPage(page, forceRefresh: isRefreshing);

  Future<List<VideoModel>> _loadPage(int page, {required bool forceRefresh}) =>
      loadFeedPage(
        perfChain: 'home.popular_feed',
        page: page,
        forceRefresh: forceRefresh,
        fetchPage: ref.read(homeRepositoryImplProvider).fetchPopularPage,
      );
}

class PopularView extends HookConsumerWidget {
  final ValueChanged<String> onOpenVideo;

  const PopularView({super.key, required this.onOpenVideo});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useAutomaticKeepAlive();

    final layout = HomePopularLayoutSpec.fromContext(context);
    final networkPolicy = ref.watch(networkQualityPolicyProvider);
    final runtimePolicy = ref.watch(runtimePerformancePolicyProvider);
    final perfPolicy = useValueListenable(PerformancePolicyController.notifier);
    final popularAsync = ref.watch(_homePopularProvider);
    final popularItems = popularAsync.value ?? const <VideoModel>[];
    final scrollController = useScrollController();
    final refreshController = useManagedEasyRefreshController();
    final popularNotifier = ref.read(_homePopularProvider.notifier);
    final cacheExtent = resolveHomeFeedCacheExtent(
      layout.cacheExtent,
      networkPolicy: networkPolicy,
      perfPolicy: perfPolicy,
      tuning: homePopularFeedCacheTuning,
    );

    useHomeScrollSync(ref, scrollController, refreshController, 2);

    useEffect(() {
      if (popularItems.isEmpty) {
        return null;
      }

      final pixelRatio = MediaQuery.devicePixelRatioOf(context);
      prefetchHomeFeedImages(
        context,
        specs: buildHomeFeedImagePrefetchSpecs(
          popularItems,
          startIndex: 0,
          count: homePopularInitialPrefetchLimit,
          logicalWidth: layout.thumbnailWidth,
          pixelRatio: pixelRatio,
          aspectRatio: homeVideoFeedImageAspectRatio,
          imageUrl: (video) => video.pic,
        ),
        networkPolicy: networkPolicy,
        limit: homePopularInitialPrefetchLimit,
      );
      return null;
    }, [popularItems, networkPolicy]);

    useScrollPrecache(
      scrollController: scrollController,
      runtimePolicy: runtimePolicy,
      getUpcomingSpecs: (firstIndex, count) {
        final pixelRatio = MediaQuery.devicePixelRatioOf(context);
        return buildHomeFeedImagePrefetchSpecs(
          popularItems,
          startIndex: firstIndex + 1,
          count: count,
          logicalWidth: layout.thumbnailWidth,
          pixelRatio: pixelRatio,
          aspectRatio: homeVideoFeedImageAspectRatio,
          imageUrl: (video) => video.pic,
        );
      },
    );

    return HomeFeedPagingShell(
      maxWidth: homePopularMaxWidth,
      asyncValue: popularAsync,
      controller: refreshController,
      onRefresh: popularNotifier.refresh,
      onLoadMore: popularNotifier.loadMore,
      itemCount: () => ref.read(_homePopularProvider).value?.length ?? 0,
      skeleton: CustomScrollView(
        physics: const NeverScrollableScrollPhysics(),
        slivers: [
          SliverPadding(
            padding: layout.padding,
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => Padding(
                  padding: layout.skeletonItemPadding,
                  child: const VideoListSkeleton(),
                ),
                childCount: 10,
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
              sliver: SliverList.separated(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final video = items[index];
                  return PopularVideoCard(
                    key: ValueKey('popular_v_${video.bvid}'),
                    video: video,
                    cardHeight: layout.cardHeight,
                    thumbnailWidth: layout.thumbnailWidth,
                    onTap: () => onOpenVideo(video.bvid),
                    onLongPress: () => showHomeVideoActionsBottomSheet(
                      context,
                      ref,
                      bvid: video.bvid,
                      coverUrl: video.pic,
                    ),
                  );
                },
                separatorBuilder: (_, _) => SizedBox(height: layout.itemGap),
              ),
            ),
          ],
        );
      },
    );
  }
}
