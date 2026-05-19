part of 'video_control_buttons.dart';

class _PlayPauseControlButton extends ConsumerWidget {
  const _PlayPauseControlButton();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isPlaying = ref.watch(playerControllerProvider.select((s) => s.isPlaying));
    final playerController = ref.read(playerControllerProvider.notifier);
    return ControlButton(
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
    return PlayerCapsuleButton(
      text: formatPlaybackSpeedLabel(playbackSpeed),
      onTap: () {
        showSidePanel(
          context,
          QuickSelectionSheet<double>(
            title: t.video.player.choose_speed,
            subtitle: t.video.player.speed_section_hint,
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
    return PlayerCapsuleButton(
      text: qualityLabels[qualityState.selectedQuality] ?? t.video.quality.auto,
      onTap: () {
        showSidePanel(
          context,
          QuickSelectionSheet<int>(
            title: t.video.player.choose_quality,
            subtitle: t.video.player.quality_section_hint,
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
    return ControlButton(
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
        ControlButton(
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
    return ControlButton(
      onPressed: onToggleFullscreen ?? playerController.toggleFullscreen,
      icon: isFullscreen ? Icons.fullscreen_exit_rounded : Icons.fullscreen_rounded,
      size: 26,
    );
  }
}
