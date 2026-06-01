import 'package:culcul/core/utils/format_extensions.dart';
import 'package:culcul/features/video/presentation/overlays/danmaku_settings_view_model.dart';
import 'package:culcul/features/video/presentation/player/playback_snapshot_view_model.dart';
import 'package:culcul/features/video/presentation/player/player_view_model.dart';
import 'package:culcul/features/video/presentation/overlays/subtitle_view_model.dart';
import 'package:culcul/features/video/presentation/detail/video_detail_view_model.dart';
import 'package:culcul/features/video/presentation/player/controls/player_constants.dart';
import 'package:culcul/features/video/presentation/player/controls/player_theme.dart';
import 'package:culcul/features/video/presentation/player/controls/quick_selection_sheet.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/ui/theme/culcul_tokens.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

bool isPlayerBottomSheetLayout(BuildContext context) =>
    MediaQuery.orientationOf(context) == Orientation.portrait;

void showPlayerSidePanel(BuildContext context, Widget child) {
  final isLandscape = !isPlayerBottomSheetLayout(context);

  if (isLandscape) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Selection',
      barrierColor: Theme.of(context).colorScheme.scrim.withValues(alpha: 0.45),
      transitionDuration: CulculMotion.standard,
      pageBuilder: (context, animation, secondaryAnimation) {
        return Align(alignment: Alignment.centerRight, child: child);
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1, 0),
            end: Offset.zero,
          ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOutQuart)),
          child: child,
        );
      },
    );
  } else {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => child,
    );
  }
}

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

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isFullscreen = ref.watch(
      playerControllerProvider.select((s) => s.isFullscreen),
    );

    return Padding(
      padding: const EdgeInsets.fromLTRB(
        CulculSpacing.sm,
        0,
        CulculSpacing.sm,
        CulculSpacing.xs,
      ),
      child: Row(
        children: [
          const _PlayPauseControlButton(),
          if (onNext != null) ...[
            const SizedBox(width: CulculSpacing.xxs),
            _ControlButton(onPressed: onNext, icon: Icons.skip_next_rounded, size: 24),
          ],
          const SizedBox(width: CulculSpacing.xs),
          const _TimeText(),
          const Spacer(),
          if (isFullscreen) ...[
            _PlaybackSpeedButton(bvid: bvid),
            const SizedBox(width: CulculSpacing.xs),
            _PlaybackQualityButton(bvid: bvid),
            const SizedBox(width: CulculSpacing.xs),
            const _DanmakuToggleButton(),
            const SizedBox(width: CulculSpacing.xxs),
            _SubtitleToggleButton(bvid: bvid),
          ],
          _FullscreenToggleButton(onToggleFullscreen: onToggleFullscreen),
        ],
      ),
    );
  }
}

class _PlayPauseControlButton extends ConsumerWidget {
  const _PlayPauseControlButton();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isPlaying = ref.watch(playerControllerProvider.select((s) => s.isPlaying));
    final playerController = ref.read(playerControllerProvider.notifier);
    return _ControlButton(
      onPressed: playerController.playOrPause,
      icon: isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
      size: 28,
    );
  }
}

class _PlaybackSpeedButton extends ConsumerWidget {
  final String bvid;

  const _PlaybackSpeedButton({required this.bvid});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playbackSpeed = ref.watch(
      videoDetailControllerProvider(bvid).select((s) => s.playbackSpeed),
    );
    final t = Translations.of(context);
    return _PlayerCapsuleButton(
      text: formatPlaybackSpeedLabel(playbackSpeed),
      onTap: () {
        showPlayerSidePanel(
          context,
          QuickSelectionSheet<double>(
            items: playbackSpeeds,
            selectedItem: playbackSpeed,
            labelBuilder: formatPlaybackSpeedLabel,
            subtitleBuilder: (s) => getPlaybackSpeedDescription(s, t),
            onSelected: (s) {
              ref.read(videoDetailControllerProvider(bvid).notifier).setPlaybackSpeed(s);
            },
            isBottomSheet: isPlayerBottomSheetLayout(context),
          ),
        );
      },
    );
  }
}

class _PlaybackQualityButton extends ConsumerWidget {
  final String bvid;

  const _PlaybackQualityButton({required this.bvid});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = Translations.of(context);
    final qualityState = ref.watch(
      videoDetailControllerProvider(bvid).select(
        (s) => (
          selectedQuality: s.selectedQuality,
          availableQualities: s.availableQualities,
          playUrl: s.playUrl,
        ),
      ),
    );
    final qualityLabels = buildQualityLabels(qualityState.playUrl, t);
    return _PlayerCapsuleButton(
      text: qualityLabels[qualityState.selectedQuality] ?? t.video.quality.auto,
      onTap: () {
        showPlayerSidePanel(
          context,
          QuickSelectionSheet<int>(
            items: qualityState.availableQualities,
            selectedItem: qualityState.selectedQuality,
            labelBuilder: (q) => qualityLabels[q] ?? t.video.quality.unknown,
            emptyText: t.video.player.quality_unavailable,
            onSelected: (q) {
              ref.read(videoDetailControllerProvider(bvid).notifier).switchQuality(q);
            },
            isBottomSheet: isPlayerBottomSheetLayout(context),
          ),
        );
      },
    );
  }
}

class _DanmakuToggleButton extends ConsumerWidget {
  const _DanmakuToggleButton();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final danmakuEnabled = ref.watch(
      danmakuSettingsControllerProvider.select((s) => s.isEnabled),
    );
    return _ControlButton(
      onPressed: () {
        ref.read(danmakuSettingsControllerProvider.notifier).setEnabled(!danmakuEnabled);
      },
      icon: danmakuEnabled ? Icons.notes_rounded : Icons.notes_outlined,
      color: danmakuEnabled ? colorScheme.primary : colorScheme.onPrimary,
      size: 20,
    );
  }
}

class _SubtitleToggleButton extends ConsumerWidget {
  final String bvid;

  const _SubtitleToggleButton({required this.bvid});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final subtitleState = ref.watch(
      subtitleControllerProvider(bvid).select(
        (s) => (isEnabled: s.isEnabled, hasSubtitles: s.availableSubtitles.isNotEmpty),
      ),
    );
    if (!subtitleState.hasSubtitles) {
      return const SizedBox.shrink();
    }
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _ControlButton(
          onPressed: () {
            ref.read(subtitleControllerProvider(bvid).notifier).toggleSubtitle();
          },
          icon: subtitleState.isEnabled
              ? Icons.closed_caption_rounded
              : Icons.closed_caption_off_rounded,
          color: subtitleState.isEnabled ? colorScheme.primary : colorScheme.onPrimary,
          size: 20,
        ),
        const SizedBox(width: 4),
      ],
    );
  }
}

class _FullscreenToggleButton extends ConsumerWidget {
  final VoidCallback? onToggleFullscreen;

  const _FullscreenToggleButton({required this.onToggleFullscreen});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isFullscreen = ref.watch(
      playerControllerProvider.select((s) => s.isFullscreen),
    );
    final playerController = ref.read(playerControllerProvider.notifier);
    return _ControlButton(
      onPressed: onToggleFullscreen ?? playerController.toggleFullscreen,
      icon: isFullscreen ? Icons.fullscreen_exit_rounded : Icons.fullscreen_rounded,
      size: 26,
    );
  }
}

class _TimeText extends ConsumerWidget {
  const _TimeText();

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

class _ControlButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final IconData icon;
  final double size;
  final Color? color;

  const _ControlButton({
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
          padding: const EdgeInsets.all(CulculSpacing.xs),
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

class _PlayerCapsuleButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const _PlayerCapsuleButton({required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(999),
        child: AnimatedContainer(
          duration: CulculMotion.fast,
          curve: Curves.easeOutCubic,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: colorScheme.onPrimary.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(999),
            border: Border.all(color: colorScheme.onPrimary.withValues(alpha: 0.16)),
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
