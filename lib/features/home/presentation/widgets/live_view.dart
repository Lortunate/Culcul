import 'dart:math' as math;

import 'package:culcul/app/router/app_routes.dart';
import 'package:culcul/core/hooks/use_managed_easy_refresh_controller.dart';
import 'package:culcul/core/hooks/use_scroll_precache.dart';
import 'package:culcul/core/data/network/network_quality_policy.dart';
import 'package:culcul/core/perf/performance_policy.dart';
import 'package:culcul/core/runtime/runtime_performance_policy.dart';
import 'package:culcul/core/runtime/runtime_performance_policy_provider.dart';
import 'package:culcul/core/contracts/live_room_summary_contract.dart';
import 'package:culcul/features/live/application/live_recommend_provider.dart';
import 'package:culcul/features/home/presentation/widgets/live_card_skeleton.dart';
import 'package:culcul/features/home/presentation/widgets/home_feed_paging_shell.dart';
import 'package:culcul/features/home/presentation/widgets/home_feed_view_utils.dart';
import 'package:culcul/features/home/presentation/widgets/home_layout_spec.dart';
import 'package:culcul/features/home/presentation/widgets/live_room_card.dart';
import 'package:culcul/features/home/presentation/hooks/use_home_scroll_sync.dart';
import 'package:culcul/ui/widgets/media/app_network_image_prefetcher.dart';
import 'package:culcul/features/home/presentation/home_breakpoints.dart';
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
    final runtimePolicy = ref.watch(runtimePerformancePolicyProvider);
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

    return HomeFeedPagingShell(
      maxWidth: HomeBreakpoints.feedMaxWidth,
      asyncValue: liveAsync,
      controller: refreshController,
      onRefresh: ref.read(liveRecommendProvider.notifier).refresh,
      onLoadMore: ref.read(liveRecommendProvider.notifier).loadMore,
      itemCount: () => ref.read(liveRecommendProvider).value?.length ?? 0,
      hasMoreAfterLoad: ({required currentCount, required previousCount}) =>
          ref.read(liveRecommendProvider.notifier).hasMore,
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
        runtimePolicy: runtimePolicy,
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
      cacheExtent: cacheExtent,
      controller: scrollController,
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
    required this.runtimePolicy,
  });

  final List<LiveRoomSummary> items;
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
      final prefetchLimit = layout.gridDelegate.crossAxisCount * 2;
      prefetchHomeFeedImages(
        context,
        specs: items
            .take(prefetchLimit)
            .map(
              (room) => NetworkImagePrefetchSpec(
                url: room.cover,
                memCacheWidth: (width * pixelRatio).round(),
                memCacheHeight: (width / (16 / 9) * pixelRatio).round(),
              ),
            )
            .toList(growable: false),
        networkPolicy: networkPolicy,
        limit: prefetchLimit,
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
        final memH = (width / (16 / 9) * pixelRatio).round();
        final start = firstIndex + 1;
        final end = (start + count).clamp(0, items.length);
        if (start >= items.length) return <NetworkImagePrefetchSpec>[];
        return items
            .sublist(start, end)
            .map(
              (v) => NetworkImagePrefetchSpec(
                url: v.cover,
                memCacheWidth: memW,
                memCacheHeight: memH,
              ),
            )
            .toList(growable: false);
      },
    );

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
              final room = items[index];
              return LiveRoomCard(
                key: ValueKey('live_room_${room.roomId}'),
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
    final containerWidth = math.min(screenWidth, HomeBreakpoints.feedMaxWidth);
    final columns = layout.gridDelegate.crossAxisCount;
    final spacing = layout.gridDelegate.crossAxisSpacing * (columns - 1);
    return (containerWidth - layout.padding.horizontal - spacing) / columns;
  }
}
