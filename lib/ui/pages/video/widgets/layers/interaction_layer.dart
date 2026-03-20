import 'package:culcul/features/video/controllers/player_controller.dart';
import 'package:culcul/features/video/controllers/video_detail_controller.dart';
import 'package:culcul/shared/extensions/format_extensions.dart';
import 'package:culcul/ui/pages/video/widgets/controls/player_constants.dart';
import 'package:culcul/ui/pages/video/widgets/controls/seek_ripple_overlay.dart';
import 'package:culcul/ui/pages/video/widgets/layers/gesture_feedback_overlay.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:screen_brightness/screen_brightness.dart';

class InteractionLayer extends HookConsumerWidget {
  final Widget child;
  final String bvid;
  final ValueNotifier<double> brightness;
  final double currentVolume;

  const InteractionLayer({
    super.key,
    required this.child,
    required this.bvid,
    required this.brightness,
    required this.currentVolume,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playerController = ref.watch(playerControllerProvider.notifier);
    final isLocked = ref.watch(
      playerControllerProvider.select((s) => s.isLocked),
    );
    final detailState = ref.watch(videoDetailControllerProvider(bvid));
    final playbackSpeed = detailState.playbackSpeed;

    final player = playerController.player;

    final horizontalDelta = useRef<double>(0.0);
    final verticalDelta = useRef<double>(0.0);
    final isHorizontalDrag = useState(false);
    final isVerticalDrag = useState(false);
    final showIndicator = useState(false);
    final indicatorIcon = useState<IconData>(Icons.volume_up);
    final indicatorLabel = useState('');
    final indicatorValue = useState<double?>(null);
    final indicatorTextValue = useState<String?>(null);
    final rippleSide = useState(0); // -1: left, 0: none, 1: right

    final startPosition = useRef<Duration>(Duration.zero);
    final totalDuration = useRef<Duration>(Duration.zero);
    final seekOffset = useState<Duration?>(null);

    void resetDrag() {
      horizontalDelta.value = 0.0;
      verticalDelta.value = 0.0;
      isHorizontalDrag.value = false;
      isVerticalDrag.value = false;
      showIndicator.value = false;
      
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
    }

    return GestureDetector(
      onTap: playerController.toggleControls,
      onDoubleTap: isLocked ? null : playerController.playOrPause,
      onLongPressStart: isLocked ? null : (_) {
        if (player.state.playing) {
          player.setRate(2.0);
        }
      },
      onLongPressEnd: isLocked ? null : (_) {
        player.setRate(playbackSpeed);
      },
      onHorizontalDragStart: isLocked
          ? null
          : (_) {
              horizontalDelta.value = 0.0;
              isHorizontalDrag.value = true;
              startPosition.value = player.state.position;
              totalDuration.value = player.state.duration;
            },
      onHorizontalDragUpdate: isLocked
          ? null
          : (details) {
              if (!isHorizontalDrag.value) return;
              horizontalDelta.value += details.primaryDelta ?? 0;

              showIndicator.value = true;
              final seconds = (horizontalDelta.value / kSeekSensitivity).toInt();
              seekOffset.value = Duration(seconds: seconds);

              final targetSeconds = (startPosition.value.inSeconds + seconds)
                  .clamp(0, totalDuration.value.inSeconds);
              final targetDuration = Duration(seconds: targetSeconds);

              indicatorIcon.value = seconds > 0
                  ? Icons.fast_forward_rounded
                  : Icons.fast_rewind_rounded;
              indicatorLabel.value = '${seconds > 0 ? '+' : ''}$seconds s';
              indicatorTextValue.value =
                  '${targetDuration.formatDuration} / ${totalDuration.value.formatDuration}';
              indicatorValue.value = null;
            },
      onHorizontalDragEnd: isLocked ? null : (_) => resetDrag(),
      onVerticalDragStart: isLocked
          ? null
          : (_) {
              verticalDelta.value = 0.0;
              isVerticalDrag.value = true;
            },
      onVerticalDragUpdate: isLocked
          ? null
          : (details) {
              if (!isVerticalDrag.value) return;
              verticalDelta.value += details.primaryDelta ?? 0;

              final isLeft =
                  details.globalPosition.dx <
                  MediaQuery.of(context).size.width / 2;
              
              showIndicator.value = true;
              
              if (isLeft) {
                final delta = -details.primaryDelta!;
                final newBrightness = (brightness.value + delta / kBrightnessSensitivity).clamp(0.0, 1.0);
                brightness.value = newBrightness;
                ScreenBrightness().setApplicationScreenBrightness(newBrightness);
                
                indicatorIcon.value = Icons.brightness_6_rounded;
                indicatorLabel.value = '亮度';
                indicatorValue.value = brightness.value;
                indicatorTextValue.value = null;
              } else {
                final delta = -details.primaryDelta!;
                final newVolume = (currentVolume + delta / kVolumeSensitivity).clamp(0.0, 100.0);
                player.setVolume(newVolume);
                
                indicatorIcon.value = Icons.volume_up_rounded;
                indicatorLabel.value = '音量';
                indicatorValue.value = newVolume / 100;
                indicatorTextValue.value = null;
              }
            },
      onVerticalDragEnd: isLocked ? null : (_) => resetDrag(),
      child: Stack(
        fit: StackFit.expand,
        children: [
          child,
          if (!isLocked)
            Positioned.fill(
              child: GestureDetector(
                onDoubleTapDown: (details) {
                  final screenWidth = MediaQuery.of(context).size.width;
                  if (details.globalPosition.dx < screenWidth * 0.2) {
                    rippleSide.value = -1;
                    playerController.seek(
                      player.state.position - const Duration(seconds: 5),
                    );
                  } else if (details.globalPosition.dx > screenWidth * 0.8) {
                    rippleSide.value = 1;
                    playerController.seek(
                      player.state.position + const Duration(seconds: 5),
                    );
                  }
                },
                behavior: HitTestBehavior.translucent,
                child: const SizedBox.expand(),
              ),
            ),
          if (rippleSide.value != 0)
            SeekRippleOverlay(
              isForward: rippleSide.value > 0,
              onAnimationComplete: () => rippleSide.value = 0,
            ),
          GestureFeedbackOverlay(
            showIndicator: showIndicator,
            indicatorIcon: indicatorIcon,
            indicatorLabel: indicatorLabel,
            indicatorValue: indicatorValue,
            indicatorTextValue: indicatorTextValue,
          ),
        ],
      ),
    );
  }
}
