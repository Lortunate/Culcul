import 'package:culcul/features/video/controllers/player_controller.dart';
import 'package:culcul/features/video/controllers/playback_snapshot_controller.dart';
import 'package:culcul/core/utils/format_extensions.dart';
import 'package:culcul/features/video/presentation/widgets/controls/player_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class VideoProgressBar extends HookConsumerWidget {
  const VideoProgressBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final duration = ref.watch(playbackDurationProvider);
    final position = ref.watch(playbackPositionProvider);
    final buffer = ref.watch(playbackBufferProvider);
    final playerController = ref.read(playerControllerProvider.notifier);

    final isDragging = useState(false);
    final dragValue = useState<double?>(null);

    final max = duration.inMilliseconds.toDouble();
    final safeMax = max > 0 ? max : 1.0;
    final positionMs = position.inMilliseconds.toDouble();
    final rawValue = isDragging.value ? (dragValue.value ?? positionMs) : positionMs;
    final safeValue = rawValue.clamp(0.0, safeMax);
    final safeBufferValue = buffer.inMilliseconds.toDouble().clamp(0.0, safeMax);
    final sliderTheme = PlayerTheme.progressSliderTheme(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: SizedBox(
        height: 16,
        child: RepaintBoundary(
          child: SliderTheme(
            data: sliderTheme,
            child: Slider(
              value: safeValue,
              secondaryTrackValue: safeBufferValue,
              min: 0.0,
              max: safeMax,
              label: Duration(milliseconds: safeValue.toInt()).formatDuration,
              onChanged: max <= 0
                  ? null
                  : (val) {
                      isDragging.value = true;
                      dragValue.value = val;
                    },
              onChangeEnd: max <= 0
                  ? null
                  : (val) {
                      isDragging.value = false;
                      dragValue.value = null;
                      playerController.seek(Duration(milliseconds: val.toInt()));
                    },
            ),
          ),
        ),
      ),
    );
  }
}

