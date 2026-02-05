import 'package:culcul/core/utils/format_utils.dart';
import 'package:culcul/core/router/router.dart';
import 'package:culcul/providers/user_space/user_space_videos_provider.dart';
import 'package:culcul/ui/widgets/app_shimmer.dart';
import 'package:culcul/ui/widgets/skeletons/video_list_skeleton.dart';
import 'package:culcul/ui/widgets/video_list_card.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class UserVideoTab extends ConsumerStatefulWidget {
  final int mid;
  const UserVideoTab({super.key, required this.mid});

  @override
  ConsumerState<UserVideoTab> createState() => _UserVideoTabState();
}

class _UserVideoTabState extends ConsumerState<UserVideoTab> {
  String _order = 'pubdate'; // pubdate (latest), click (popular), stow (most fav)

  @override
  Widget build(BuildContext context) {
    final videosAsync = ref.watch(userSpaceVideosProvider(widget.mid, order: _order));
    final notifier = ref.read(userSpaceVideosProvider(widget.mid, order: _order).notifier);

    return CustomScrollView(
      key: PageStorageKey<String>('user_video_tab_${widget.mid}'),
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                _SortChip(
                  label: '最新发布',
                  selected: _order == 'pubdate',
                  onSelected: (val) {
                    if (val) setState(() => _order = 'pubdate');
                  },
                ),
                const SizedBox(width: 8),
                _SortChip(
                  label: '最多播放',
                  selected: _order == 'click',
                  onSelected: (val) {
                    if (val) setState(() => _order = 'click');
                  },
                ),
                const SizedBox(width: 8),
                _SortChip(
                  label: '最多收藏',
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
              return const SliverFillRemaining(
                child: Center(child: Text('暂无视频')),
              );
            }
            return SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  if (index == videos.length) {
                    // Load more trigger
                    notifier.loadMore();
                    return const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }
                  final video = videos[index];
                  // Map UserSpaceVideoModel to VideoModel or similar for VideoListCard
                  // VideoListCard expects VideoModel. UserSpaceVideoModel is similar but distinct.
                  // We might need to map it or create a new card.
                  // Ideally we reuse VideoListCard. Let's see if we can map.
                  
                  return VideoListCard(
                    coverUrl: video.pic,
                    title: video.title,
                    duration: video.duration,
                    viewCount: video.stat.view,
                    danmakuCount: video.stat.danmaku,
                    author: Row(
                      children: [
                        const Icon(Icons.access_time_rounded, size: 14, color: Colors.grey),
                        const SizedBox(width: 4),
                        Text(
                          FormatUtils.formatTimestamp(video.pubDate),
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey),
                        ),
                      ],
                    ),
                    onTap: () {
                      VideoDetailRoute(bvid: video.bvid).push(context);
                    },
                  );
                },
                childCount: videos.length + 1,
              ),
            );
          },
          error: (err, stack) => SliverFillRemaining(
            child: Center(child: Text('Error: $err')),
          ),
          loading: () => SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => const AppShimmer(
                child: VideoListSkeleton(),
              ),
              childCount: 10,
            ),
          ),
        ),
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
    return FilterChip(
      label: Text(label),
      selected: selected,
      onSelected: onSelected,
      showCheckmark: false,
      labelStyle: TextStyle(
        fontSize: 12,
        color: selected ? Theme.of(context).colorScheme.primary : null,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    );
  }
}
