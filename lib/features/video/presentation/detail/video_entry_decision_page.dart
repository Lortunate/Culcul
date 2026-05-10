import 'package:culcul/features/video/application/video_entry_workflows.dart';
import 'package:culcul/features/video/application/video_entry_layout.dart';
import 'package:culcul/features/video/presentation/detail/video_detail_page.dart';
import 'package:culcul/features/video/presentation/player/vertical_video_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class VideoEntryDecisionPage extends HookConsumerWidget {
  final String bvid;
  final Widget Function(String bvid) normalPageBuilder;
  final Widget Function(String bvid) verticalPageBuilder;

  const VideoEntryDecisionPage({
    super.key,
    required this.bvid,
    this.normalPageBuilder = _buildNormalPage,
    this.verticalPageBuilder = _buildVerticalPage,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final workflow = ref.read(resolveVideoEntryLayoutWorkflowProvider);
    final decisionFuture = useMemoized(() => workflow.call(bvid), [workflow, bvid]);
    final decisionSnapshot = useFuture(decisionFuture);

    if (!decisionSnapshot.hasData) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final layout = decisionSnapshot.data!;
    if (layout == VideoEntryLayout.vertical) {
      return verticalPageBuilder(bvid);
    }
    return normalPageBuilder(bvid);
  }
}

Widget _buildNormalPage(String bvid) => VideoDetailPage(bvid: bvid);
Widget _buildVerticalPage(String bvid) => VerticalVideoPage(bvid: bvid);
