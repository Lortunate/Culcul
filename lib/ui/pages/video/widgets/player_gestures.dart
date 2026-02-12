import 'package:culcul/providers/video/player_controller.dart';
import 'package:culcul/ui/pages/video/widgets/controls/gesture_indicator.dart';
import 'package:culcul/ui/pages/video/widgets/controls/seek_ripple_overlay.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PlayerGestures extends HookConsumerWidget {
  final Widget child;
  final VoidCallback onTap;
  final VoidCallback onDoubleTap;
  final Function(double, bool isLeft) onVerticalDragUpdate;
  final Function(double) onHorizontalDragUpdate;
  final VoidCallback onDragEnd;
  final VoidCallback? onLongPressStart;
  final VoidCallback? onLongPressEnd;
  final bool isLocked;
  final double? volume;
  final double? brightness;

  const PlayerGestures({
    super.key,
    required this.child,
    required this.onTap,
    required this.onDoubleTap,
    required this.onVerticalDragUpdate,
    required this.onHorizontalDragUpdate,
    required this.onDragEnd,
    this.onLongPressStart,
    this.onLongPressEnd,
    this.isLocked = false,
    this.volume,
    this.brightness,
  });

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);
    if (duration.inHours > 0) {
      return '${duration.inHours}:${twoDigits(minutes)}:${twoDigits(seconds)}';
    }
    return '${twoDigits(minutes)}:${twoDigits(seconds)}';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final horizontalDelta = useRef<double>(0.0);
    final verticalDelta = useRef<double>(0.0);
    final isHorizontalDrag = useState(false);
    final isVerticalDrag = useState(false);
    final showIndicator = useState(false);
    final indicatorIcon = useState<IconData>(Icons.volume_up);
    final indicatorLabel = useState('');
    final indicatorValue = useState<double?>(null);
    final indicatorTextValue = useState<String?>(null);
    final rippleSide = useState(0);

    final startPosition = useRef<Duration>(Duration.zero);
    final totalDuration = useRef<Duration>(Duration.zero);

    void resetDrag() {
      horizontalDelta.value = 0.0;
      verticalDelta.value = 0.0;
      isHorizontalDrag.value = false;
      isVerticalDrag.value = false;
      showIndicator.value = false;
      onDragEnd();
    }

    return GestureDetector(
      onTap: onTap,
      onDoubleTap: isLocked ? null : onDoubleTap,
      onLongPressStart: isLocked ? null : (_) => onLongPressStart?.call(),
      onLongPressEnd: isLocked ? null : (_) => onLongPressEnd?.call(),
      onHorizontalDragStart: isLocked
          ? null
          : (_) {
              horizontalDelta.value = 0.0;
              isHorizontalDrag.value = true;
              final playerState = ref.read(playerControllerProvider);
              startPosition.value = playerState.position;
              totalDuration.value = playerState.duration;
            },
      onHorizontalDragUpdate: isLocked
          ? null
          : (details) {
              if (!isHorizontalDrag.value) return;
              horizontalDelta.value += details.primaryDelta ?? 0;
              onHorizontalDragUpdate(horizontalDelta.value);

              showIndicator.value = true;
              final seconds = (horizontalDelta.value / 5).toInt();

              final targetSeconds = (startPosition.value.inSeconds + seconds)
                  .clamp(0, totalDuration.value.inSeconds);
              final targetDuration = Duration(seconds: targetSeconds);

              indicatorIcon.value = seconds > 0
                  ? Icons.fast_forward_rounded
                  : Icons.fast_rewind_rounded;
              indicatorLabel.value = '${seconds > 0 ? '+' : ''}$seconds s';
              indicatorTextValue.value =
                  '${_formatDuration(targetDuration)} / ${_formatDuration(totalDuration.value)}';
              indicatorValue.value = null;
            },
      onHorizontalDragEnd: isLocked ? null : (_) => resetDrag(),
      onVerticalDragStart: isLocked
          ? null
          : (details) {
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
              onVerticalDragUpdate(-details.primaryDelta!, isLeft);

              showIndicator.value = true;
              if (isLeft) {
                indicatorIcon.value = Icons.brightness_6_rounded;
                indicatorLabel.value = '亮度';
                indicatorValue.value = brightness;
                indicatorTextValue.value = null;
              } else {
                indicatorIcon.value = Icons.volume_up_rounded;
                indicatorLabel.value = '音量';
                indicatorValue.value = (volume ?? 0) / 100;
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
                    final playerController = ref.read(
                      playerControllerProvider.notifier,
                    );
                    playerController.seek(
                      playerController.player.state.position -
                          const Duration(seconds: 5),
                    );
                  } else if (details.globalPosition.dx > screenWidth * 0.8) {
                    rippleSide.value = 1;
                    final playerController = ref.read(
                      playerControllerProvider.notifier,
                    );
                    playerController.seek(
                      playerController.player.state.position +
                          const Duration(seconds: 5),
                    );
                  }
                },
                child: Container(color: Colors.transparent),
              ),
            ),
          if (rippleSide.value != 0)
            SeekRippleOverlay(
              isForward: rippleSide.value > 0,
              onAnimationComplete: () => rippleSide.value = 0,
            ),
          if (showIndicator.value)
            Center(
              child: GestureIndicator(
                icon: indicatorIcon.value,
                label: indicatorLabel.value,
                value: indicatorValue.value,
                textValue: indicatorTextValue.value,
              ),
            ),
        ],
      ),
    );
  }
}
