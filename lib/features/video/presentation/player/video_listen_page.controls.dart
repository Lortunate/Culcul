part of 'video_listen_page.dart';

class _ProgressBar extends HookConsumerWidget {
  const _ProgressBar();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final position = ref.watch(playbackPositionProvider);
    final duration = ref.watch(playbackDurationProvider);
    final playerController = ref.read(playerControllerProvider.notifier);
    final colorScheme = Theme.of(context).colorScheme;
    final draggingValue = useState<double?>(null);

    final maxDuration = duration.inMilliseconds.toDouble();
    final validMax = maxDuration > 0 ? maxDuration : 1.0;
    final currentValue = (draggingValue.value ?? position.inMilliseconds.toDouble())
        .clamp(0.0, validMax);

    final textStyle = TextStyle(
      color: colorScheme.onPrimary.withValues(alpha: 0.5),
      fontSize: 12,
    );

    return Column(
      children: [
        SliderTheme(
          data: PlayerTheme.progressSliderTheme(
            context,
          ).copyWith(thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6)),
          child: Slider(
            value: currentValue,
            max: validMax,
            onChanged: (value) => draggingValue.value = value,
            onChangeEnd: (value) {
              draggingValue.value = null;
              playerController.seek(Duration(milliseconds: value.toInt()));
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(position.formatDuration, style: textStyle),
              Text(duration.formatDuration, style: textStyle),
            ],
          ),
        ),
      ],
    );
  }
}

class _PlaybackControls extends ConsumerWidget {
  const _PlaybackControls();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isPlaying = ref.watch(playerControllerProvider.select((s) => s.isPlaying));
    final playerController = ref.read(playerControllerProvider.notifier);
    final colorScheme = Theme.of(context).colorScheme;
    final onPrimary = colorScheme.onPrimary;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.repeat_rounded, color: onPrimary.withValues(alpha: 0.5)),
        ),
        IconButton(
          onPressed: () {
            final position = ref.read(playbackPositionProvider);
            final newPos = position - const Duration(seconds: 10);
            playerController.seek(newPos < Duration.zero ? Duration.zero : newPos);
          },
          icon: Icon(Icons.replay_10_rounded, color: onPrimary, size: 28),
        ),
        Container(
          width: 72,
          height: 72,
          decoration: BoxDecoration(color: colorScheme.primary, shape: BoxShape.circle),
          child: IconButton(
            onPressed: playerController.playOrPause,
            icon: Icon(
              isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
              color: onPrimary,
              size: 36,
            ),
          ),
        ),
        IconButton(
          onPressed: () {
            final position = ref.read(playbackPositionProvider);
            final duration = ref.read(playbackDurationProvider);
            final newPos = position + const Duration(seconds: 10);
            playerController.seek(newPos > duration ? duration : newPos);
          },
          icon: Icon(Icons.forward_10_rounded, color: onPrimary, size: 28),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.playlist_play_rounded,
            color: onPrimary.withValues(alpha: 0.5),
          ),
        ),
      ],
    );
  }
}
