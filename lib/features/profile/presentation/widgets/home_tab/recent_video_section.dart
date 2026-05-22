import 'package:culcul/features/profile/presentation/view_models/user_space_view_model.dart';
import 'package:culcul/features/profile/presentation/view_models/user_space_videos_view_model.dart';
import 'package:culcul/features/profile/presentation/widgets/profile_navigation_scope.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/features/profile/domain/entities/profile_video.dart';
import 'package:culcul/ui/widgets/feedback/app_error_widget.dart';
import 'package:culcul/ui/widgets/media/app_network_image_prefetcher.dart';
import 'package:culcul/ui/assemblies/feed_cards/video_card.dart';
import 'package:culcul/ui/assemblies/feed_cards/video_card_skeleton.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

part 'recent_video_section.states.dart';

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
    final videosAsync = ref.watch(userSpaceVideosProvider(mid));
    final profileAsync = ref.watch(userSpaceProvider(mid.toString()));
    final videoCount = profileAsync.asData?.value.videosCount ?? 0;

    return videosAsync.when(
      data: (videos) {
        if (videos.isEmpty) {
          return const _EmptyState();
        }
        final screenWidth = MediaQuery.sizeOf(context).width;
        final itemWidth = (screenWidth - (_gridSpacing * 2) - 32) / _crossAxisCount;
        final pixelRatio = MediaQuery.devicePixelRatioOf(context);
        AppNetworkImagePrefetcher.prefetch(
          context,
          specs: videos
              .take(_maxDisplayCount)
              .map(
                (video) => NetworkImagePrefetchSpec(
                  url: video.pic,
                  memCacheWidth: (itemWidth * pixelRatio).round(),
                  memCacheHeight: (itemWidth / (16 / 10) * pixelRatio).round(),
                ),
              )
              .toList(growable: false),
        );
        return SliverMainAxisGroup(
          slivers: [
            _SectionHeader(videoCount: videoCount, onSwitchToTab: onSwitchToTab),
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
        stackTrace: stack,
        onRetry: () => ref.refresh(userSpaceVideosProvider(mid)),
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

  const _SectionHeader({required this.videoCount, this.onSwitchToTab});

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
              t.profile.home_tab.recent_videos(count: videoCount.toString()),
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
                    t.profile.home_tab.view_more,
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
  final List<ProfileVideo> videos;
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
        delegate: SliverChildBuilderDelegate((context, index) {
          final spaceVideo = videos[index];
          return VideoCard(
            bvid: spaceVideo.bvid,
            title: spaceVideo.title,
            coverUrl: spaceVideo.pic,
            author: spaceVideo.owner.name,
            description: spaceVideo.desc,
            duration: spaceVideo.duration,
            viewCount: spaceVideo.stats.view,
            danmakuCount: spaceVideo.stats.danmaku,
            reason: spaceVideo.reason,
            onTap: () => ProfileNavigationScope.of(context).onOpenVideo(spaceVideo.bvid),
            showAuthor: false,
          );
        }, childCount: displayCount),
      ),
    );
  }
}
