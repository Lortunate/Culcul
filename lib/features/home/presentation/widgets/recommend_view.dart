import 'dart:math' as math;

import 'package:culcul/app/router/app_routes.dart';
import 'package:culcul/features/home/presentation/hooks/use_home_scroll_sync.dart';
import 'package:culcul/features/home/presentation/view_models/home_recommend_view_model.dart';
import 'package:culcul/features/home/presentation/widgets/home_feed_view_utils.dart';
import 'package:culcul/features/home/presentation/widgets/home_layout_spec.dart';
import 'package:culcul/features/home/presentation/widgets/home_video_actions.dart';
import 'package:culcul/core/hooks/use_managed_easy_refresh_controller.dart';
import 'package:culcul/core/hooks/use_scroll_precache.dart';
import 'package:culcul/core/contracts/video_model_contract.dart';
import 'package:culcul/core/data/network/network_quality_policy.dart';
import 'package:culcul/core/perf/performance_policy.dart';
import 'package:culcul/core/runtime/runtime_performance_policy.dart';
import 'package:culcul/core/runtime/runtime_performance_policy_provider.dart';
import 'package:culcul/ui/widgets/media/app_network_image_prefetcher.dart';
import 'package:culcul/ui/widgets/skeletons/page_skeletons.dart';
import 'package:culcul/ui/assemblies/feed_cards/video_card.dart';
import 'package:culcul/ui/assemblies/feed_cards/video_card_skeleton.dart';
import 'package:culcul/ui/widgets/smart_paging_view.dart';
import 'package:culcul/features/home/presentation/home_breakpoints.dart';
import 'package:culcul/ui/responsive/responsive_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class RecommendView extends HookConsumerWidget {
  const RecommendView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useAutomaticKeepAlive();

    final layout = HomeGridLayoutSpec.recommend(context);
    final networkPolicy = ref.watch(networkQualityPolicyProvider);
    final runtimePolicy = ref.watch(runtimePerformancePolicyProvider);
    final perfPolicy = useValueListenable(PerformancePolicyController.notifier);
    final recommendAsync = ref.watch(homeRecommendProvider);
    final scrollController = useScrollController();
    final refreshController = useManagedEasyRefreshController();
    final cacheExtent = resolveHomeFeedCacheExtent(
      layout.cacheExtent,
      networkPolicy: networkPolicy,
      perfPolicy: perfPolicy,
      tuning: const HomeFeedCacheTuning(
        constrainedNetworkFactor: 0.72,
        normalNetworkFactor: 0.88,
        minimalEffectsFactor: 0.78,
        reducedEffectsFactor: 0.9,
        minExtent: 360,
      ),
    );

    useHomeScrollSync(ref, scrollController, refreshController, 1);

    return ResponsiveContentContainer(
      maxWidth: HomeBreakpoints.feedMaxWidth,
      child: SmartPagingView(
        asyncValue: recommendAsync,
        controller: refreshController,
        onRefresh: ref.read(homeRecommendProvider.notifier).refresh,
        onLoadMore: ref.read(homeRecommendProvider.notifier).loadMore,
        itemCount: () => recommendAsync.value?.length ?? 0,
        skeleton: GridSkeletonView(
          itemSkeleton: const VideoCardSkeleton(),
          itemCount: layout.skeletonCount,
          gridDelegate: layout.gridDelegate,
          padding: layout.padding,
        ),
        builder: (context, items) => _RecommendVideoGrid(
          items: items,
          ref: ref,
          scrollController: scrollController,
          layout: layout,
          cacheExtent: cacheExtent,
          networkPolicy: networkPolicy,
          runtimePolicy: runtimePolicy,
        ),
      ),
    );
  }
}

class _RecommendVideoGrid extends HookWidget {
  const _RecommendVideoGrid({
    required this.items,
    required this.ref,
    required this.scrollController,
    required this.layout,
    required this.cacheExtent,
    required this.networkPolicy,
    required this.runtimePolicy,
  });

  final List<VideoModel> items;
  final WidgetRef ref;
  final ScrollController scrollController;
  final HomeGridLayoutSpec layout;
  final double cacheExtent;
  final NetworkQualityPolicy networkPolicy;
  final RuntimePerformancePolicy runtimePolicy;

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      final width = _estimateGridItemWidth(context);
      final pixelRatio = MediaQuery.devicePixelRatioOf(context);
      prefetchHomeFeedImages(
        context,
        specs: items
            .map(
              (video) => NetworkImagePrefetchSpec(
                url: video.pic,
                memCacheWidth: (width * pixelRatio).round(),
                memCacheHeight: (width / (16 / 10) * pixelRatio).round(),
              ),
            )
            .toList(growable: false),
        networkPolicy: networkPolicy,
        limit: layout.gridDelegate.crossAxisCount * 2,
      );
      return null;
    }, [items, networkPolicy]);

    useScrollPrecache(
      scrollController: scrollController,
      prefetchCount: layout.gridDelegate.crossAxisCount * 2,
      runtimePolicy: runtimePolicy,
      getUpcomingSpecs: (firstIndex, count) {
        final width = _estimateGridItemWidth(context);
        final pixelRatio = MediaQuery.devicePixelRatioOf(context);
        final memW = (width * pixelRatio).round();
        final memH = (width / (16 / 10) * pixelRatio).round();
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
                onTap: () => VideoDetailRoute(bvid: video.bvid).push(context),
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
  }

  double _estimateGridItemWidth(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final containerWidth = math.min(screenWidth, HomeBreakpoints.feedMaxWidth);
    final columns = layout.gridDelegate.crossAxisCount;
    final spacing = layout.gridDelegate.crossAxisSpacing * (columns - 1);
    return (containerWidth - layout.padding.horizontal - spacing) / columns;
  }
}
