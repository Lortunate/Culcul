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
    final t = context.t;
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
            Positioned.fill(
              child: GestureDetector(
                onDoubleTapDown: (details) {
                  final screenWidth = MediaQuery.sizeOf(context).width;
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
            _SeekRippleOverlay(
              isForward: rippleSide.value > 0,
              onAnimationComplete: () => rippleSide.value = 0,
            ),
          _GestureFeedbackOverlay(
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

class _GestureFeedbackOverlay extends HookWidget {
  const _GestureFeedbackOverlay({
    required this.showIndicator,
    required this.indicatorIcon,
    required this.indicatorLabel,
    required this.indicatorValue,
    required this.indicatorTextValue,
  });

  final ValueNotifier<bool> showIndicator;
  final ValueNotifier<IconData> indicatorIcon;
  final ValueNotifier<String> indicatorLabel;
  final ValueNotifier<double?> indicatorValue;
  final ValueNotifier<String?> indicatorTextValue;

  @override
  Widget build(BuildContext context) {
    final show = useValueListenable(showIndicator);
    final icon = useValueListenable(indicatorIcon);
    final label = useValueListenable(indicatorLabel);
    final value = useValueListenable(indicatorValue);
    final textValue = useValueListenable(indicatorTextValue);

    if (!show) return const SizedBox();

    final colorScheme = Theme.of(context).colorScheme;
    final blurEnabled = PerformancePolicyController.notifier.value.blurEnabled;
    const borderRadius = BorderRadius.all(CulculRadius.radiusLg);

    final content = Container(
      padding: const EdgeInsets.symmetric(
        horizontal: CulculSpacing.xl,
        vertical: CulculSpacing.lg,
      ),
      decoration: BoxDecoration(
        color: colorScheme.scrim.withValues(alpha: blurEnabled ? 0.5 : 0.7),
        borderRadius: borderRadius,
        border: Border.all(
          color: colorScheme.onPrimary.withValues(alpha: 0.1),
          width: 0.5,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: colorScheme.onPrimary,
            size: 36,
            shadows: [
              Shadow(
                blurRadius: 8,
                color: colorScheme.shadow.withValues(alpha: 0.26),
                offset: const Offset(0, 2),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            label,
            style: TextStyle(
              color: colorScheme.onPrimary,
              fontSize: 15,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
              decoration: TextDecoration.none,
              shadows: [
                Shadow(
                  blurRadius: 4,
                  color: colorScheme.shadow.withValues(alpha: 0.45),
                  offset: const Offset(0, 1),
                ),
              ],
            ),
          ),
          if (textValue != null) ...[
            const SizedBox(height: 8),
            Text(
              textValue,
              style: TextStyle(
                color: colorScheme.onPrimary.withValues(alpha: 0.7),
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
          if (value != null) ...[
            const SizedBox(height: 16),
            SizedBox(
              width: 80,
              height: 6,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(CulculRadius.xs),
                child: LinearProgressIndicator(
                  value: value,
                  backgroundColor: colorScheme.onPrimary.withValues(alpha: 0.15),
                  valueColor: AlwaysStoppedAnimation<Color>(colorScheme.onPrimary),
                ),
              ),
            ),
          ],
        ],
      ),
    );

    if (!blurEnabled) {
      return Center(child: content);
    }

    return Center(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          boxShadow: [
            BoxShadow(
              color: colorScheme.shadow.withValues(alpha: 0.3),
              blurRadius: 32,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: borderRadius,
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 32, sigmaY: 32),
            child: content,
          ),
        ),
      ),
    );
  }
}

class _SeekRippleOverlay extends HookWidget {
  final bool isForward;
  final VoidCallback onAnimationComplete;

  const _SeekRippleOverlay({required this.isForward, required this.onAnimationComplete});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final controller = useAnimationController(
      duration: const Duration(milliseconds: 600),
    );

    useEffect(() {
      controller.forward().then((_) => onAnimationComplete());
      return null;
    }, const []);

    return ClipPath(
      clipper: _RippleClipper(isForward: isForward),
      child: FadeTransition(
        opacity: Tween<double>(begin: 1.0, end: 0.0).animate(controller),
        child: Container(
          color: colorScheme.onPrimary.withValues(alpha: 0.2),
          alignment: isForward ? Alignment.centerRight : Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(
            horizontal: CulculSpacing.xl + CulculSpacing.xs,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                isForward ? Icons.fast_forward_rounded : Icons.fast_rewind_rounded,
                color: colorScheme.onPrimary,
                size: 40,
              ),
              const SizedBox(height: CulculSpacing.xs),
              Text(
                '10s',
                style: TextStyle(
                  color: colorScheme.onPrimary,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RippleClipper extends CustomClipper<Path> {
  final bool isForward;

  _RippleClipper({required this.isForward});

  @override
  Path getClip(Size size) {
    final path = Path();
    if (isForward) {
      path.moveTo(size.width, 0);
      path.lineTo(size.width, size.height);
      path.quadraticBezierTo(size.width * 0.6, size.height / 2, size.width, 0);
    } else {
      path.moveTo(0, 0);
      path.lineTo(0, size.height);
      path.quadraticBezierTo(size.width * 0.4, size.height / 2, 0, 0);
    }
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
