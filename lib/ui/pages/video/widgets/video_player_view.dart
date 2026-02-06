import 'package:culcul/core/constants/api_constants.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/providers/video/danmaku_settings_provider.dart';
import 'package:culcul/providers/video/player_controller.dart';
import 'package:culcul/providers/video/subtitle_controller.dart';
import 'package:culcul/providers/video/video_detail_controller.dart';
import 'package:culcul/ui/pages/video/hooks/use_video_progress.dart';
import 'package:culcul/ui/pages/video/video_listen_page.dart';
import 'package:culcul/ui/pages/video/widgets/controls/player_constants.dart';
import 'package:culcul/ui/pages/video/widgets/controls/speed_indicator.dart';
import 'package:culcul/ui/pages/video/widgets/player_controls.dart';
import 'package:culcul/ui/pages/video/widgets/danmaku_layer.dart';
import 'package:culcul/ui/pages/video/widgets/player_gestures.dart';
import 'package:culcul/ui/pages/video/widgets/subtitle_overlay.dart';
import 'package:culcul/ui/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';
import 'package:screen_brightness/screen_brightness.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

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
    final t = Translations.of(context);
    final state = ref.watch(videoDetailControllerProvider(bvid));

    final playerController = ref.watch(playerControllerProvider.notifier);
    final playerState = ref.watch(playerControllerProvider);
    final player = playerController.player;
    final controller = playerController.videoController;

    final brightness = useState(0.5);
    final seekOffset = useState<Duration?>(null);
    final isSpeedingUp = useState(false);

    final lastLoadedCid = useRef<int?>(null);
    final lastPlayUrl = useRef<String?>(null);

    // Wakelock
    useEffect(() {
      WakelockPlus.enable();
      return () => WakelockPlus.disable();
    }, []);

    // Initialize brightness
    useEffect(() {
      ScreenBrightness().current.then((val) {
        brightness.value = val;
      }).catchError((e) {
        debugPrint('Failed to get brightness: $e');
      });
      return null;
    }, []);

    // Player initialization and quality switching logic
    useEffect(() {
      if (state.playUrl != null && state.playUrl!.durl.isNotEmpty) {
        final url = state.playUrl!.durl.first.url;

        if (lastPlayUrl.value == url) return null;

        final bool isQualitySwitch =
            lastLoadedCid.value == state.currentCid &&
            lastPlayUrl.value != null;

        Future.microtask(() async {
          await playerController.loadVideo(
            url,
            httpHeaders: {
              'Referer': ApiConstants.referer,
              'User-Agent': ApiConstants.userAgent,
            },
            isQualitySwitch: isQualitySwitch,
          );
          
          player.setRate(state.playbackSpeed);

          lastLoadedCid.value = state.currentCid;
          lastPlayUrl.value = url;
        });
      }
      return null;
    }, [state.playUrl]);

    useEffect(() {
      player.setRate(state.playbackSpeed);
      return null;
    }, [state.playbackSpeed]);

    // Report progress
    useVideoProgressReport(ref, bvid, player, playerState.isPlaying);

    // Listen to video dimensions for aspect ratio
    final videoWidth = useState(player.state.width ?? 0);
    final videoHeight = useState(player.state.height ?? 0);

    useEffect(() {
       final sub = player.stream.videoParams.listen((_) {
          videoWidth.value = player.state.width ?? 0;
          videoHeight.value = player.state.height ?? 0;
       });
       return sub.cancel;
    }, []);

    // Listen to volume changes for gesture feedback
    final volumeSnapshot = useStream(player.stream.volume);
    final currentVolume = volumeSnapshot.data ?? player.state.volume;

    double aspectRatio = 16 / 9;
    if (videoWidth.value != 0 && videoHeight.value != 0) {
      aspectRatio = videoWidth.value / videoHeight.value;
    }

    return AspectRatio(
      aspectRatio: playerState.isFullscreen
          ? MediaQuery.of(context).size.aspectRatio
          : aspectRatio,
      child: Container(
        color: Colors.black,
        child: Stack(
          children: [
            PlayerGestures(
              isLocked: playerState.isLocked,
              volume: currentVolume,
              brightness: brightness.value,
              onTap: playerController.toggleControls,
              onDoubleTap: playerController.playOrPause,
              onLongPressStart: () {
                if (playerState.isPlaying) {
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
                  final newBrightness = (brightness.value + delta / 200)
                      .clamp(0.0, 1.0);
                  brightness.value = newBrightness;
                  ScreenBrightness().setScreenBrightness(newBrightness);
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
                  var targetPos = playerState.position + seekOffset.value!;
                  if (targetPos < Duration.zero) {
                    targetPos = Duration.zero;
                  } else if (targetPos > playerState.duration) {
                    targetPos = playerState.duration;
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
            if (isSpeedingUp.value) const SpeedIndicator(),
            PlayerControlsOverlay(
              bvid: bvid,
              onToggleFullscreen: onToggleFullscreen,
              onClose: () {
                 if (playerState.isFullscreen) {
                   onToggleFullscreen();
                 } else {
                   context.pop();
                 }
              },
              onListen: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => VideoListenPage(bvid: bvid),
                ),
              ),
            ),
            if (state.isLoading || playerState.isBuffering)
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const CircularProgressIndicator(
                      color: AppColors.primary,
                      strokeWidth: 3,
                    ),
                    if (state.isLoading) ...[
                      const SizedBox(height: 12),
                      Text(
                        t.common.loading,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
