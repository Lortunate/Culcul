import 'package:culcul/core/router/router.dart';
import 'package:culcul/data/models/video/video_model.dart';
import 'package:culcul/features/profile/controllers/user_space_controller.dart';
import 'package:culcul/features/profile/controllers/user_space_videos_controller.dart';
import 'package:culcul/ui/widgets/app_error_widget.dart';
import 'package:culcul/ui/widgets/video_card.dart';
import 'package:culcul/ui/widgets/skeletons/video_card_skeleton.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class RecentVideoSection extends ConsumerWidget {
  final int mid;
  final ValueChanged<int>? onSwitchToTab;

  const RecentVideoSection({super.key, required this.mid, this.onSwitchToTab});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final videosAsync = ref.watch(
      userSpaceVideosProvider(mid, order: 'pubdate'),
    );
    final profileAsync = ref.watch(userSpaceProvider(mid.toString()));
    final videoCount = profileAsync.asData?.value.videosCount ?? 0;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return videosAsync.when(
      data: (videos) {
        if (videos.isEmpty) {
          return const SliverToBoxAdapter(
            child: SizedBox(height: 100, child: Center(child: Text('暂无内容'))),
          );
        }
        return SliverMainAxisGroup(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                child: Row(
                  children: [
                    Text(
                      '视频 $videoCount',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: colorScheme.onSurface,
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () => onSwitchToTab?.call(2),
                      behavior: HitTestBehavior.opaque,
                      child: Row(
                        children: [
                          Text(
                            '查看更多',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: colorScheme.onSurfaceVariant,
                            ),
                          ),
                          const SizedBox(width: 2),
                          Icon(
                            Icons.chevron_right_rounded,
                            size: 16,
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 1.1,
                ),
                delegate: SliverChildBuilderDelegate((context, index) {
                  final spaceVideo = videos[index];
                  final video = VideoModel(
                    bvid: spaceVideo.bvid,
                    title: spaceVideo.title,
                    pic: spaceVideo.pic,
                    owner: spaceVideo.owner,
                    stat: spaceVideo.stat,
                    duration: spaceVideo.duration,
                    pubDate: spaceVideo.pubDate,
                    desc: spaceVideo.desc,
                    rcmdReason: spaceVideo.reason,
                  );
                  return VideoCard(
                    video: video,
                    onTap: () =>
                        VideoDetailRoute(bvid: video.bvid).push(context),
                    showAuthor: false,
                    showDescription: false,
                  );
                }, childCount: videos.length > 6 ? 6 : videos.length),
              ),
            ),
          ],
        );
      },
      error: (err, stack) => SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: AppErrorWidget(
            error: err,
            onRetry: () =>
                ref.refresh(userSpaceVideosProvider(mid, order: 'pubdate')),
          ),
        ),
      ),
      loading: () => SliverPadding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        sliver: SliverGrid(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 0.94,
          ),
          delegate: SliverChildBuilderDelegate(
            (context, index) => const VideoCardSkeleton(),
            childCount: 4,
          ),
        ),
      ),
    );
  }
}
