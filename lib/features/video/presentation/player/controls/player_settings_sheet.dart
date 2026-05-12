import 'package:culcul/features/video/presentation/overlays/danmaku_settings_view_model.dart';
import 'package:culcul/features/video/presentation/detail/video_detail_view_model.dart';
import 'package:culcul/features/video/presentation/player/controls/player_constants.dart';
import 'package:culcul/features/video/presentation/player/controls/player_panel.dart';
import 'package:culcul/features/video/presentation/player/controls/video_overlay_styles.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

part 'player_settings_sheet.options.dart';
part 'player_settings_sheet.danmaku.dart';

const double _settingsSectionOutlineAlpha = 0.18;
const double _settingsSectionCornerRadius = 16;

Color _settingsSectionBackground(ColorScheme colorScheme) =>
    colorScheme.scrim.withValues(alpha: 0.82);

class PlayerSettingsSheet extends ConsumerWidget {
  final String bvid;
  final bool isBottomSheet;

  const PlayerSettingsSheet({super.key, required this.bvid, this.isBottomSheet = false});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
    final colorScheme = Theme.of(context).colorScheme;
    final bottomPadding = MediaQuery.paddingOf(context).bottom;
    final settingsSectionBackground = _settingsSectionBackground(colorScheme);

    final danmakuSettings = ref.watch(danmakuSettingsControllerProvider);
    final danmakuNotifier = ref.read(danmakuSettingsControllerProvider.notifier);

    final videoDetailState = ref.watch(videoDetailControllerProvider(bvid));
    final videoDetailNotifier = ref.read(videoDetailControllerProvider(bvid).notifier);

    final availableQualities = videoDetailState.availableQualities;
    final qualityLabels = buildQualityLabels(videoDetailState.playUrl, t);

    final danmakuFilters = [
      (
        t.video.player.danmaku_type_scroll,
        danmakuSettings.showScroll,
        danmakuNotifier.toggleScroll,
      ),
      (
        t.video.player.danmaku_type_top,
        danmakuSettings.showTop,
        danmakuNotifier.toggleTop,
      ),
      (
        t.video.player.danmaku_type_bottom,
        danmakuSettings.showBottom,
        danmakuNotifier.toggleBottom,
      ),
      (
        t.video.player.danmaku_type_color,
        danmakuSettings.showColor,
        danmakuNotifier.toggleColor,
      ),
    ];

    return PlayerPanelScaffold(
      title: t.video.player.panel_title,
      subtitle: t.video.player.panel_subtitle,
      isBottomSheet: isBottomSheet,
      panelWidth: 380,
      maxHeightFactor: 0.82,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.fromLTRB(16, 16, 16, isBottomSheet ? bottomPadding + 16 : 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _InlineTextOptionSection<double>(
              title: t.video.player.choose_speed,
              items: playbackSpeeds,
              selectedItem: videoDetailState.playbackSpeed,
              labelBuilder: formatPlaybackSpeedLabel,
              onSelected: videoDetailNotifier.setPlaybackSpeed,
            ),
            const SizedBox(height: 12),
            _InlineTextOptionSection<int>(
              title: t.video.player.choose_quality,
              items: availableQualities,
              selectedItem: videoDetailState.selectedQuality,
              labelBuilder: (q) => qualityLabels[q] ?? getQualityLabel(q, t),
              onSelected: videoDetailNotifier.switchQuality,
              emptyLabel: t.video.player.quality_unavailable,
            ),
            const SizedBox(height: 12),
            PlayerPanelSection(
              title: t.video.player.danmaku_settings,
              subtitle: t.video.player.danmaku_section_hint,
              dense: true,
              showBody: danmakuSettings.isEnabled,
              backgroundColor: settingsSectionBackground,
              outlineAlpha: _settingsSectionOutlineAlpha,
              cornerRadius: _settingsSectionCornerRadius,
              trailing: Switch.adaptive(
                value: danmakuSettings.isEnabled,
                onChanged: danmakuNotifier.setEnabled,
              ),
              child: SliderTheme(
                data: SliderThemeData(
                  trackHeight: 2.8,
                  thumbShape: const RoundSliderThumbShape(
                    enabledThumbRadius: 5.5,
                    elevation: 0,
                  ),
                  overlayShape: const RoundSliderOverlayShape(overlayRadius: 10),
                  activeTrackColor: colorScheme.primary.withValues(alpha: 0.92),
                  inactiveTrackColor: VideoOverlayStyles.panelOutline(
                    colorScheme,
                    alpha: 0.18,
                  ),
                  thumbColor: colorScheme.primary,
                  overlayColor: colorScheme.primary.withValues(alpha: 0.1),
                ),
                child: Column(
                  children: [
                    _DanmakuSliderRow(
                      label: t.video.player.danmaku_opacity,
                      value: danmakuSettings.opacity,
                      min: 0.1,
                      max: 1.0,
                      divisions: 9,
                      onChanged: danmakuNotifier.setOpacity,
                    ),
                    const SizedBox(height: 8),
                    _DanmakuSliderRow(
                      label: t.video.player.danmaku_scale,
                      value: danmakuSettings.fontSizeScale,
                      min: 0.5,
                      max: 2.0,
                      divisions: 15,
                      onChanged: danmakuNotifier.setFontSizeScale,
                    ),
                    const SizedBox(height: 8),
                    _DanmakuSliderRow(
                      label: t.video.player.danmaku_area,
                      value: danmakuSettings.area,
                      min: 0.25,
                      max: 1.0,
                      divisions: 3,
                      onChanged: danmakuNotifier.setArea,
                    ),
                    const SizedBox(height: 8),
                    _DanmakuSliderRow(
                      label: t.video.player.danmaku_speed,
                      value: danmakuSettings.speed,
                      min: 0.5,
                      max: 2.0,
                      divisions: 6,
                      onChanged: danmakuNotifier.setSpeed,
                    ),
                    const SizedBox(height: 12),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        child: Row(
                          children: [
                            for (var i = 0; i < danmakuFilters.length; i++) ...[
                              PlayerFilterChip(
                                label: danmakuFilters[i].$1,
                                isSelected: danmakuFilters[i].$2,
                                onTap: danmakuFilters[i].$3,
                              ),
                              if (i != danmakuFilters.length - 1)
                                const SizedBox(width: 8),
                            ],
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
