import 'package:culcul/features/video/application/video_entry_workflows.dart';
import 'package:culcul/features/video/application/video_entry_layout.dart';
import 'package:culcul/features/video/presentation/comments/video_comments_view.dart';
import 'package:culcul/features/video/presentation/detail/video_detail_page.dart';
import 'package:culcul/features/video/presentation/player/vertical_video_page.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class VideoEntryDecisionPage extends ConsumerWidget {
  final String bvid;
  final VoidCallback onLogin;
  final ValueChanged<int> onOpenUser;
  final ValueChanged<String> onOpenVideo;
  final OpenVideoCommentReplies onOpenCommentReplies;

  const VideoEntryDecisionPage({
    super.key,
    required this.bvid,
    required this.onLogin,
    required this.onOpenUser,
    required this.onOpenVideo,
    required this.onOpenCommentReplies,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final layoutAsync = ref.watch(resolveVideoEntryLayoutProvider(bvid));

    return layoutAsync.when(
      loading: () => const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (_, _) => VideoDetailPage(
        bvid: bvid,
        onLogin: onLogin,
        onOpenUser: onOpenUser,
        onOpenVideo: onOpenVideo,
        onOpenCommentReplies: onOpenCommentReplies,
      ),
      data: (layout) => layout == VideoEntryLayout.vertical
          ? VerticalVideoPage(bvid: bvid)
          : VideoDetailPage(
              bvid: bvid,
              onLogin: onLogin,
              onOpenUser: onOpenUser,
              onOpenVideo: onOpenVideo,
              onOpenCommentReplies: onOpenCommentReplies,
            ),
    );
  }
}
