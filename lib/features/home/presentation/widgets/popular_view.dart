import 'package:culcul/app/router/app_routes.dart';
import 'package:culcul/features/home/presentation/hooks/use_home_scroll_sync.dart';
import 'package:culcul/features/home/presentation/view_models/home_popular_view_model.dart';
import 'package:culcul/features/home/presentation/widgets/home_feed_view_utils.dart';
import 'package:culcul/features/home/presentation/widgets/home_video_actions.dart';
import 'package:culcul/core/hooks/use_managed_easy_refresh_controller.dart';
import 'package:culcul/core/hooks/use_scroll_precache.dart';
import 'package:culcul/core/contracts/video_model_contract.dart';
import 'package:culcul/core/data/network/network_quality_policy.dart';
import 'package:culcul/core/perf/performance_policy.dart';
import 'package:culcul/features/home/presentation/widgets/home_layout_spec.dart';
import 'package:culcul/features/home/presentation/widgets/popular_video_card.dart';
import 'package:culcul/ui/widgets/media/app_network_image_prefetcher.dart';
import 'package:culcul/ui/widgets/skeletons/page_skeletons.dart';
import 'package:culcul/ui/assemblies/feed_cards/video_list_skeleton.dart';
import 'package:culcul/ui/widgets/smart_paging_view.dart';
import 'package:culcul/features/home/presentation/home_breakpoints.dart';
import 'package:culcul/ui/responsive/responsive_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PopularView extends HookConsumerWidget {
  const PopularView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useAutomaticKeepAlive();

    final layout = HomePopularLayoutSpec.fromContext(context);
    final networkPolicy = ref.watch(networkQualityPolicyProvider);
    final perfPolicy = useValueListenable(PerformancePolicyController.notifier);
    final popularAsync = ref.watch(homePopularProvider);
    final scrollController = useScrollController();
    final refreshController = useManagedEasyRefreshController();
    final cacheExtent = resolveHomeFeedCacheExtent(
      layout.cacheExtent,
      networkPolicy: networkPolicy,
      perfPolicy: perfPolicy,
      tuning: const HomeFeedCacheTuning(
        constrainedNetworkFactor: 0.75,
        normalNetworkFactor: 0.9,
        minimalEffectsFactor: 0.8,
        reducedEffectsFactor: 0.92,
        minExtent: 320,
      ),
    );

    useHomeScrollSync(ref, scrollController, refreshController, 2);

    return ResponsiveContentContainer(
      maxWidth: HomeBreakpoints.popularMaxWidth,
      child: SmartPagingView(
        asyncValue: popularAsync,
        controller: refreshController,
        onRefresh: ref.read(homePopularProvider.notifier).refresh,
        onLoadMore: ref.read(homePopularProvider.notifier).loadMore,
        itemCount: () => popularAsync.value?.length ?? 0,
        skeleton: ListSkeletonView(
          itemSkeleton: const VideoListSkeleton(),
          padding: layout.padding,
          itemPadding: layout.skeletonItemPadding,
        ),
        builder: (context, items) => _PopularVideoList(
          items: items,
          ref: ref,
          scrollController: scrollController,
          layout: layout,
          cacheExtent: cacheExtent,
          networkPolicy: networkPolicy,
        ),
      ),
    );
  }
}

class _PopularVideoList extends HookWidget {
  const _PopularVideoList({
    required this.items,
    required this.ref,
    required this.scrollController,
    required this.layout,
    required this.cacheExtent,
    required this.networkPolicy,
  });

  final List<VideoModel> items;
  final WidgetRef ref;
  final ScrollController scrollController;
  final HomePopularLayoutSpec layout;
  final double cacheExtent;
  final NetworkQualityPolicy networkPolicy;

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      final pixelRatio = MediaQuery.devicePixelRatioOf(context);
      prefetchHomeFeedImages(
        context,
        specs: items
            .map(
              (video) => NetworkImagePrefetchSpec(
                url: video.pic,
                memCacheWidth: (layout.thumbnailWidth * pixelRatio).round(),
                memCacheHeight: (layout.thumbnailWidth / (16 / 10) * pixelRatio).round(),
              ),
            )
            .toList(growable: false),
        networkPolicy: networkPolicy,
        limit: 6,
      );
      return null;
    }, [items, networkPolicy]);

    useScrollPrecache(
      scrollController: scrollController,
      prefetchCount: 5,
      getUpcomingSpecs: (firstIndex, count) {
        final pixelRatio = MediaQuery.devicePixelRatioOf(context);
        final memW = (layout.thumbnailWidth * pixelRatio).round();
        final memH = (layout.thumbnailWidth / (16 / 10) * pixelRatio).round();
        final start = firstIndex + 1;
        final end = (start + count).clamp(0, items.length);
        if (start >= items.length) return <NetworkImagePrefetchSpec>[];
        return items
            .sublist(start, end)
            .map(
              (v) => NetworkImagePrefetchSpec(
                url: v.pic,
                memCacheWidth: memW,
                memCacheHeight: memH,
              ),
            )
            .toList(growable: false);
      },
    );

    return CustomScrollView(
      controller: scrollController,
      cacheExtent: cacheExtent,
      slivers: [
        SliverPadding(
          padding: layout.padding,
          sliver: SliverList.separated(
            itemCount: items.length,
            itemBuilder: (context, index) {
              final video = items[index];
              return PopularVideoCard(
                key: ValueKey('popular_v_${video.bvid}_$index'),
                video: video,
                cardHeight: layout.cardHeight,
                thumbnailWidth: layout.thumbnailWidth,
                onTap: () => VideoDetailRoute(bvid: video.bvid).push(context),
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
  }
}
