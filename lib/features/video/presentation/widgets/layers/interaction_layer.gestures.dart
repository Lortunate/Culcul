part of 'interaction_layer.dart';

class _InteractionGestureSurface extends HookConsumerWidget {
  final Widget child;
  final String bvid;
  final ValueNotifier<double> brightness;
  final double currentVolume;

  const _InteractionGestureSurface({
    required this.child,
    required this.bvid,
    required this.brightness,
    required this.currentVolume,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = i18n(context);
    final playerController = ref.read(playerControllerProvider.notifier);
    final isLocked = ref.watch(playerControllerProvider.select((s) => s.isLocked));
    final playbackSpeed = ref.watch(
      videoDetailControllerProvider(bvid).select((value) => value.playbackSpeed),
    );
    final player = playerController.player;
    final dragSession = useRef<_DragSession>(_DragSession());
    final dragMode = useState<_DragMode>(_DragMode.idle);
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
      dragSession.value.reset(
        currentBrightness: brightness.value,
        currentVolume: currentVolume,
      );
      dragMode.value = _DragMode.idle;
      showIndicator.value = false;
      if (seekOffset.value != null) {
        var targetPos = startPosition.value + seekOffset.value!;
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
      onLongPressStart: isLocked
          ? null
          : (_) {
              if (player.state.playing) {
                player.setRate(2.0);
              }
            },
      onLongPressEnd: isLocked
          ? null
          : (_) {
              player.setRate(playbackSpeed);
            },
      onHorizontalDragStart: isLocked
          ? null
          : (_) {
              dragSession.value.startHorizontal();
              dragMode.value = _DragMode.horizontal;
              startPosition.value = player.state.position;
              totalDuration.value = player.state.duration;
            },
      onHorizontalDragUpdate: isLocked
          ? null
          : (details) {
              if (dragMode.value != _DragMode.horizontal) return;
              dragSession.value.horizontalDelta += details.primaryDelta ?? 0;
              showIndicator.value = true;
              final seconds = (dragSession.value.horizontalDelta / kSeekSensitivity)
                  .toInt();
              seekOffset.value = Duration(seconds: seconds);
              final targetSeconds = (startPosition.value.inSeconds + seconds).clamp(
                0,
                totalDuration.value.inSeconds,
              );
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
              dragSession.value.startVertical(
                currentBrightness: brightness.value,
                currentVolume: currentVolume,
              );
              dragMode.value = _DragMode.vertical;
            },
      onVerticalDragUpdate: isLocked
          ? null
          : (details) {
              if (dragMode.value != _DragMode.vertical) return;
              final nowMs = DateTime.now().millisecondsSinceEpoch;
              if (dragSession.value.lastVerticalUpdateMs != 0 &&
                  nowMs - dragSession.value.lastVerticalUpdateMs < 16) {
                return;
              }
              dragSession.value.lastVerticalUpdateMs = nowMs;
              dragSession.value.verticalDelta += details.primaryDelta ?? 0;
              final isLeft =
                  details.globalPosition.dx < MediaQuery.sizeOf(context).width / 2;
              showIndicator.value = true;
              if (isLeft) {
                final newBrightness =
                    (dragSession.value.verticalStartBrightness -
                            dragSession.value.verticalDelta / kBrightnessSensitivity)
                        .clamp(0.0, 1.0);
                if ((newBrightness - dragSession.value.lastAppliedBrightness).abs() >=
                    _brightnessStep) {
                  brightness.value = newBrightness;
                  dragSession.value.lastAppliedBrightness = newBrightness;
                  unawaited(
                    ScreenBrightness().setApplicationScreenBrightness(newBrightness),
                  );
                }
                indicatorIcon.value = Icons.brightness_6_rounded;
                indicatorLabel.value = t.video.player.brightness;
                indicatorValue.value = newBrightness;
                indicatorTextValue.value = null;
              } else {
                final newVolume =
                    (dragSession.value.verticalStartVolume -
                            dragSession.value.verticalDelta / kVolumeSensitivity)
                        .clamp(0.0, 100.0);
                if ((newVolume - dragSession.value.lastAppliedVolume).abs() >=
                    _volumeStep) {
                  player.setVolume(newVolume);
                  dragSession.value.lastAppliedVolume = newVolume;
                }
                indicatorIcon.value = Icons.volume_up_rounded;
                indicatorLabel.value = t.video.player.volume;
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
            _SeekDoubleTapOverlay(
              onSeekBackward: () {
                rippleSide.value = -1;
                playerController.seek(player.state.position - const Duration(seconds: 5));
              },
              onSeekForward: () {
                rippleSide.value = 1;
                playerController.seek(player.state.position + const Duration(seconds: 5));
              },
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
