import 'package:culcul/app/router/app_routes.dart';
import 'package:culcul/shared/hooks/use_managed_easy_refresh_controller.dart';
import 'package:culcul/shared/network/network_quality_policy.dart';
import 'package:culcul/shared/perf/performance_policy.dart';
import 'package:culcul/shared/responsive/responsive.dart';
import 'package:culcul/features/home/presentation/view_models/home_popular_view_model.dart';
import 'package:culcul/features/home/presentation/hooks/use_home_scroll_sync.dart';
import 'package:culcul/features/home/domain/entities/home_video.dart';
import 'package:culcul/features/home/presentation/widgets/home_layout_spec.dart';
import 'package:culcul/features/home/presentation/widgets/popular_video_card.dart';
import 'package:culcul/shared/widgets/app_network_image_prefetcher.dart';
import 'package:culcul/shared/widgets/skeletons/page_skeletons.dart';
import 'package:culcul/shared/widgets/skeletons/video_list_skeleton.dart';
import 'package:culcul/shared/widgets/smart_paging_view.dart';
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
    final cacheExtent = _resolveCacheExtent(
      layout.cacheExtent,
      networkPolicy: networkPolicy,
      perfPolicy: perfPolicy,
    );

    useHomeScrollSync(ref, scrollController, refreshController, 2);

    return ResponsiveContentContainer(
      maxWidth: AppBreakpoints.homePopularMaxWidth,
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
      value *= 0.75;
    } else if (networkPolicy.profile == NetworkQualityProfile.normal) {
      value *= 0.9;
    }

    if (perfPolicy.level == RenderDegradeLevel.minimalEffects) {
      value *= 0.8;
    } else if (perfPolicy.level == RenderDegradeLevel.reducedEffects) {
      value *= 0.92;
    }
    return value.clamp(320, base).toDouble();
  }
}

class _PopularVideoList extends HookWidget {
  const _PopularVideoList({
    required this.items,
    required this.scrollController,
    required this.layout,
    required this.cacheExtent,
    required this.networkPolicy,
  });

  final List<HomeVideo> items;
  final ScrollController scrollController;
  final HomePopularLayoutSpec layout;
  final double cacheExtent;
  final NetworkQualityPolicy networkPolicy;

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      final pixelRatio = MediaQuery.devicePixelRatioOf(context);
      AppNetworkImagePrefetcher.prefetch(
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
        limit: networkPolicy.resolvePrefetchLimit(6),
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
              );
            },
            separatorBuilder: (_, _) => SizedBox(height: layout.itemGap),
          ),
        ),
      ],
    );
  }
}
