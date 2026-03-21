import 'package:culcul/app/router/app_routes.dart';
import 'package:culcul/features/home/controllers/home_popular_controller.dart';
import 'package:culcul/features/home/presentation/logic/home_scroll_manager.dart';
import 'package:culcul/features/home/presentation/widgets/popular_video_card.dart';
import 'package:culcul/ui/widgets/skeletons/page_skeletons.dart';
import 'package:culcul/ui/widgets/skeletons/video_list_skeleton.dart';
import 'package:culcul/ui/widgets/smart_paging_view.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PopularView extends HookConsumerWidget {
  const PopularView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useAutomaticKeepAlive();

    final popularAsync = ref.watch(homePopularProvider);
    final scrollController = useScrollController();
    final refreshController = useMemoized(() => EasyRefreshController());

    useHomeScrollManager(ref, scrollController, refreshController, 2);

    const padding = EdgeInsets.all(4);

    return SmartPagingView(
      provider: homePopularProvider,
      asyncValue: popularAsync,
      controller: refreshController,
      onRefresh: ref.read(homePopularProvider.notifier).refresh,
      onLoadMore: ref.read(homePopularProvider.notifier).loadMore,
      skeleton: const ListSkeletonView(
        itemSkeleton: VideoListSkeleton(),
        padding: padding,
      ),
      builder: (context, items) => CustomScrollView(
        controller: scrollController,
        cacheExtent: 1500,
        slivers: [
          SliverPadding(
            padding: padding,
            sliver: SliverList.separated(
              itemCount: items.length,
              itemBuilder: (context, index) {
                final video = items[index];
                return PopularVideoCard(
                  key: ValueKey('popular_v_${video.bvid}_$index'),
                  video: video,
                  onTap: () => VideoDetailRoute(bvid: video.bvid).push(context),
                );
              },
              separatorBuilder: (context, index) => const SizedBox(height: 4),
            ),
          ),
        ],
      ),
    );
  }
}
