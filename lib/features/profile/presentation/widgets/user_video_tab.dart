import 'package:culcul/core/utils/format_utils.dart';
import 'package:culcul/core/data/pagination/nested_feed_paging_defaults.dart';
import 'package:culcul/core/data/pagination/pagination_load_gate.dart';
import 'package:culcul/core/data/pagination/scroll_load_trigger.dart';
import 'package:culcul/features/profile/domain/entities/profile_video.dart';
import 'package:culcul/features/profile/state/user_space_videos_view_model.dart';
import 'package:culcul/features/profile/presentation/widgets/profile_navigation_scope.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/ui/widgets/feedback/app_error_widget.dart';
import 'package:culcul/ui/widgets/media/app_network_image_prefetcher.dart';
import 'package:culcul/ui/widgets/media/network_image_prefetch_specs.dart';
import 'package:culcul/ui/assemblies/feed_cards/video_list_card.dart';
import 'package:culcul/ui/assemblies/feed_cards/video_list_skeleton.dart';
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
  static const int _imagePrefetchLimit = 8;
  static const double _coverLogicalWidth = 160;
  static const double _coverLogicalHeight = 100;

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
    final colorScheme = Theme.of(context).colorScheme;

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
              _scheduleCoverPrefetch(context, videos);
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

  void _scheduleCoverPrefetch(BuildContext context, List<ProfileVideo> videos) {
    final pixelRatio = MediaQuery.devicePixelRatioOf(context);
    final specs = buildNetworkImagePrefetchSpecs(
      videos,
      count: _imagePrefetchLimit,
      logicalWidth: _coverLogicalWidth,
      logicalHeight: _coverLogicalHeight,
      pixelRatio: pixelRatio,
      imageUrl: (video) => video.pic,
    );
    final prefetchKey = [
      widget.mid,
      _order,
      pixelRatio.toStringAsFixed(2),
      for (final spec in specs) spec.url,
    ].join('|');
    if (_lastPrefetchKey == prefetchKey) {
      return;
    }
    _lastPrefetchKey = prefetchKey;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || _lastPrefetchKey != prefetchKey) {
        return;
      }
      AppNetworkImagePrefetcher.prefetch(context, specs: specs, limit: specs.length);
    });
  }
}

class _SortChip extends StatelessWidget {
  const _SortChip({
    required this.label,
    required this.selected,
    required this.onSelected,
  });

  final String label;
  final bool selected;
  final ValueChanged<bool> onSelected;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return GestureDetector(
      onTap: () => onSelected(!selected),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: selected
              ? colorScheme.primary.withValues(alpha: 0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: selected
                ? Colors.transparent
                : colorScheme.outlineVariant.withValues(alpha: 0.5),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 13,
            color: selected ? colorScheme.primary : colorScheme.onSurfaceVariant,
            fontWeight: selected ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
