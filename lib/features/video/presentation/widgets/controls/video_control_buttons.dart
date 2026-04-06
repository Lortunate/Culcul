import 'package:culcul/features/video/presentation/view_models/danmaku_settings_view_model.dart';
import 'package:culcul/features/video/presentation/view_models/player_view_model.dart';
import 'package:culcul/features/video/presentation/view_models/playback_snapshot_view_model.dart';
import 'package:culcul/features/video/presentation/view_models/subtitle_view_model.dart';
import 'package:culcul/features/video/presentation/view_models/video_detail_view_model.dart';
import 'package:culcul/core/utils/format_extensions.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/features/video/presentation/widgets/controls/controls_utils.dart';
import 'package:culcul/features/video/presentation/widgets/controls/player_constants.dart';
import 'package:culcul/features/video/presentation/widgets/controls/player_theme.dart';
import 'package:culcul/features/video/presentation/widgets/controls/quick_selection_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    final t = Translations.of(context);
    showSidePanel(
      context,
      QuickSelectionSheet<int>(
        title: t.video.player.choose_quality,
        subtitle: t.video.player.quality_section_hint,
        items: availableQualities,
        selectedItem: selectedQuality,
        labelBuilder: (q) => qualityLabels[q] ?? t.video.quality.unknown,
        emptyText: t.video.player.quality_unavailable,
        onSelected: (q) {
          ref.read(videoDetailControllerProvider(bvid).notifier).switchQuality(q);
        },
        isBottomSheet: isPlayerBottomSheetLayout(context),
      ),
    );
  }

  void _showSpeedMenu(BuildContext context, WidgetRef ref, double currentSpeed) {
    final t = Translations.of(context);
    showSidePanel(
      context,
      QuickSelectionSheet<double>(
        title: t.video.player.choose_speed,
        subtitle: t.video.player.speed_section_hint,
        items: playbackSpeeds,
        selectedItem: currentSpeed,
        labelBuilder: formatPlaybackSpeedLabel,
        subtitleBuilder: (s) => getPlaybackSpeedDescription(s, t),
        onSelected: (s) {
          ref.read(videoDetailControllerProvider(bvid).notifier).setPlaybackSpeed(s);
        },
        isBottomSheet: isPlayerBottomSheetLayout(context),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);

    final isPlaying = ref.watch(playerControllerProvider.select((s) => s.isPlaying));
    final isFullscreen = ref.watch(
      playerControllerProvider.select((s) => s.isFullscreen),
    );

    final danmakuEnabled = ref.watch(
      danmakuSettingsControllerProvider.select((s) => s.isEnabled),
    );
    final subtitleState = ref.watch(
      subtitleControllerProvider(bvid).select(
        (s) => (isEnabled: s.isEnabled, hasSubtitles: s.availableSubtitles.isNotEmpty),
      ),
    );

    final playerController = ref.read(playerControllerProvider.notifier);

    final selectedQuality = ref.watch(
      videoDetailControllerProvider(bvid).select((s) => s.selectedQuality),
    );
    final availableQualities = ref.watch(
      videoDetailControllerProvider(bvid).select((s) => s.availableQualities),
    );
    final playbackSpeed = ref.watch(
      videoDetailControllerProvider(bvid).select((s) => s.playbackSpeed),
    );
    final playUrl = ref.watch(
      videoDetailControllerProvider(bvid).select((s) => s.playUrl),
    );
    final qualityLabels = buildQualityLabels(playUrl, t);

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
              text: formatPlaybackSpeedLabel(playbackSpeed),
              onTap: () => _showSpeedMenu(context, ref, playbackSpeed),
            ),
            const SizedBox(width: 8),
            PlayerCapsuleButton(
              text: qualityLabels[selectedQuality] ?? t.video.quality.auto,
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
              color: danmakuEnabled ? colorScheme.primary : colorScheme.onPrimary,
              size: 20,
            ),
            const SizedBox(width: 4),
            if (subtitleState.hasSubtitles) ...[
              ControlButton(
                onPressed: () {
                  ref.read(subtitleControllerProvider(bvid).notifier).toggleSubtitle();
                },
                icon: subtitleState.isEnabled
                    ? Icons.closed_caption_rounded
                    : Icons.closed_caption_off_rounded,
                color: subtitleState.isEnabled
                    ? colorScheme.primary
                    : colorScheme.onPrimary,
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

class TimeText extends ConsumerWidget {
  const TimeText({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final position = ref.watch(playbackPositionProvider);
    final duration = ref.watch(playbackDurationProvider);

    return RepaintBoundary(
      child: Text(
        '${position.inSeconds.formatDuration} / ${duration.inSeconds.formatDuration}',
        style: PlayerTheme.timeStyle(
          Theme.of(context).colorScheme,
        ).copyWith(fontSize: 10),
      ),
    );
  }
}

class ControlButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final IconData icon;
  final double size;
  final Color? color;

  const ControlButton({
    super.key,
    this.onPressed,
    required this.icon,
    required this.size,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final resolvedColor = color ?? Theme.of(context).colorScheme.onPrimary;

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
              color: resolvedColor,
              size: size,
              shadows: [
                BoxShadow(
                  color: Theme.of(context).colorScheme.shadow.withValues(alpha: 0.26),
                  blurRadius: 4,
                  spreadRadius: 1,
                ),
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
    final colorScheme = Theme.of(context).colorScheme;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(999),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeOutCubic,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: colorScheme.onPrimary.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(999),
            border: Border.all(
              color: colorScheme.onPrimary.withValues(alpha: 0.16),
              width: 1,
            ),
          ),
          child: Text(
            text,
            style: TextStyle(
              color: colorScheme.onPrimary,
              fontSize: 11,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}
