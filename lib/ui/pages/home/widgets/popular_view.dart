import 'package:culcul/core/router/router.dart';
import 'package:culcul/providers/home/home_popular_provider.dart';
import 'package:culcul/ui/pages/home/logic/home_scroll_manager.dart';
import 'package:culcul/ui/pages/home/widgets/popular_skeleton.dart';
import 'package:culcul/ui/pages/home/widgets/popular_video_card.dart';
import 'package:culcul/ui/widgets/smart_paging_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:easy_refresh/easy_refresh.dart';

class PopularView extends HookConsumerWidget {
  const PopularView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useAutomaticKeepAlive();
    final popularAsync = ref.watch(homePopularProvider);
    final scrollController = useScrollController();
    final refreshController = useMemoized(() => EasyRefreshController());

    useHomeScrollManager(ref, scrollController, refreshController, 2);

    return SmartPagingView(
      provider: homePopularProvider,
      asyncValue: popularAsync,
      controller: refreshController,
      onRefresh: () => ref.read(homePopularProvider.notifier).refresh(),
      onLoadMore: () => ref.read(homePopularProvider.notifier).loadMore(),
      skeleton: const PopularSkeleton(),
      builder: (context, items) => CustomScrollView(
        controller: scrollController,
        cacheExtent: 1500,
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                final video = items[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: PopularVideoCard(
                    key: ValueKey('popular_v_${video.bvid}_$index'),
                    video: video,
                    onTap: () =>
                        VideoDetailRoute(bvid: video.bvid).push(context),
                  ),
                );
              }, childCount: items.length),
            ),
          ),
        ],
      ),
    );
  }
}
