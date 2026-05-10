import 'package:culcul/features/video/presentation/player/controls/video_control_buttons.dart';
import 'package:culcul/features/video/presentation/player/controls/video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PlayerBottomBar extends ConsumerWidget {
  final String bvid;
  final VoidCallback? onNext;
  final VoidCallback? onToggleFullscreen;

  const PlayerBottomBar({
    super.key,
    required this.bvid,
    this.onNext,
    this.onToggleFullscreen,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const VideoProgressBar(),
        VideoControlButtons(
          bvid: bvid,
          onNext: onNext,
          onToggleFullscreen: onToggleFullscreen,
        ),
      ],
    );
  }
}
