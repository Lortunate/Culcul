import 'package:culcul/features/video/presentation/view_models/video_detail_view_model.dart';
import 'package:culcul/features/video/presentation/view_models/video_page_view_model.dart';
import 'package:culcul/features/video/presentation/widgets/hooks/use_video_orientation.dart';
import 'package:culcul/features/video/presentation/pages/vertical_video_page.dart';
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
    final state = ref.watch(videoDetailControllerProvider(bvid));
    final pageState = ref.watch(videoPageViewModelProvider(bvid));

    if (pageState.shouldUseVerticalLayout && state.videoDetail != null) {
      return VerticalVideoPage(bvid: bvid, videoDetail: state.videoDetail!);
    }

    final toggleFullscreen = useVideoOrientation(
      ref,
      videoDetail: state.videoDetail,
      currentCid: state.currentCid,
    );
    final tabController = useTabController(initialLength: 2);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: PopScope(
        canPop: !pageState.isFullscreen,
        onPopInvokedWithResult: (didPop, result) {
          if (didPop) return;
          toggleFullscreen();
        },
        child: SafeArea(
          top: !pageState.isFullscreen,
          bottom: !pageState.isFullscreen,
          left: !pageState.isFullscreen,
          right: !pageState.isFullscreen,
          child: Column(
            children: [
              VideoPlayerView(bvid: bvid, onToggleFullscreen: toggleFullscreen),
              if (!pageState.isFullscreen) ...[
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


