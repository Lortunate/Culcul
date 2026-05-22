import 'package:culcul/features/video/application/video_entry_workflows.dart';
import 'package:culcul/features/video/application/video_entry_layout.dart';
import 'package:culcul/features/video/presentation/detail/video_detail_page.dart';
import 'package:culcul/features/video/presentation/player/vertical_video_page.dart';
import 'package:culcul/features/video/presentation/video_navigation_callbacks.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class VideoEntryDecisionPage extends ConsumerWidget {
  final String bvid;
  final VoidCallback onLogin;
  final ValueChanged<int> onOpenUser;
  final ValueChanged<String> onOpenVideo;
  final OpenVideoCommentReplies onOpenCommentReplies;
  final VideoDetailPageBuilder normalPageBuilder;
  final Widget Function(String bvid) verticalPageBuilder;

  const VideoEntryDecisionPage({
    super.key,
    required this.bvid,
    required this.onLogin,
    required this.onOpenUser,
    required this.onOpenVideo,
    required this.onOpenCommentReplies,
    this.normalPageBuilder = _buildNormalPage,
    this.verticalPageBuilder = _buildVerticalPage,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final layoutAsync = ref.watch(resolveVideoEntryLayoutProvider(bvid));

    return layoutAsync.when(
      loading: () => const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (_, _) => normalPageBuilder(
        bvid: bvid,
        onLogin: onLogin,
        onOpenUser: onOpenUser,
        onOpenVideo: onOpenVideo,
        onOpenCommentReplies: onOpenCommentReplies,
      ),
      data: (layout) => layout == VideoEntryLayout.vertical
          ? verticalPageBuilder(bvid)
          : normalPageBuilder(
              bvid: bvid,
              onLogin: onLogin,
              onOpenUser: onOpenUser,
              onOpenVideo: onOpenVideo,
              onOpenCommentReplies: onOpenCommentReplies,
            ),
    );
  }
}

Widget _buildNormalPage({
  required String bvid,
  required VoidCallback onLogin,
  required ValueChanged<int> onOpenUser,
  required ValueChanged<String> onOpenVideo,
  required OpenVideoCommentReplies onOpenCommentReplies,
}) {
  return VideoDetailPage(
    bvid: bvid,
    onLogin: onLogin,
    onOpenUser: onOpenUser,
    onOpenVideo: onOpenVideo,
    onOpenCommentReplies: onOpenCommentReplies,
  );
}

Widget _buildVerticalPage(String bvid) => VerticalVideoPage(bvid: bvid);
