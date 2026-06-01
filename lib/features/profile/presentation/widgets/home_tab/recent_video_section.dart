import 'package:culcul/features/profile/state/user_space_view_model.dart';
import 'package:culcul/features/profile/state/user_space_videos_view_model.dart';
import 'package:culcul/features/profile/presentation/widgets/home_tab/section_header.dart';
import 'package:culcul/features/profile/presentation/widgets/profile_navigation_scope.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/ui/widgets/feedback/app_error_widget.dart';
import 'package:culcul/ui/widgets/media/app_network_image_prefetcher.dart';
import 'package:culcul/ui/widgets/media/network_image_prefetch_specs.dart';
import 'package:culcul/ui/assemblies/feed_cards/video_card.dart';
import 'package:culcul/ui/assemblies/feed_cards/video_card_skeleton.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class RecentVideoSection extends ConsumerWidget {
  final int mid;
  final ValueChanged<int>? onSwitchToTab;

  static const int _maxDisplayCount = 6;
  static const double _gridSpacing = 8.0;
  static const int _crossAxisCount = 2;
  static const double _coverAspectRatio = 16 / 10;

  const RecentVideoSection({super.key, required this.mid, this.onSwitchToTab});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final videosAsync = ref.watch(userSpaceVideosProvider(mid));
    final profileAsync = ref.watch(userSpaceProvider(mid.toString()));
    final videoCount = profileAsync.asData?.value.videosCount ?? 0;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return videosAsync.when(
      data: (videos) {
        if (videos.isEmpty) {
          return SliverToBoxAdapter(
            child: SizedBox(
              height: 100,
              child: Center(child: Text(Translations.of(context).common.no_content)),
            ),
          );
        }
        final screenWidth = MediaQuery.sizeOf(context).width;
        final itemWidth = (screenWidth - (_gridSpacing * 2) - 32) / _crossAxisCount;
        final pixelRatio = MediaQuery.devicePixelRatioOf(context);
        AppNetworkImagePrefetcher.prefetch(
          context,
          specs: buildNetworkImagePrefetchSpecs(
            videos,
            count: _maxDisplayCount,
            logicalWidth: itemWidth,
            aspectRatio: _coverAspectRatio,
            pixelRatio: pixelRatio,
            imageUrl: (video) => video.pic,
          ),
        );
        return SliverMainAxisGroup(
          slivers: [
            SliverToBoxAdapter(
              child: SectionHeader(
                title: t.profile.home_tab.recent_videos(count: videoCount.toString()),
                trailing: GestureDetector(
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
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: _gridSpacing),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: _crossAxisCount,
                  mainAxisSpacing: _gridSpacing,
                  crossAxisSpacing: _gridSpacing,
                  childAspectRatio: 1.1,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
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
                      onTap: () =>
                          ProfileNavigationScope.of(context).onOpenVideo(spaceVideo.bvid),
                      showAuthor: false,
                    );
                  },
                  childCount: videos.length > _maxDisplayCount
                      ? _maxDisplayCount
                      : videos.length,
                ),
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
            stackTrace: stack,
            onRetry: () => ref.refresh(userSpaceVideosProvider(mid)),
          ),
        ),
      ),
      loading: () => SliverPadding(
        padding: const EdgeInsets.symmetric(horizontal: _gridSpacing),
        sliver: SliverGrid(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: _crossAxisCount,
            mainAxisSpacing: _gridSpacing,
            crossAxisSpacing: _gridSpacing,
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
