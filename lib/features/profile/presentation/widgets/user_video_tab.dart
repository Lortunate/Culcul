import 'package:culcul/core/utils/format_utils.dart';
import 'package:culcul/app/router/app_routes.dart';
import 'package:culcul/core/data/pagination/pagination_load_gate.dart';
import 'package:culcul/core/data/pagination/scroll_load_trigger.dart';
import 'package:culcul/features/profile/presentation/view_models/user_space_videos_view_model.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/ui/widgets/app_error_widget.dart';
import 'package:culcul/ui/widgets/app_network_image_prefetcher.dart';
import 'package:culcul/ui/widgets/skeletons/video_list_skeleton.dart';
import 'package:culcul/ui/widgets/video_list_card.dart';
import 'package:culcul/ui/widgets/icon_text.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

part 'user_video_tab.sort_chip.dart';

class UserVideoTab extends ConsumerStatefulWidget {
  final int mid;
  const UserVideoTab({super.key, required this.mid});

  @override
  ConsumerState<UserVideoTab> createState() => _UserVideoTabState();
}

class _UserVideoTabState extends ConsumerState<UserVideoTab>
    with AutomaticKeepAliveClientMixin {
  String _order = 'pubdate'; // pubdate (latest), click (popular), stow (most fav)
  final PaginationLoadGate _loadGate = PaginationLoadGate();

  @override
  bool get wantKeepAlive => true;

  @override
  void didUpdateWidget(covariant UserVideoTab oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.mid != widget.mid) {
      _loadGate.reset();
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final t = Translations.of(context);
    final videosAsync = ref.watch(userSpaceVideosProvider(widget.mid, order: _order));
    final colorScheme = Theme.of(context).colorScheme;

    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        final provider = userSpaceVideosProvider(widget.mid, order: _order);
        final notifier = ref.read(provider.notifier);
        return ScrollLoadTrigger.triggerOnScrollNotificationWithGate(
          notification: notification,
          extentAfterThreshold: 360,
          viewportFactor: 1.15,
          maxThreshold: 840,
          gate: _loadGate,
          hasMore: notifier.hasMore,
          task: notifier.loadMore,
          itemCount: () => ref.read(provider).asData?.value.length ?? 0,
          hasMoreAfter: () => notifier.hasMore,
          source: 'profile.user_video_tab',
          onlyOnScrollEnd: false,
        );
      },
      child: CustomScrollView(
        key: PageStorageKey<String>('user_video_tab_${widget.mid}'),
        cacheExtent: 560,
        slivers: [
          SliverOverlapInjector(
            handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
          ),
          SliverToBoxAdapter(
            child: Container(
              color: Theme.of(context).scaffoldBackgroundColor,
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
              child: Row(
                children: [
                  _SortChip(
                    label: t.search.filter.sort_newest,
                    selected: _order == 'pubdate',
                    onSelected: (val) {
                      if (val) {
                        _loadGate.reset();
                        setState(() => _order = 'pubdate');
                      }
                    },
                  ),
                  const SizedBox(width: 12),
                  _SortChip(
                    label: t.search.filter.sort_click,
                    selected: _order == 'click',
                    onSelected: (val) {
                      if (val) {
                        _loadGate.reset();
                        setState(() => _order = 'click');
                      }
                    },
                  ),
                  const SizedBox(width: 12),
                  _SortChip(
                    label: t.search.filter.sort_favorite,
                    selected: _order == 'stow',
                    onSelected: (val) {
                      if (val) {
                        _loadGate.reset();
                        setState(() => _order = 'stow');
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
          videosAsync.when(
            data: (videos) {
              if (videos.isEmpty) {
                return SliverFillRemaining(
                  child: Center(child: Text(t.common.no_content)),
                );
              }
              final pixelRatio = MediaQuery.devicePixelRatioOf(context);
              AppNetworkImagePrefetcher.prefetch(
                context,
                specs: videos
                    .map(
                      (video) => NetworkImagePrefetchSpec(
                        url: video.pic,
                        memCacheWidth: (160 * pixelRatio).round(),
                        memCacheHeight: (100 * pixelRatio).round(),
                      ),
                    )
                    .toList(growable: false),
                limit: 8,
              );
              final showLoadingFooter = videosAsync.isLoading && videos.isNotEmpty;
              return SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  if (index >= videos.length) {
                    return const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }
                  final spaceVideo = videos[index];
                  return Column(
                    children: [
                      VideoListCard(
                        key: ValueKey('space_video_${spaceVideo.bvid}_$index'),
                        coverUrl: spaceVideo.pic,
                        title: spaceVideo.title,
                        duration: spaceVideo.duration,
                        showDefaultStats: false,
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        stats: [
                          Text(
                            FormatUtils.formatTimeAgo(spaceVideo.pubDate),
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: colorScheme.outline,
                              fontSize: 11,
                            ),
                          ),
                          const Spacer(),
                          IconText(
                            icon: Icons.play_circle_outline_rounded,
                            text: FormatUtils.formatNumber(spaceVideo.stats.view),
                          ),
                          const SizedBox(width: 4),
                          IconText(
                            icon: Icons.list_alt_rounded,
                            text: FormatUtils.formatNumber(spaceVideo.stats.danmaku),
                          ),
                        ],
                        onTap: () {
                          VideoDetailRoute(bvid: spaceVideo.bvid).push(context);
                        },
                      ),
                      if (index < videos.length - 1)
                        Divider(
                          height: 1,
                          thickness: 0.5,
                          indent: 16,
                          endIndent: 16,
                          color: colorScheme.outlineVariant.withValues(alpha: 0.2),
                        ),
                    ],
                  );
                }, childCount: videos.length + (showLoadingFooter ? 1 : 0)),
              );
            },
            error: (err, stack) => SliverFillRemaining(
              child: AppErrorWidget(
                error: err,
                stackTrace: stack,
                onRetry: () =>
                    ref.refresh(userSpaceVideosProvider(widget.mid, order: _order)),
              ),
            ),
            loading: () => SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => const VideoListSkeleton(),
                childCount: 10,
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 24)),
        ],
      ),
    );
  }
}
