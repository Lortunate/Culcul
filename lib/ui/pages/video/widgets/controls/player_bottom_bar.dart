import 'package:culcul/providers/video/danmaku_settings_provider.dart';
import 'package:culcul/providers/video/player_controller.dart';
import 'package:culcul/providers/video/subtitle_controller.dart';
import 'package:culcul/providers/video/video_detail_controller.dart';
import 'package:culcul/shared/extensions/format_extensions.dart';
import 'package:culcul/ui/pages/video/widgets/controls/controls_utils.dart';
import 'package:culcul/ui/pages/video/widgets/controls/player_theme.dart';
import 'package:culcul/ui/pages/video/widgets/controls/quick_selection_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PlayerBottomBar extends ConsumerWidget {
  final String bvid;
  final VoidCallback? onNext;
  final VoidCallback? onToggleFullscreen;

  const PlayerBottomBar({
    super.key,
    required this.bvid,
    this.onNext,
    this.onToggleFullscreen,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const _VideoProgressBar(),
        _VideoControlButtons(
          bvid: bvid,
          onNext: onNext,
          onToggleFullscreen: onToggleFullscreen,
        ),
      ],
    );
  }
}

class _VideoProgressBar extends StatelessWidget {
  const _VideoProgressBar();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: SizedBox(
        height: 12,
        child: Stack(
          alignment: Alignment.centerLeft,
          children: const [
            _BufferBar(),
            _SliderBar(),
          ],
        ),
      ),
    );
  }
}

class _BufferBar extends ConsumerWidget {
  const _BufferBar();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final duration = ref.watch(
      playerControllerProvider.select((s) => s.duration),
    );
    final bufferedPosition = ref.watch(
      playerControllerProvider.select((s) => s.buffer),
    );

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

class _SliderBar extends ConsumerStatefulWidget {
  const _SliderBar();

  @override
  ConsumerState<_SliderBar> createState() => _SliderBarState();
}

class _SliderBarState extends ConsumerState<_SliderBar> {
  double? _dragValue;
  bool _isDragging = false;

  @override
  Widget build(BuildContext context) {
    final position = ref.watch(
      playerControllerProvider.select((s) => s.position),
    );
    final duration = ref.watch(
      playerControllerProvider.select((s) => s.duration),
    );

    final double value = _isDragging
        ? _dragValue!
        : position.inMilliseconds.toDouble();
    final double max = duration.inMilliseconds.toDouble();
    final safeMax = max > 0 ? max : 1.0;
    final safeValue = value.clamp(0.0, safeMax);

    return SliderTheme(
      data: PlayerTheme.sliderTheme.copyWith(
        inactiveTrackColor: Colors.transparent,
        thumbShape: const RoundSliderThumbShape(
          enabledThumbRadius: 8,
          elevation: 2,
        ),
        overlayShape: const RoundSliderOverlayShape(overlayRadius: 14),
        trackHeight: 2,
      ),
      child: Slider(
        value: safeValue,
        min: 0.0,
        max: safeMax,
        onChanged: (val) {
          setState(() {
            _isDragging = true;
            _dragValue = val;
          });
        },
        onChangeEnd: (val) {
          ref
              .read(playerControllerProvider.notifier)
              .seek(Duration(milliseconds: val.toInt()));
          setState(() {
            _isDragging = false;
            _dragValue = null;
          });
        },
      ),
    );
  }
}

class _VideoControlButtons extends ConsumerWidget {
  final String bvid;
  final VoidCallback? onNext;
  final VoidCallback? onToggleFullscreen;

  const _VideoControlButtons({
    required this.bvid,
    this.onNext,
    this.onToggleFullscreen,
  });

  void _showQualityMenu(
    BuildContext context,
    WidgetRef ref,
    int selectedQuality,
    List<int> availableQualities,
    Map<int, String> qualityLabels,
  ) {
    showSidePanel(
      context,
      QuickSelectionSheet<int>(
        title: '选择画质',
        items: availableQualities,
        selectedItem: selectedQuality,
        labelBuilder: (q) => qualityLabels[q] ?? '未知',
        onSelected: (q) {
          ref
              .read(videoDetailControllerProvider(bvid).notifier)
              .switchQuality(q);
        },
        isBottomSheet:
            MediaQuery.of(context).orientation == Orientation.portrait,
      ),
    );
  }

  void _showSpeedMenu(
    BuildContext context,
    WidgetRef ref,
    double currentSpeed,
  ) {
    const speeds = [0.5, 0.75, 1.0, 1.25, 1.5, 2.0];
    showSidePanel(
      context,
      QuickSelectionSheet<double>(
        title: '播放速度',
        items: speeds,
        selectedItem: currentSpeed,
        labelBuilder: (s) => '${s}x',
        onSelected: (s) {
          ref
              .read(videoDetailControllerProvider(bvid).notifier)
              .setPlaybackSpeed(s);
          ref.read(playerControllerProvider.notifier).player.setRate(s);
        },
        isBottomSheet:
            MediaQuery.of(context).orientation == Orientation.portrait,
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;

    final isPlaying = ref.watch(
      playerControllerProvider.select((s) => s.isPlaying),
    );
    final isFullscreen = ref.watch(
      playerControllerProvider.select((s) => s.isFullscreen),
    );

    final danmakuEnabled = ref.watch(
      danmakuSettingsControllerProvider.select((s) => s.isEnabled),
    );
    final subtitleState = ref.watch(subtitleControllerProvider(bvid));
    final videoDetailState = ref.watch(videoDetailControllerProvider(bvid));

    final playerController = ref.read(playerControllerProvider.notifier);

    final selectedQuality = videoDetailState.selectedQuality;
    final availableQualities = videoDetailState.availableQualities;
    final playbackSpeed = videoDetailState.playbackSpeed;

    final qualityLabels = <int, String>{};
    if (videoDetailState.playUrl != null) {
      final qualities = videoDetailState.playUrl!.acceptQuality;
      final descs = videoDetailState.playUrl!.acceptDescription;
      for (int i = 0; i < qualities.length && i < descs.length; i++) {
        qualityLabels[qualities[i]] = descs[i];
      }
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 0, 12, 8),
      child: Row(
        children: [
          _ControlButton(
            onPressed: playerController.playOrPause,
            icon: isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
            size: 28,
          ),
          if (onNext != null) ...[
            const SizedBox(width: 4),
            _ControlButton(
              onPressed: onNext,
              icon: Icons.skip_next_rounded,
              size: 24,
            ),
          ],
          const SizedBox(width: 8),
          const _TimeText(),
          const Spacer(),
          if (isFullscreen) ...[
            _PlayerCapsuleButton(
              text: '${playbackSpeed}X',
              onTap: () => _showSpeedMenu(context, ref, playbackSpeed),
            ),
            const SizedBox(width: 8),
            _PlayerCapsuleButton(
              text: qualityLabels[selectedQuality] ?? '自动',
              onTap: () => _showQualityMenu(
                context,
                ref,
                selectedQuality,
                availableQualities,
                qualityLabels,
              ),
            ),
            const SizedBox(width: 8),
            _ControlButton(
              onPressed: () {
                ref
                    .read(danmakuSettingsControllerProvider.notifier)
                    .setEnabled(!danmakuEnabled);
              },
              icon: danmakuEnabled ? Icons.notes_rounded : Icons.notes_outlined,
              color: danmakuEnabled ? colorScheme.primary : Colors.white,
              size: 20,
            ),
            const SizedBox(width: 4),
            if (subtitleState.availableSubtitles.isNotEmpty) ...[
              _ControlButton(
                onPressed: () {
                  ref
                      .read(subtitleControllerProvider(bvid).notifier)
                      .toggleSubtitle();
                },
                icon: subtitleState.isEnabled
                    ? Icons.closed_caption_rounded
                    : Icons.closed_caption_off_rounded,
                color: subtitleState.isEnabled
                    ? colorScheme.primary
                    : Colors.white,
                size: 20,
              ),
              const SizedBox(width: 4),
            ],
          ],
          _ControlButton(
            onPressed: onToggleFullscreen ?? playerController.toggleFullscreen,
            icon: isFullscreen
                ? Icons.fullscreen_exit_rounded
                : Icons.fullscreen_rounded,
            size: 26,
          ),
        ],
      ),
    );
  }
}

class _TimeText extends ConsumerWidget {
  const _TimeText();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final position = ref.watch(
      playerControllerProvider.select((s) => s.position),
    );
    final duration = ref.watch(
      playerControllerProvider.select((s) => s.duration),
    );

    return Text(
      '${position.inSeconds.formatDuration} / ${duration.inSeconds.formatDuration}',
      style: PlayerTheme.timeStyle.copyWith(fontSize: 10),
    );
  }
}

class _ControlButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final IconData icon;
  final double size;
  final Color color;

  const _ControlButton({
    this.onPressed,
    required this.icon,
    required this.size,
    this.color = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          if (onPressed != null) {
            HapticFeedback.lightImpact();
            onPressed!();
          }
        },
        borderRadius: BorderRadius.circular(size),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            child: Icon(
              icon,
              key: ValueKey(icon),
              color: color,
              size: size,
              shadows: const [
                BoxShadow(color: Colors.black26, blurRadius: 4, spreadRadius: 1),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PlayerCapsuleButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const _PlayerCapsuleButton({required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(4),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: Colors.white24, width: 1),
          ),
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 11,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
