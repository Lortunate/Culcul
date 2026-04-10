import 'dart:math' as math;

import 'package:culcul/app/router/app_routes.dart';
import 'package:culcul/core/hooks/use_managed_easy_refresh_controller.dart';
import 'package:culcul/core/network/network_quality_policy.dart';
import 'package:culcul/core/perf/performance_policy.dart';
import 'package:culcul/core/responsive/responsive.dart';
import 'package:culcul/features/home/presentation/view_models/home_recommend_view_model.dart';
import 'package:culcul/features/home/presentation/hooks/use_home_scroll_sync.dart';
import 'package:culcul/features/home/domain/entities/home_video.dart';
import 'package:culcul/features/home/presentation/widgets/home_layout_spec.dart';
import 'package:culcul/ui/widgets/app_network_image_prefetcher.dart';
import 'package:culcul/ui/widgets/skeletons/page_skeletons.dart';
import 'package:culcul/ui/widgets/skeletons/video_card_skeleton.dart';
import 'package:culcul/ui/widgets/smart_paging_view.dart';
import 'package:culcul/ui/widgets/video_card.dart';
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
    final perfPolicy = useValueListenable(PerformancePolicyController.notifier);
    final recommendAsync = ref.watch(homeRecommendProvider);
    final scrollController = useScrollController();
    final refreshController = useManagedEasyRefreshController();
    final cacheExtent = _resolveCacheExtent(
      layout.cacheExtent,
      networkPolicy: networkPolicy,
      perfPolicy: perfPolicy,
    );

    useHomeScrollSync(ref, scrollController, refreshController, 1);

    return ResponsiveContentContainer(
      maxWidth: AppBreakpoints.homeFeedMaxWidth,
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
          scrollController: scrollController,
          layout: layout,
          cacheExtent: cacheExtent,
          networkPolicy: networkPolicy,
        ),
      ),
    );
  }

  double _resolveCacheExtent(
    double base, {
    required NetworkQualityPolicy networkPolicy,
    required PerformancePolicy perfPolicy,
  }) {
    var value = base;
    if (networkPolicy.profile == NetworkQualityProfile.constrained) {
      value *= 0.72;
    } else if (networkPolicy.profile == NetworkQualityProfile.normal) {
      value *= 0.88;
    }

    if (perfPolicy.level == RenderDegradeLevel.minimalEffects) {
      value *= 0.78;
    } else if (perfPolicy.level == RenderDegradeLevel.reducedEffects) {
      value *= 0.9;
    }
    return value.clamp(360, base).toDouble();
  }
}

class _RecommendVideoGrid extends HookWidget {
  const _RecommendVideoGrid({
    required this.items,
    required this.scrollController,
    required this.layout,
    required this.cacheExtent,
    required this.networkPolicy,
  });

  final List<HomeVideo> items;
  final ScrollController scrollController;
  final HomeGridLayoutSpec layout;
  final double cacheExtent;
  final NetworkQualityPolicy networkPolicy;

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      final width = _estimateGridItemWidth(context);
      final pixelRatio = MediaQuery.devicePixelRatioOf(context);
      AppNetworkImagePrefetcher.prefetch(
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
        limit: networkPolicy.resolvePrefetchLimit(layout.gridDelegate.crossAxisCount * 2),
        maxConcurrency: networkPolicy.prefetchMaxConcurrency,
        queueCapacity: networkPolicy.prefetchQueueCapacity,
        ttl: networkPolicy.prefetchKeyTtl,
        lruCapacity: networkPolicy.prefetchLruCapacity,
      );
      return null;
    }, [items, networkPolicy]);

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
                key: ValueKey('recommend_v_${video.bvid}_$index'),
                bvid: video.bvid,
                title: video.title,
                coverUrl: video.pic,
                author: video.owner.name,
                description: video.desc,
                duration: video.duration,
                viewCount: video.stats.view,
                danmakuCount: video.stats.danmaku,
                reason: video.rcmdReason,
                onTap: () => VideoDetailRoute(bvid: video.bvid).push(context),
              );
            },
          ),
        ),
      ],
    );
  }

  double _estimateGridItemWidth(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final containerWidth = math.min(screenWidth, AppBreakpoints.homeFeedMaxWidth);
    final columns = layout.gridDelegate.crossAxisCount;
    final spacing = layout.gridDelegate.crossAxisSpacing * (columns - 1);
    return (containerWidth - layout.padding.horizontal - spacing) / columns;
  }
}
