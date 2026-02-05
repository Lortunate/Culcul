import 'package:culcul/providers/video/player_controller.dart';
import 'package:culcul/providers/video/video_detail_controller.dart';
import 'package:culcul/ui/pages/video/hooks/use_video_orientation.dart';
import 'package:culcul/ui/pages/video/widgets/video_comments_view.dart';
import 'package:culcul/ui/pages/video/widgets/video_detail_widgets.dart';
import 'package:culcul/ui/pages/video/widgets/video_info_view.dart';
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
    final notifier = ref.read(videoDetailControllerProvider(bvid).notifier);
    final playerState = ref.watch(playerControllerProvider);

    final toggleFullscreen = useVideoOrientation(
      ref,
      videoDetail: state.videoDetail,
      currentCid: state.currentCid,
    );
    final tabController = useTabController(initialLength: 2);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: PopScope(
        canPop: !playerState.isFullscreen,
        onPopInvokedWithResult: (didPop, result) {
          if (didPop) return;
          toggleFullscreen();
        },
        child: SafeArea(
          top: !playerState.isFullscreen,
          bottom: !playerState.isFullscreen,
          left: !playerState.isFullscreen,
          right: !playerState.isFullscreen,
          child: Column(
            children: [
              VideoPlayerView(
                bvid: bvid,
                onToggleFullscreen: toggleFullscreen,
              ),
              if (!playerState.isFullscreen) ...[
                VideoTabBar(controller: tabController),
                Expanded(
                  child: TabBarView(
                    controller: tabController,
                    children: [
                      VideoInfoView(state: state, notifier: notifier),
                      VideoCommentsView(
                        bvid: bvid,
                        state: state,
                        notifier: notifier,
                      ),
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
