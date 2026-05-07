import 'package:culcul/features/video/presentation/view_models/player_view_model.dart';
import 'package:culcul/features/video/presentation/hooks/use_player_system_settings.dart';
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
  final String sessionId;
  final VoidCallback onToggleFullscreen;

  const VideoPlayerView({
    super.key,
    required this.bvid,
    required this.sessionId,
    required this.onToggleFullscreen,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final playerController = ref.read(playerControllerProvider.notifier);
    final loaderInput = watchVideoLoaderInput(ref, bvid);
    final isFullscreen = ref.watch(
      playerControllerProvider.select((s) => s.isFullscreen),
    );
    final isPlaying = ref.watch(playerControllerProvider.select((s) => s.isPlaying));

    final player = playerController.player;

    useVideoLoader(ref, player, loaderInput, sessionId: sessionId);
    final brightness = usePlayerSystemSettings(player);
    useVideoProgressReport(ref, bvid, player, isPlaying);

    final volumeSnapshot = useStream(player.stream.volume);
    final currentVolume = volumeSnapshot.data ?? player.state.volume;

    return AspectRatio(
      aspectRatio: isFullscreen ? MediaQuery.sizeOf(context).aspectRatio : 16 / 10,
      child: Container(
        color: colorScheme.scrim,
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
