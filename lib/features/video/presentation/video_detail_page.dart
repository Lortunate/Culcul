import 'package:culcul/features/video/logic/player_controller.dart';
import 'package:culcul/features/video/logic/video_detail_controller.dart';
import 'package:culcul/features/video/presentation/hooks/use_video_orientation.dart';
import 'package:culcul/features/video/presentation/vertical_video_page.dart';
import 'package:culcul/ui/pages/video/widgets/comments/video_comments_view.dart';
import 'package:culcul/ui/pages/video/widgets/info/video_info_view.dart';
import 'package:culcul/ui/pages/video/widgets/info/video_tab_bar.dart';
import 'package:culcul/ui/pages/video/widgets/video_player_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class VideoDetailPage extends HookConsumerWidget {
  final String bvid;

  const VideoDetailPage({super.key, required this.bvid});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(videoDetailControllerProvider(bvid));

    if (state.videoDetail != null &&
        state.videoDetail!.dimension.width != 0 &&
        state.videoDetail!.dimension.height != 0 &&
        state.videoDetail!.dimension.width <
            state.videoDetail!.dimension.height) {
      return VerticalVideoPage(bvid: bvid, videoDetail: state.videoDetail!);
    }

    final isFullscreen = ref.watch(
      playerControllerProvider.select((s) => s.isFullscreen),
    );

    final toggleFullscreen = useVideoOrientation(
      ref,
      videoDetail: state.videoDetail,
      currentCid: state.currentCid,
    );
    final tabController = useTabController(initialLength: 2);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: PopScope(
        canPop: !isFullscreen,
        onPopInvokedWithResult: (didPop, result) {
          if (didPop) return;
          toggleFullscreen();
        },
        child: SafeArea(
          top: !isFullscreen,
          bottom: !isFullscreen,
          left: !isFullscreen,
          right: !isFullscreen,
          child: Column(
            children: [
              VideoPlayerView(bvid: bvid, onToggleFullscreen: toggleFullscreen),
              if (!isFullscreen) ...[
                VideoTabBar(controller: tabController),
                Expanded(
                  child: TabBarView(
                    controller: tabController,
                    children: [
                      VideoInfoView(bvid: bvid),
                      VideoCommentsView(bvid: bvid),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
