import 'package:culcul/app/router/app_routes.dart';
import 'package:culcul/core/hooks/use_managed_easy_refresh_controller.dart';
import 'package:culcul/core/responsive/responsive.dart';
import 'package:culcul/features/home/presentation/view_models/home_recommend_view_model.dart';
import 'package:culcul/features/home/presentation/hooks/use_home_scroll_sync.dart';
import 'package:culcul/features/home/domain/entities/home_video.dart';
import 'package:culcul/features/home/presentation/widgets/home_layout_spec.dart';
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
    final recommendAsync = ref.watch(homeRecommendProvider);
    final scrollController = useScrollController();
    final refreshController = useManagedEasyRefreshController();

    useHomeScrollSync(ref, scrollController, refreshController, 1);

    return ResponsiveContentContainer(
      maxWidth: AppBreakpoints.homeFeedMaxWidth,
      child: SmartPagingView(
        asyncValue: recommendAsync,
        controller: refreshController,
        onRefresh: ref.read(homeRecommendProvider.notifier).refresh,
        onLoadMore: ref.read(homeRecommendProvider.notifier).loadMore,
        itemCount: () => ref.read(homeRecommendProvider).value?.length ?? 0,
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
        ),
      ),
    );
  }
}

class _RecommendVideoGrid extends StatelessWidget {
  const _RecommendVideoGrid({
    required this.items,
    required this.scrollController,
    required this.layout,
  });

  final List<HomeVideo> items;
  final ScrollController scrollController;
  final HomeGridLayoutSpec layout;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: scrollController,
      cacheExtent: 1500,
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
}
