import 'package:culcul/features/video/controllers/danmaku_settings_controller.dart';
import 'package:culcul/features/video/controllers/player_controller.dart';
import 'package:culcul/features/video/controllers/subtitle_controller.dart';
import 'package:culcul/features/video/controllers/video_detail_controller.dart';
import 'package:culcul/shared/format_extensions.dart';
import 'package:culcul/features/video/presentation/widgets/controls/controls_utils.dart';
import 'package:culcul/features/video/presentation/widgets/controls/player_theme.dart';
import 'package:culcul/features/video/presentation/widgets/controls/quick_selection_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class VideoControlButtons extends ConsumerWidget {
  final String bvid;
  final VoidCallback? onNext;
  final VoidCallback? onToggleFullscreen;

  const VideoControlButtons({
    super.key,
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
          ref.read(videoDetailControllerProvider(bvid).notifier).switchQuality(q);
        },
        isBottomSheet: MediaQuery.of(context).orientation == Orientation.portrait,
      ),
    );
  }

  void _showSpeedMenu(BuildContext context, WidgetRef ref, double currentSpeed) {
    const speeds = [0.5, 0.75, 1.0, 1.25, 1.5, 2.0];
    showSidePanel(
      context,
      QuickSelectionSheet<double>(
        title: '播放速度',
        items: speeds,
        selectedItem: currentSpeed,
        labelBuilder: (s) => '${s}x',
        onSelected: (s) {
          ref.read(videoDetailControllerProvider(bvid).notifier).setPlaybackSpeed(s);
          ref.read(playerControllerProvider.notifier).player.setRate(s);
        },
        isBottomSheet: MediaQuery.of(context).orientation == Orientation.portrait,
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;

    final isPlaying = ref.watch(playerControllerProvider.select((s) => s.isPlaying));
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
          ControlButton(
            onPressed: playerController.playOrPause,
            icon: isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
            size: 28,
          ),
          if (onNext != null) ...[
            const SizedBox(width: 4),
            ControlButton(onPressed: onNext, icon: Icons.skip_next_rounded, size: 24),
          ],
          const SizedBox(width: 8),
          const TimeText(),
          const Spacer(),
          if (isFullscreen) ...[
            PlayerCapsuleButton(
              text: '${playbackSpeed}X',
              onTap: () => _showSpeedMenu(context, ref, playbackSpeed),
            ),
            const SizedBox(width: 8),
            PlayerCapsuleButton(
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
            ControlButton(
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
              ControlButton(
                onPressed: () {
                  ref.read(subtitleControllerProvider(bvid).notifier).toggleSubtitle();
                },
                icon: subtitleState.isEnabled
                    ? Icons.closed_caption_rounded
                    : Icons.closed_caption_off_rounded,
                color: subtitleState.isEnabled ? colorScheme.primary : Colors.white,
                size: 20,
              ),
              const SizedBox(width: 4),
            ],
          ],
          ControlButton(
            onPressed: onToggleFullscreen ?? playerController.toggleFullscreen,
            icon: isFullscreen ? Icons.fullscreen_exit_rounded : Icons.fullscreen_rounded,
            size: 26,
          ),
        ],
      ),
    );
  }
}

class TimeText extends HookConsumerWidget {
  const TimeText({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final player = ref.watch(playerControllerProvider.notifier).player;
    final position = useStream(player.stream.position).data ?? Duration.zero;
    final duration = useStream(player.stream.duration).data ?? Duration.zero;

    return RepaintBoundary(
      child: Text(
        '${position.inSeconds.formatDuration} / ${duration.inSeconds.formatDuration}',
        style: PlayerTheme.timeStyle.copyWith(fontSize: 10),
      ),
    );
  }
}

class ControlButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final IconData icon;
  final double size;
  final Color color;

  const ControlButton({
    super.key,
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

class PlayerCapsuleButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const PlayerCapsuleButton({super.key, required this.text, required this.onTap});

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
