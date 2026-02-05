import 'package:culcul/providers/video/player_controller.dart';
import 'package:culcul/ui/pages/video/widgets/controls/gesture_indicator.dart';
import 'package:culcul/ui/pages/video/widgets/controls/seek_ripple_overlay.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PlayerGestures extends HookConsumerWidget {
  final Widget child;
  final VoidCallback onTap;
  final VoidCallback onDoubleTap;
  final Function(double, bool isLeft)
  onVerticalDragUpdate; // For brightness/volume
  final Function(double) onHorizontalDragUpdate; // For seeking
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
    final rippleSide = useState(0); // 0: none, -1: left, 1: right

    // Store start position for seek calculation
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
              // Capture current position and duration when drag starts
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
              
              // Calculate target time
              final targetSeconds = (startPosition.value.inSeconds + seconds).clamp(0, totalDuration.value.inSeconds);
              final targetDuration = Duration(seconds: targetSeconds);

              indicatorIcon.value = seconds >= 0
                  ? Icons.fast_forward_rounded
                  : Icons.fast_rewind_rounded;
              
              final diffText = '${seconds >= 0 ? '+' : ''}${seconds}s';
              indicatorLabel.value = diffText;
              
              // Show target time / total time
              indicatorTextValue.value = '${_formatDuration(targetDuration)} / ${_formatDuration(totalDuration.value)}';
              
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

              HapticFeedback.selectionClick();
              final screenWidth = MediaQuery.of(context).size.width;
              final isLeftSubscreen =
                  details.globalPosition.dx < screenWidth / 2;

              verticalDelta.value -=
                  details.primaryDelta ?? 0; // Swipe up is positive
              onVerticalDragUpdate(verticalDelta.value, isLeftSubscreen);

              showIndicator.value = true;
              indicatorTextValue.value = null; // Clear text value for volume/brightness
              
              if (isLeftSubscreen) {
                if ((brightness ?? 0) < 0.3) {
                  indicatorIcon.value = Icons.brightness_low;
                } else if ((brightness ?? 0) < 0.7) {
                  indicatorIcon.value = Icons.brightness_medium;
                } else {
                  indicatorIcon.value = Icons.brightness_high;
                }
                indicatorLabel.value = '亮度';
                indicatorValue.value = brightness;
                indicatorTextValue.value = '${((brightness ?? 0) * 100).toInt()}%';
              } else {
                final v = volume ?? 0;
                if (v <= 0) {
                  indicatorIcon.value = Icons.volume_off;
                } else if (v < 50) {
                  indicatorIcon.value = Icons.volume_down;
                } else {
                  indicatorIcon.value = Icons.volume_up;
                }
                indicatorLabel.value = '音量';
                indicatorValue.value = volume != null ? volume! / 100.0 : null;
                indicatorTextValue.value = '${(volume ?? 0).toInt()}%';
              }
            },
      onVerticalDragEnd: isLocked ? null : (_) => resetDrag(),
      child: Stack(
        children: [
          child,
          if (showIndicator.value)
            Center(
              child: GestureIndicator(
                icon: indicatorIcon.value,
                label: indicatorLabel.value,
                value: indicatorValue.value,
                textValue: indicatorTextValue.value,
              ),
            ),

          if (rippleSide.value != 0)
            Positioned.fill(
              child: SeekRippleOverlay(
                isForward: rippleSide.value == 1,
                onAnimationComplete: () => rippleSide.value = 0,
              ),
            ),

          // Double tap regions for seek
          if (!isLocked) ...[
            Positioned(
              left: 0,
              top: 0,
              bottom: 0,
              width:
                  MediaQuery.of(context).size.width * 0.3, // Increased hit area
              child: GestureDetector(
                onDoubleTap: () {
                  HapticFeedback.lightImpact();
                  rippleSide.value = -1;
                  onHorizontalDragUpdate(-50.0); // ~10s
                  onDragEnd();
                },
                behavior: HitTestBehavior.translucent,
              ),
            ),
            Positioned(
              right: 0,
              top: 0,
              bottom: 0,
              width:
                  MediaQuery.of(context).size.width * 0.3, 
              child: GestureDetector(
                onDoubleTap: () {
                  HapticFeedback.lightImpact();
                  rippleSide.value = 1;
                  onHorizontalDragUpdate(50.0); // ~10s
                  onDragEnd();
                },
                behavior: HitTestBehavior.translucent,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
