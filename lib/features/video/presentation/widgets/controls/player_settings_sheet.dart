import 'package:culcul/features/video/presentation/view_models/danmaku_settings_view_model.dart';
import 'package:culcul/features/video/presentation/view_models/video_detail_view_model.dart';
import 'package:culcul/features/video/presentation/widgets/controls/player_constants.dart';
import 'package:culcul/features/video/presentation/widgets/controls/player_panel.dart';
import 'package:culcul/features/video/presentation/widgets/controls/video_overlay_styles.dart';
import 'package:culcul/i18n/i18n.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PlayerSettingsSheet extends ConsumerWidget {
  final String bvid;
  final bool isBottomSheet;

  const PlayerSettingsSheet({
    super.key,
    required this.bvid,
    this.isBottomSheet = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = i18n(context);
    final colorScheme = Theme.of(context).colorScheme;
    final bottomPadding = MediaQuery.paddingOf(context).bottom;

    final danmakuSettings = ref.watch(danmakuSettingsControllerProvider);
    final danmakuNotifier = ref.read(danmakuSettingsControllerProvider.notifier);

    final videoDetailState = ref.watch(videoDetailControllerProvider(bvid));
    final videoDetailNotifier = ref.read(videoDetailControllerProvider(bvid).notifier);

    final availableQualities = videoDetailState.availableQualities;
    final qualityLabels = buildQualityLabels(videoDetailState.playUrl, t);

    final danmakuFilters = [
      (t.video.player.danmaku_type_scroll, danmakuSettings.showScroll, danmakuNotifier.toggleScroll),
      (t.video.player.danmaku_type_top, danmakuSettings.showTop, danmakuNotifier.toggleTop),
      (t.video.player.danmaku_type_bottom, danmakuSettings.showBottom, danmakuNotifier.toggleBottom),
      (t.video.player.danmaku_type_color, danmakuSettings.showColor, danmakuNotifier.toggleColor),
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
            PlayerPanelSection(
              title: t.video.player.choose_speed,
              dense: true,
              child: _HorizontalTextOptionStrip<double>(
                items: playbackSpeeds,
                selectedItem: videoDetailState.playbackSpeed,
                labelBuilder: formatPlaybackSpeedLabel,
                onSelected: videoDetailNotifier.setPlaybackSpeed,
              ),
            ),
            const SizedBox(height: 12),
            PlayerPanelSection(
              title: t.video.player.choose_quality,
              dense: true,
              child: availableQualities.isEmpty
                  ? PlayerPanelEmptyState(label: t.video.player.quality_unavailable)
                  : _HorizontalTextOptionStrip<int>(
                items: availableQualities,
                selectedItem: videoDetailState.selectedQuality,
                labelBuilder: (q) => qualityLabels[q] ?? getQualityLabel(q, t),
                onSelected: videoDetailNotifier.switchQuality,
              ),
            ),
            const SizedBox(height: 12),
            PlayerPanelSection(
              title: t.video.player.danmaku_settings,
              subtitle: t.video.player.danmaku_section_hint,
              dense: true,
              showBody: danmakuSettings.isEnabled,
              trailing: Switch.adaptive(
                value: danmakuSettings.isEnabled,
                onChanged: danmakuNotifier.setEnabled,
              ),
              child: SliderTheme(
                data: SliderThemeData(
                  trackHeight: 2.8,
                  thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 5.5, elevation: 0),
                  overlayShape: const RoundSliderOverlayShape(overlayRadius: 10),
                  activeTrackColor: colorScheme.primary.withValues(alpha: 0.92),
                  inactiveTrackColor: VideoOverlayStyles.panelOutline(colorScheme, alpha: 0.18),
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
                              if (i != danmakuFilters.length - 1) const SizedBox(width: 8),
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

class _HorizontalTextOptionStrip<T> extends StatelessWidget {
  final List<T> items;
  final T? selectedItem;
  final String Function(T) labelBuilder;
  final ValueChanged<T> onSelected;

  const _HorizontalTextOptionStrip({
    required this.items,
    required this.selectedItem,
    required this.labelBuilder,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: [
          for (var i = 0; i < items.length; i++) ...[
            _OptionTextChip<T>(
              item: items[i],
              selectedItem: selectedItem,
              labelBuilder: labelBuilder,
              onSelected: onSelected,
            ),
            if (i != items.length - 1) const SizedBox(width: 8),
          ],
        ],
      ),
    );
  }
}

class _OptionTextChip<T> extends StatelessWidget {
  final T item;
  final T? selectedItem;
  final String Function(T) labelBuilder;
  final ValueChanged<T> onSelected;

  const _OptionTextChip({
    required this.item,
    required this.selectedItem,
    required this.labelBuilder,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isSelected = item == selectedItem;
    final label = labelBuilder(item);

    return Semantics(
      button: true,
      selected: isSelected,
      label: label,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => onSelected(item),
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
            child: AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 180),
              curve: Curves.easeOutCubic,
              style: TextStyle(
                color: isSelected
                    ? colorScheme.primary
                    : VideoOverlayStyles.foreground(colorScheme, alpha: 0.62),
                fontSize: 13,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                height: 1.15,
              ),
              child: Text(label),
            ),
          ),
        ),
      ),
    );
  }
}

class _DanmakuSliderRow extends StatelessWidget {
  final String label;
  final double value;
  final double min;
  final double max;
  final int divisions;
  final ValueChanged<double> onChanged;

  const _DanmakuSliderRow({
    required this.label,
    required this.value,
    required this.min,
    required this.max,
    required this.divisions,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: VideoOverlayStyles.titleStyle(colorScheme).copyWith(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Text(
              '${(value * 100).toInt()}%',
              style: VideoOverlayStyles.bodyStyle(colorScheme).copyWith(
                fontSize: 11.5,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Slider(
          value: value,
          min: min,
          max: max,
          divisions: divisions,
          onChanged: onChanged,
        ),
      ],
    );
  }
}