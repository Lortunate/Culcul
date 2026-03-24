import 'package:culcul/app/router/app_routes.dart';
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

  static const int _maxDisplayCount = 6;
  static const double _gridSpacing = 8.0;
  static const int _crossAxisCount = 2;
  static const double _videoAspectRatio = 1.1;
  static const double _skeletonAspectRatio = 0.94;

  const RecentVideoSection({super.key, required this.mid, this.onSwitchToTab});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final videosAsync = ref.watch(userSpaceVideosProvider(mid, order: 'pubdate'));
    final profileAsync = ref.watch(userSpaceProvider(mid.toString()));
    final videoCount = profileAsync.asData?.value.videosCount ?? 0;

    return videosAsync.when(
      data: (videos) {
        if (videos.isEmpty) {
          return const _EmptyState();
        }
        return SliverMainAxisGroup(
          slivers: [
            _SectionHeader(
              videoCount: videoCount,
              onSwitchToTab: onSwitchToTab,
            ),
            _VideoGrid(
              videos: videos,
              maxItems: _maxDisplayCount,
              spacing: _gridSpacing,
              crossAxisCount: _crossAxisCount,
              aspectRatio: _videoAspectRatio,
            ),
          ],
        );
      },
      error: (err, stack) => _ErrorState(
        error: err,
        onRetry: () => ref.refresh(userSpaceVideosProvider(mid, order: 'pubdate')),
      ),
      loading: () => const _LoadingGrid(
        spacing: _gridSpacing,
        crossAxisCount: _crossAxisCount,
        aspectRatio: _skeletonAspectRatio,
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final int videoCount;
  final ValueChanged<int>? onSwitchToTab;

  const _SectionHeader({
    required this.videoCount,
    this.onSwitchToTab,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
    );
  }
}

class _VideoGrid extends StatelessWidget {
  final List<dynamic> videos;
  final int maxItems;
  final double spacing;
  final int crossAxisCount;
  final double aspectRatio;

  const _VideoGrid({
    required this.videos,
    required this.maxItems,
    required this.spacing,
    required this.crossAxisCount,
    required this.aspectRatio,
  });

  @override
  Widget build(BuildContext context) {
    final displayCount = videos.length > maxItems ? maxItems : videos.length;

    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: spacing),
      sliver: SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          mainAxisSpacing: spacing,
          crossAxisSpacing: spacing,
          childAspectRatio: aspectRatio,
        ),
        delegate: SliverChildBuilderDelegate(
              (context, index) {
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
              onTap: () => VideoDetailRoute(bvid: video.bvid).push(context),
              showAuthor: false,
              showDescription: false,
            );
          },
          childCount: displayCount,
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return const SliverToBoxAdapter(
      child: SizedBox(
        height: 100,
        child: Center(
          child: Text('暂无内容'),
        ),
      ),
    );
  }
}

class _ErrorState extends StatelessWidget {
  final Object error;
  final VoidCallback onRetry;

  const _ErrorState({
    required this.error,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: AppErrorWidget(
          error: error,
          onRetry: onRetry,
        ),
      ),
    );
  }
}

class _LoadingGrid extends StatelessWidget {
  final double spacing;
  final int crossAxisCount;
  final double aspectRatio;

  const _LoadingGrid({
    required this.spacing,
    required this.crossAxisCount,
    required this.aspectRatio,
  });

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: spacing),
      sliver: SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          mainAxisSpacing: spacing,
          crossAxisSpacing: spacing,
          childAspectRatio: aspectRatio,
        ),
        delegate: SliverChildBuilderDelegate(
              (context, index) => const VideoCardSkeleton(),
          childCount: 4,
        ),
      ),
    );
  }
}