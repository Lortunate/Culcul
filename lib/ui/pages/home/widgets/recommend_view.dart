import 'package:culcul/core/router/router.dart';
import 'package:culcul/providers/home/home_recommend_provider.dart';
import 'package:culcul/ui/pages/home/logic/home_scroll_manager.dart';
import 'package:culcul/ui/pages/home/widgets/recommend_skeleton.dart';
import 'package:culcul/ui/widgets/index.dart';
import 'package:culcul/ui/widgets/smart_paging_view.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

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
      onRefresh: () => ref.read(homeRecommendProvider.notifier).refresh(),
      onLoadMore: () => ref.read(homeRecommendProvider.notifier).loadMore(),
      skeleton: const RecommendSkeleton(),
      builder: (context, items) => CustomScrollView(
        controller: scrollController,
        cacheExtent: 1500,
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(8, 8, 8, 12),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                childAspectRatio: 0.88,
              ),
              delegate: SliverChildBuilderDelegate((context, index) {
                final video = items[index];
                return VideoCard(
                  key: ValueKey('recommend_v_${video.bvid}_$index'),
                  video: video,
                  onTap: () => VideoDetailRoute(bvid: video.bvid).push(context),
                );
              }, childCount: items.length),
            ),
          ),
        ],
      ),
    );
  }
}
