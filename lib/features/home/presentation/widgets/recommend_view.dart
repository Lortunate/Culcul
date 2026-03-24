import 'package:culcul/app/router/app_routes.dart';
import 'package:culcul/data/models/video/video_model.dart';
import 'package:culcul/features/home/controllers/home_recommend_controller.dart';
import 'package:culcul/features/home/presentation/logic/home_scroll_manager.dart';
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

    useHomeScrollManager(ref, scrollController, refreshController, 1);

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

  final List<VideoModel> items;
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
                video: video,
                onTap: () => VideoDetailRoute(bvid: video.bvid).push(context),
              );
            },
          ),
        ),
      ],
    );
  }
}
