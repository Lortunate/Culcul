import 'package:culcul/core/utils/format_utils.dart';
import 'package:culcul/core/data/pagination/nested_feed_paging_defaults.dart';
import 'package:culcul/core/data/pagination/pagination_load_gate.dart';
import 'package:culcul/core/data/pagination/scroll_load_trigger.dart';
import 'package:culcul/features/profile/state/user_space_videos_view_model.dart';
import 'package:culcul/features/profile/presentation/widgets/profile_navigation_scope.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/ui/widgets/feedback/app_error_widget.dart';
import 'package:culcul/ui/widgets/media/app_network_image_prefetcher.dart';
import 'package:culcul/ui/widgets/media/network_image_prefetch_specs.dart';
import 'package:culcul/ui/widgets/cards/video_list_card.dart';
import 'package:culcul/ui/widgets/cards/video_list_skeleton.dart';
import 'package:culcul/ui/widgets/text/icon_text.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

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
  String? _lastPrefetchKey;

  @override
  bool get wantKeepAlive => true;

  @override
  void didUpdateWidget(covariant UserVideoTab oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.mid != widget.mid) {
      _loadGate.reset();
      _lastPrefetchKey = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final t = Translations.of(context);
    final videosAsync = ref.watch(userSpaceVideosProvider(widget.mid, order: _order));
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final sortOptions = <({String label, String order})>[
      (label: t.search.filter.sort_newest, order: 'pubdate'),
      (label: t.search.filter.sort_click, order: 'click'),
      (label: t.search.filter.sort_favorite, order: 'stow'),
    ];

    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        final provider = userSpaceVideosProvider(widget.mid, order: _order);
        final notifier = ref.read(provider.notifier);
        return ScrollLoadTrigger.triggerOnScrollNotificationWithGate(
          notification: notification,
          extentAfterThreshold: profileNestedFeedExtentAfterThreshold,
          viewportFactor: 1.15,
          maxThreshold: 840,
          gate: _loadGate,
          hasMore: notifier.hasMore,
          task: notifier.loadMore,
          itemCount: () => ref.read(provider).asData?.value.length ?? 0,
          hasMoreAfter: () => notifier.hasMore,
          source: 'profile.user_video_tab',
          onlyOnScrollEnd: profileNestedFeedOnlyOnScrollEnd,
        );
      },
      child: CustomScrollView(
        cacheExtent: profileNestedFeedCacheExtent,
        key: PageStorageKey<String>('user_video_tab_${widget.mid}'),
        slivers: [
          SliverOverlapInjector(
            handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
          ),
          SliverToBoxAdapter(
            child: Container(
              color: theme.scaffoldBackgroundColor,
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
              child: Row(
                children: [
                  for (var index = 0; index < sortOptions.length; index++) ...[
                    if (index > 0) const SizedBox(width: 12),
                    GestureDetector(
                      onTap: () {
                        final order = sortOptions[index].order;
                        if (_order == order) {
                          return;
                        }
                        _loadGate.reset();
                        setState(() => _order = order);
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                        decoration: BoxDecoration(
                          color: _order == sortOptions[index].order
                              ? colorScheme.primary.withValues(alpha: 0.1)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: _order == sortOptions[index].order
                                ? Colors.transparent
                                : colorScheme.outlineVariant.withValues(alpha: 0.5),
                          ),
                        ),
                        child: Text(
                          sortOptions[index].label,
                          style: TextStyle(
                            fontSize: 13,
                            color: _order == sortOptions[index].order
                                ? colorScheme.primary
                                : colorScheme.onSurfaceVariant,
                            fontWeight: _order == sortOptions[index].order
                                ? FontWeight.w600
                                : FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                  ],
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
              final specs = buildNetworkImagePrefetchSpecs(
                videos,
                count: 8,
                logicalWidth: 160,
                logicalHeight: 100,
                pixelRatio: pixelRatio,
                imageUrl: (video) => video.pic,
              );
              final prefetchKey = [
                widget.mid,
                _order,
                pixelRatio.toStringAsFixed(2),
                for (final spec in specs) spec.url,
              ].join('|');
              if (_lastPrefetchKey != prefetchKey) {
                _lastPrefetchKey = prefetchKey;

                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (!mounted || _lastPrefetchKey != prefetchKey) {
                    return;
                  }
                  AppNetworkImagePrefetcher.prefetch(
                    context,
                    specs: specs,
                    limit: specs.length,
                  );
                });
              }
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
                          ProfileNavigationScope.of(context).onOpenVideo(spaceVideo.bvid);
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
