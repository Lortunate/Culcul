import 'package:culcul/core/utils/format_utils.dart';
import 'package:culcul/core/router/router.dart';
import 'package:culcul/data/models/user/user_space_video_model.dart';
import 'package:culcul/providers/user_space/user_space_extras_provider.dart';
import 'package:culcul/providers/user_space/user_space_videos_provider.dart';
import 'package:culcul/ui/widgets/app_shimmer.dart';
import 'package:culcul/ui/widgets/skeletons/video_list_skeleton.dart';
import 'package:culcul/ui/widgets/video_thumbnail.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class UserHomeTab extends ConsumerWidget {
  final int mid;
  const UserHomeTab({super.key, required this.mid});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stickyAsync = ref.watch(userStickyVideoProvider(mid));
    final masterpieceAsync = ref.watch(userMasterpiecesProvider(mid));
    final videosAsync = ref.watch(userSpaceVideosProvider(mid, order: 'pubdate'));

    return CustomScrollView(
      key: PageStorageKey<String>('user_home_tab_$mid'),
      slivers: [
        // Sticky Video
        stickyAsync.when(
          data: (video) {
            if (video == null) return const SliverToBoxAdapter(child: SizedBox.shrink());
            return SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    child: Row(
                      children: [
                        const Icon(Icons.vertical_align_top_rounded, color: Colors.pink, size: 20),
                        const SizedBox(width: 4),
                        Text(
                          '置顶视频',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: _SimpleVideoCard(video: video),
                  ),
                  const Divider(height: 24, thickness: 8),
                ],
              ),
            );
          },
          error: (err, stack) => const SliverToBoxAdapter(child: SizedBox.shrink()),
          loading: () => const SliverToBoxAdapter(child: SizedBox.shrink()),
        ),

        // Masterpieces
        masterpieceAsync.when(
          data: (videos) {
            if (videos.isEmpty) return const SliverToBoxAdapter(child: SizedBox.shrink());
            return SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    child: Row(
                      children: [
                        const Icon(Icons.thumb_up_rounded, color: Colors.orange, size: 18),
                         const SizedBox(width: 6),
                        Text(
                          '代表作',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 180, // Adjust height as needed
                    child: ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      scrollDirection: Axis.horizontal,
                      itemCount: videos.length,
                      separatorBuilder: (c, i) => const SizedBox(width: 12),
                      itemBuilder: (context, index) {
                        final video = videos[index];
                        return SizedBox(
                          width: 160,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              VideoThumbnail(
                                url: video.pic,
                                duration: video.duration,
                                viewCount: video.stat.view,
                                danmakuCount: video.stat.danmaku,
                                borderRadius: 8,
                                aspectRatio: 16/10,
                                width: 160,
                                height: 100,
                              ),
                              const SizedBox(height: 6),
                              Text(
                                video.title,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                   const Divider(height: 24, thickness: 8),
                ],
              ),
            );
          },
          error: (err, stack) => const SliverToBoxAdapter(child: SizedBox.shrink()),
          loading: () => const SliverToBoxAdapter(child: SizedBox.shrink()),
        ),

        // Latest Videos
        videosAsync.when(
          data: (videos) {
            return SliverList(
              delegate: SliverChildListDelegate([
                if (videos.isNotEmpty) ...[
                   Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    child: Text(
                      '最新视频',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                  ...videos.take(5).map((video) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: _SimpleVideoCard(video: video),
                  )),
                ] else
                   const SizedBox(height: 100, child: Center(child: Text('暂无内容'))),
              ]),
            );
          },
          error: (err, stack) => SliverToBoxAdapter(child: Text('Error: $err')),
          loading: () => SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => const AppShimmer(
                child: VideoListSkeleton(),
              ),
              childCount: 3,
            ),
          ),
        ),
      ],
    );
  }
}

class _SimpleVideoCard extends StatelessWidget {
  final UserSpaceVideoModel video;
  const _SimpleVideoCard({required this.video});

  @override
  Widget build(BuildContext context) {
     return GestureDetector(
       onTap: () => VideoDetailRoute(bvid: video.bvid).push(context),
       child: Row(
         children: [
           SizedBox(
             width: 120,
             child: VideoThumbnail(
               url: video.pic,
               duration: video.duration,
               viewCount: video.stat.view,
               danmakuCount: video.stat.danmaku,
               borderRadius: 8,
               aspectRatio: 16/9,
               width: 120,
               height: 120 * 9 / 16,
             ),
           ),
           const SizedBox(width: 12),
           Expanded(
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 Text(
                   video.title,
                   maxLines: 2,
                   overflow: TextOverflow.ellipsis,
                   style: Theme.of(context).textTheme.titleSmall,
                 ),
                 const SizedBox(height: 4),
                 Text(
                   FormatUtils.formatTimestamp(video.pubDate),
                   style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey),
                 ),
               ],
             ),
           ),
         ],
       ),
     );
  }
}
