import 'package:culcul/core/utils/format_utils.dart';
import 'package:culcul/app/router/app_routes.dart';
import 'package:culcul/features/profile/presentation/view_models/user_space_videos_view_model.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/ui/widgets/app_error_widget.dart';
import 'package:culcul/ui/widgets/skeletons/video_list_skeleton.dart';
import 'package:culcul/ui/widgets/video_list_card.dart';
import 'package:culcul/ui/widgets/icon_text.dart';
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

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final t = Translations.of(context);
    final videosAsync = ref.watch(userSpaceVideosProvider(widget.mid, order: _order));
    final notifier = ref.read(
      userSpaceVideosProvider(widget.mid, order: _order).notifier,
    );
    final colorScheme = Theme.of(context).colorScheme;

    return CustomScrollView(
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
                    if (val) setState(() => _order = 'pubdate');
                  },
                ),
                const SizedBox(width: 12),
                _SortChip(
                  label: t.search.filter.sort_click,
                  selected: _order == 'click',
                  onSelected: (val) {
                    if (val) setState(() => _order = 'click');
                  },
                ),
                const SizedBox(width: 12),
                _SortChip(
                  label: t.search.filter.sort_favorite,
                  selected: _order == 'stow',
                  onSelected: (val) {
                    if (val) setState(() => _order = 'stow');
                  },
                ),
              ],
            ),
          ),
        ),
        videosAsync.when(
          data: (videos) {
            if (videos.isEmpty) {
              return SliverFillRemaining(child: Center(child: Text(t.common.no_content)));
            }
            return SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                if (index == videos.length) {
                  notifier.loadMore();
                  return const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
                final spaceVideo = videos[index];
                return Column(
                  children: [
                    VideoListCard(
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
              }, childCount: videos.length + 1),
            );
          },
          error: (err, stack) => SliverFillRemaining(
            child: AppErrorWidget(
              error: err,
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
    );
  }
}

class _SortChip extends StatelessWidget {
  final String label;
  final bool selected;
  final ValueChanged<bool> onSelected;

  const _SortChip({
    required this.label,
    required this.selected,
    required this.onSelected,
  });

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
            width: 1,
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
