import 'package:culcul/providers/video/player_controller.dart';
import 'package:culcul/shared/extensions/format_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class VideoProgressBar extends StatelessWidget {
  const VideoProgressBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: SizedBox(
        height: 12,
        child: RepaintBoundary(
          child: Stack(
            alignment: Alignment.centerLeft,
            children: const [BufferBar(), SliderBar()],
          ),
        ),
      ),
    );
  }
}

class BufferBar extends HookConsumerWidget {
  const BufferBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final player = ref.watch(playerControllerProvider.notifier).player;
    final duration = useStream(player.stream.duration).data ?? Duration.zero;
    final bufferedPosition =
        useStream(player.stream.buffer).data ?? Duration.zero;

    final double max = duration.inMilliseconds.toDouble();
    final safeMax = max > 0 ? max : 1.0;
    final double bufferValue = bufferedPosition.inMilliseconds.toDouble().clamp(
      0.0,
      safeMax,
    );

    if (safeMax <= 1.0) return const SizedBox();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Container(
            width: constraints.maxWidth * (bufferValue / safeMax),
            height: 2,
            decoration: BoxDecoration(
              color: Colors.white30,
              borderRadius: BorderRadius.circular(1),
            ),
          );
        },
      ),
    );
  }
}

class SliderBar extends HookConsumerWidget {
  const SliderBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final player = ref.watch(playerControllerProvider.notifier).player;
    final duration = useStream(player.stream.duration).data ?? Duration.zero;
    final position = useStream(player.stream.position).data ?? Duration.zero;

    final isDragging = useState(false);
    final dragValue = useState<double?>(null);

    final double value = isDragging.value
        ? dragValue.value!
        : position.inMilliseconds.toDouble();
    final double max = duration.inMilliseconds.toDouble();
    final safeMax = max > 0 ? max : 1.0;
    final safeValue = value.clamp(0.0, safeMax);

    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        activeTrackColor: Theme.of(context).colorScheme.primary,
        inactiveTrackColor: Colors.transparent,
        thumbColor: Theme.of(context).colorScheme.primary,
        thumbShape: const RoundSliderThumbShape(
          enabledThumbRadius: 8,
          elevation: 2,
        ),
        overlayShape: const RoundSliderOverlayShape(overlayRadius: 14),
        trackHeight: 2,
        showValueIndicator: ShowValueIndicator.always,
        valueIndicatorTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 12,
        ),
        valueIndicatorColor: Theme.of(context).colorScheme.primary,
      ),
      child: Slider(
        value: safeValue,
        min: 0.0,
        max: safeMax,
        label: Duration(milliseconds: safeValue.toInt()).formatDuration,
        onChanged: (val) {
          isDragging.value = true;
          dragValue.value = val;
        },
        onChangeEnd: (val) {
          ref
              .read(playerControllerProvider.notifier)
              .seek(Duration(milliseconds: val.toInt()));
          isDragging.value = false;
          dragValue.value = null;
        },
      ),
    );
  }
}
