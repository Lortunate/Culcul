import 'dart:math' as math;

import 'package:culcul/app/router/app_routes.dart';
import 'package:culcul/core/hooks/use_managed_easy_refresh_controller.dart';
import 'package:culcul/core/hooks/use_scroll_precache.dart';
import 'package:culcul/core/data/network/network_quality_policy.dart';
import 'package:culcul/core/perf/performance_policy.dart';
import 'package:culcul/features/live/presentation/view_models/live_recommend_view_model.dart';
import 'package:culcul/core/contracts/live_room_summary_contract.dart';
import 'package:culcul/features/home/presentation/widgets/live_card_skeleton.dart';
import 'package:culcul/features/home/presentation/widgets/home_feed_view_utils.dart';
import 'package:culcul/features/home/presentation/widgets/home_layout_spec.dart';
import 'package:culcul/features/home/presentation/widgets/live_room_card.dart';
import 'package:culcul/features/home/presentation/hooks/use_home_scroll_sync.dart';
import 'package:culcul/ui/widgets/media/app_network_image_prefetcher.dart';
import 'package:culcul/ui/widgets/smart_paging_view.dart';
import 'package:culcul/ui/responsive/app_breakpoints.dart';
import 'package:culcul/ui/responsive/responsive_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LiveView extends HookConsumerWidget {
  const LiveView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useAutomaticKeepAlive();

    final layout = HomeGridLayoutSpec.live(context);
    final networkPolicy = ref.watch(networkQualityPolicyProvider);
    final perfPolicy = useValueListenable(PerformancePolicyController.notifier);
    final liveAsync = ref.watch(liveRecommendProvider);
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

    useHomeScrollSync(ref, scrollController, refreshController, 0);

    return ResponsiveContentContainer(
      maxWidth: AppBreakpoints.homeFeedMaxWidth,
      child: SmartPagingView(
        asyncValue: liveAsync,
        controller: refreshController,
        onRefresh: ref.read(liveRecommendProvider.notifier).refresh,
        onLoadMore: ref.read(liveRecommendProvider.notifier).loadMore,
        itemCount: () => liveAsync.value?.length ?? 0,
        skeleton: _LiveGridSkeleton(
          scrollController: scrollController,
          layout: layout,
          cacheExtent: cacheExtent,
        ),
        builder: (context, items) => _LiveGrid(
          items: items,
          scrollController: scrollController,
          layout: layout,
          cacheExtent: cacheExtent,
          networkPolicy: networkPolicy,
        ),
      ),
    );
  }
}

class _LiveGridSkeleton extends StatelessWidget {
  const _LiveGridSkeleton({
    required this.scrollController,
    required this.layout,
    required this.cacheExtent,
  });

  final ScrollController scrollController;
  final HomeGridLayoutSpec layout;
  final double cacheExtent;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: scrollController,
      cacheExtent: cacheExtent,
      slivers: [
        SliverPadding(
          padding: layout.padding,
          sliver: SliverGrid.builder(
            gridDelegate: layout.gridDelegate,
            itemCount: layout.skeletonCount,
            itemBuilder: (_, _) => const LiveCardSkeleton(),
          ),
        ),
      ],
    );
  }
}

class _LiveGrid extends HookWidget {
  const _LiveGrid({
    required this.items,
    required this.scrollController,
    required this.layout,
    required this.cacheExtent,
    required this.networkPolicy,
  });

  final List<LiveRoomSummary> items;
  final ScrollController scrollController;
  final HomeGridLayoutSpec layout;
  final double cacheExtent;
  final NetworkQualityPolicy networkPolicy;

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      final width = _estimateGridItemWidth(context);
      final pixelRatio = MediaQuery.devicePixelRatioOf(context);
      prefetchHomeFeedImages(
        context,
        specs: items
            .map(
              (room) => NetworkImagePrefetchSpec(
                url: room.cover,
                memCacheWidth: (width * pixelRatio).round(),
                memCacheHeight: (width / (16 / 9) * pixelRatio).round(),
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
      getUpcomingSpecs: (firstIndex, count) {
        final width = _estimateGridItemWidth(context);
        final pixelRatio = MediaQuery.devicePixelRatioOf(context);
        final memW = (width * pixelRatio).round();
        final memH = (width / (16 / 9) * pixelRatio).round();
        final start = firstIndex + 1;
        final end = (start + count).clamp(0, items.length);
        if (start >= items.length) return <NetworkImagePrefetchSpec>[];
        return items
            .sublist(start, end)
            .map((v) => NetworkImagePrefetchSpec(
                  url: v.cover,
                  memCacheWidth: memW,
                  memCacheHeight: memH,
                ))
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
              final room = items[index];
              return LiveRoomCard(
                room: room,
                onTap: () => LiveRoomRoute(roomId: room.roomId).push(context),
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
