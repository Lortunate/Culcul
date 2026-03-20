import 'package:culcul/features/video/controllers/player_controller.dart';
import 'package:culcul/features/video/controllers/video_detail_controller.dart';
import 'package:culcul/features/video/presentation/hooks/use_player_system_settings.dart';
import 'package:culcul/features/video/presentation/hooks/use_video_dimensions.dart';
import 'package:culcul/features/video/presentation/hooks/use_video_loader.dart';
import 'package:culcul/features/video/presentation/hooks/use_video_progress.dart';
import 'package:culcul/features/video/presentation/widgets/layers/controls_layer.dart';
import 'package:culcul/features/video/presentation/widgets/layers/danmaku_layer.dart';
import 'package:culcul/features/video/presentation/widgets/layers/interaction_layer.dart';
import 'package:culcul/features/video/presentation/widgets/layers/subtitle_layer.dart';
import 'package:culcul/features/video/presentation/widgets/layers/video_layer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class VideoPlayerView extends HookConsumerWidget {
  final String bvid;
  final VoidCallback onToggleFullscreen;

  const VideoPlayerView({
    super.key,
    required this.bvid,
    required this.onToggleFullscreen,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(videoDetailControllerProvider(bvid));
    final playerController = ref.watch(playerControllerProvider.notifier);
    final isFullscreen = ref.watch(
      playerControllerProvider.select((s) => s.isFullscreen),
    );
    final isPlaying = ref.watch(
      playerControllerProvider.select((s) => s.isPlaying),
    );

    final player = playerController.player;

    useVideoLoader(ref, player, state);
    final brightness = usePlayerSystemSettings(player);
    final dimensions = useVideoDimensions(player);
    useVideoProgressReport(ref, bvid, player, isPlaying);

    final volumeSnapshot = useStream(player.stream.volume);
    final currentVolume = volumeSnapshot.data ?? player.state.volume;

    double aspectRatio = 16 / 9;
    if (dimensions.width != 0 && dimensions.height != 0) {
      aspectRatio = dimensions.width / dimensions.height;
    }

    return AspectRatio(
      aspectRatio: isFullscreen
          ? MediaQuery.of(context).size.aspectRatio
          : aspectRatio,
      child: Container(
        color: Colors.black,
        child: Stack(
          children: [
            InteractionLayer(
              bvid: bvid,
              brightness: brightness,
              currentVolume: currentVolume,
              child: Stack(
                fit: StackFit.passthrough,
                children: [
                  const VideoLayer(),
                  Positioned.fill(child: DanmakuLayer(bvid: bvid)),
                  Positioned.fill(child: SubtitleLayer(bvid: bvid)),
                ],
              ),
            ),
            ControlsLayer(
              bvid: bvid,
              onToggleFullscreen: onToggleFullscreen,
              isFullscreen: isFullscreen,
            ),
          ],
        ),
      ),
    );
  }
}
