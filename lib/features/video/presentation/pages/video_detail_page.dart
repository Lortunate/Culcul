import 'package:culcul/features/video/presentation/view_models/video_detail_view_model.dart';
import 'package:culcul/features/video/presentation/view_models/player_view_model.dart';
import 'package:culcul/features/video/presentation/widgets/hooks/use_video_orientation.dart';
import 'package:culcul/features/video/presentation/widgets/hooks/use_video_session.dart';
import 'package:culcul/features/video/presentation/widgets/comments/video_comments_view.dart';
import 'package:culcul/features/video/presentation/widgets/info/video_info_view.dart';
import 'package:culcul/features/video/presentation/widgets/info/video_tab_bar.dart';
import 'package:culcul/features/video/presentation/widgets/video_player_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class VideoDetailPage extends HookConsumerWidget {
  final String bvid;

  const VideoDetailPage({super.key, required this.bvid});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sessionId = useVideoSession(ref, bvid);

    final videoDetail = ref.watch(
      videoDetailControllerProvider(bvid).select((value) => value.videoDetail),
    );
    final currentCid = ref.watch(
      videoDetailControllerProvider(bvid).select((value) => value.currentCid),
    );
    final isFullscreen = ref.watch(
      playerControllerProvider.select((value) => value.isFullscreen),
    );

    final toggleFullscreen = useVideoOrientation(
      ref,
      videoDetail: videoDetail,
      currentCid: currentCid,
    );
    final tabController = useTabController(initialLength: 2);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
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
              VideoPlayerView(
                bvid: bvid,
                onToggleFullscreen: toggleFullscreen,
                sessionId: sessionId,
              ),
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
