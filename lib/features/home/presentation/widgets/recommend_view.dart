import 'package:culcul/app/router/app_routes.dart';
import 'package:culcul/features/home/presentation/view_models/home_recommend_view_model.dart';
import 'package:culcul/features/home/presentation/widgets/hooks/use_home_scroll_sync.dart';
import 'package:culcul/features/home/domain/entities/home_video.dart';
import 'package:culcul/ui/widgets/skeletons/page_skeletons.dart';
import 'package:culcul/ui/widgets/skeletons/video_card_skeleton.dart';
import 'package:culcul/ui/widgets/smart_paging_view.dart';
import 'package:culcul/ui/widgets/video_card.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

const _recommendPadding = EdgeInsets.all(8);
const _recommendGridDelegate = SliverGridDelegateWithFixedCrossAxisCount(
  crossAxisCount: 2,
  mainAxisSpacing: 6,
  crossAxisSpacing: 6,
  childAspectRatio: 0.94,
);

class RecommendView extends HookConsumerWidget {
  const RecommendView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useAutomaticKeepAlive();

    final recommendAsync = ref.watch(homeRecommendProvider);
    final scrollController = useScrollController();
    final refreshController = useMemoized(() => EasyRefreshController());

    useHomeScrollSync(ref, scrollController, refreshController, 1);

    return SmartPagingView(
      provider: homeRecommendProvider,
      asyncValue: recommendAsync,
      controller: refreshController,
      onRefresh: ref.read(homeRecommendProvider.notifier).refresh,
      onLoadMore: ref.read(homeRecommendProvider.notifier).loadMore,
      skeleton: const GridSkeletonView(
        itemSkeleton: VideoCardSkeleton(),
        gridDelegate: _recommendGridDelegate,
        padding: _recommendPadding,
      ),
      builder: (context, items) =>
          _RecommendVideoGrid(items: items, scrollController: scrollController),
    );
  }
}

class _RecommendVideoGrid extends StatelessWidget {
  const _RecommendVideoGrid({required this.items, required this.scrollController});

  final List<HomeVideo> items;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: scrollController,
      cacheExtent: 1500,
      slivers: [
        SliverPadding(
          padding: _recommendPadding,
          sliver: SliverGrid.builder(
            gridDelegate: _recommendGridDelegate,
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
