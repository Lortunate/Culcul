import 'package:culcul/app/router/app_routes.dart';
import 'package:culcul/data/models/video/video_model.dart';
import 'package:culcul/features/home/controllers/home_popular_controller.dart';
import 'package:culcul/features/home/presentation/controllers/home_scroll_controller.dart';
import 'package:culcul/features/home/presentation/widgets/popular_video_card.dart';
import 'package:culcul/ui/widgets/skeletons/page_skeletons.dart';
import 'package:culcul/ui/widgets/skeletons/video_list_skeleton.dart';
import 'package:culcul/ui/widgets/smart_paging_view.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

const _popularPadding = EdgeInsets.all(4);

class PopularView extends HookConsumerWidget {
  const PopularView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useAutomaticKeepAlive();

    final popularAsync = ref.watch(homePopularProvider);
    final scrollController = useScrollController();
    final refreshController = useMemoized(() => EasyRefreshController());

    useHomeScrollController(ref, scrollController, refreshController, 2);

    return SmartPagingView(
      provider: homePopularProvider,
      asyncValue: popularAsync,
      controller: refreshController,
      onRefresh: ref.read(homePopularProvider.notifier).refresh,
      onLoadMore: ref.read(homePopularProvider.notifier).loadMore,
      skeleton: const ListSkeletonView(
        itemSkeleton: VideoListSkeleton(),
        padding: _popularPadding,
      ),
      builder: (context, items) =>
          _PopularVideoList(items: items, scrollController: scrollController),
    );
  }
}

class _PopularVideoList extends StatelessWidget {
  const _PopularVideoList({required this.items, required this.scrollController});

  final List<VideoModel> items;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: scrollController,
      cacheExtent: 1500,
      slivers: [
        SliverPadding(
          padding: _popularPadding,
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
            separatorBuilder: (_, _) => const SizedBox(height: 4),
          ),
        ),
      ],
    );
  }
}
