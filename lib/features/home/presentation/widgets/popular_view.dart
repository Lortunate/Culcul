import 'package:culcul/app/router/app_routes.dart';
import 'package:culcul/core/hooks/use_managed_easy_refresh_controller.dart';
import 'package:culcul/core/responsive/responsive.dart';
import 'package:culcul/features/home/presentation/view_models/home_popular_view_model.dart';
import 'package:culcul/features/home/presentation/hooks/use_home_scroll_sync.dart';
import 'package:culcul/features/home/domain/entities/home_video.dart';
import 'package:culcul/features/home/presentation/widgets/home_layout_spec.dart';
import 'package:culcul/features/home/presentation/widgets/popular_video_card.dart';
import 'package:culcul/ui/widgets/skeletons/page_skeletons.dart';
import 'package:culcul/ui/widgets/skeletons/video_list_skeleton.dart';
import 'package:culcul/ui/widgets/smart_paging_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PopularView extends HookConsumerWidget {
  const PopularView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useAutomaticKeepAlive();

    final layout = HomePopularLayoutSpec.fromContext(context);
    final popularAsync = ref.watch(homePopularProvider);
    final scrollController = useScrollController();
    final refreshController = useManagedEasyRefreshController();

    useHomeScrollSync(ref, scrollController, refreshController, 2);

    return ResponsiveContentContainer(
      maxWidth: AppBreakpoints.homePopularMaxWidth,
      child: SmartPagingView(
        asyncValue: popularAsync,
        controller: refreshController,
        onRefresh: ref.read(homePopularProvider.notifier).refresh,
        onLoadMore: ref.read(homePopularProvider.notifier).loadMore,
        itemCount: () => ref.read(homePopularProvider).value?.length ?? 0,
        skeleton: ListSkeletonView(
          itemSkeleton: const VideoListSkeleton(),
          padding: layout.padding,
          itemPadding: layout.skeletonItemPadding,
        ),
        builder: (context, items) => _PopularVideoList(
          items: items,
          scrollController: scrollController,
          layout: layout,
        ),
      ),
    );
  }
}

class _PopularVideoList extends StatelessWidget {
  const _PopularVideoList({
    required this.items,
    required this.scrollController,
    required this.layout,
  });

  final List<HomeVideo> items;
  final ScrollController scrollController;
  final HomePopularLayoutSpec layout;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: scrollController,
      cacheExtent: 1500,
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
