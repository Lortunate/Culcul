import 'package:culcul/providers/video/player_controller.dart';
import 'package:culcul/providers/video/video_detail_controller.dart';
import 'package:culcul/ui/pages/video/hooks/use_player_setup.dart';
import 'package:culcul/ui/pages/video/hooks/use_video_progress.dart';
import 'package:culcul/ui/pages/video/widgets/danmaku_layer.dart';
import 'package:culcul/ui/pages/video/widgets/player_controls.dart';
import 'package:culcul/ui/pages/video/widgets/player_gestures.dart';
import 'package:culcul/ui/pages/video/widgets/subtitle_overlay.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:media_kit_video/media_kit_video.dart';
import 'package:screen_brightness/screen_brightness.dart';

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
    final isLocked = ref.watch(
      playerControllerProvider.select((s) => s.isLocked),
    );
    final isPlaying = ref.watch(
      playerControllerProvider.select((s) => s.isPlaying),
    );

    final player = playerController.player;
    final controller = playerController.videoController;

    final seekOffset = useState<Duration?>(null);
    final isSpeedingUp = useState(false);

    final playerSetup = usePlayerSetup(ref, bvid, player, state);
    final brightness = playerSetup.brightness;

    useVideoProgressReport(ref, bvid, player, isPlaying);

    final volumeSnapshot = useStream(player.stream.volume);
    final currentVolume = volumeSnapshot.data ?? player.state.volume;

    double aspectRatio = 16 / 9;
    if (playerSetup.videoWidth != 0 && playerSetup.videoHeight != 0) {
      aspectRatio = playerSetup.videoWidth / playerSetup.videoHeight;
    }

    return AspectRatio(
      aspectRatio: isFullscreen
          ? MediaQuery.of(context).size.aspectRatio
          : aspectRatio,
      child: Container(
        color: Colors.black,
        child: Stack(
          children: [
            PlayerGestures(
              isLocked: isLocked,
              volume: currentVolume,
              brightness: brightness.value,
              onTap: playerController.toggleControls,
              onDoubleTap: playerController.playOrPause,
              onLongPressStart: () {
                if (player.state.playing) {
                  isSpeedingUp.value = true;
                  player.setRate(2.0);
                }
              },
              onLongPressEnd: () {
                isSpeedingUp.value = false;
                player.setRate(state.playbackSpeed);
              },
              onVerticalDragUpdate: (delta, isLeft) {
                if (isLeft) {
                  final newBrightness = (brightness.value + delta / 200).clamp(
                    0.0,
                    1.0,
                  );
                  brightness.value = newBrightness;
                  ScreenBrightness().setApplicationScreenBrightness(newBrightness);
                } else {
                  final newVolume = (currentVolume + delta / 2).clamp(
                    0.0,
                    100.0,
                  );
                  player.setVolume(newVolume);
                }
              },
              onHorizontalDragUpdate: (delta) {
                final seconds = delta / 5;
                seekOffset.value = Duration(seconds: seconds.toInt());
              },
              onDragEnd: () {
                if (seekOffset.value != null) {
                  var targetPos = player.state.position + seekOffset.value!;
                  if (targetPos < Duration.zero) {
                    targetPos = Duration.zero;
                  } else if (targetPos > player.state.duration) {
                    targetPos = player.state.duration;
                  }
                  playerController.seek(targetPos);
                  seekOffset.value = null;
                }
              },
              child: Stack(
                fit: StackFit.passthrough,
                children: [
                  Video(
                    controller: controller,
                    controls: (state) => const SizedBox(),
                  ),
                  Positioned.fill(child: DanmakuLayer(bvid: bvid)),
                  Positioned.fill(child: SubtitleOverlay(bvid: bvid)),
                ],
              ),
            ),
            Positioned.fill(
              child: PlayerControlsOverlay(
                bvid: bvid,
                onToggleFullscreen: onToggleFullscreen,
                onClose: () {
                  if (isFullscreen) {
                    onToggleFullscreen();
                  } else {
                    Navigator.of(context).pop();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
