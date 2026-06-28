import 'package:culcul/features/video/presentation/overlays/danmaku_settings_view_model.dart';
import 'package:culcul/features/video/presentation/detail/video_detail_view_model.dart';
import 'package:culcul/features/video/presentation/player/controls/player_constants.dart';
import 'package:culcul/features/video/presentation/player/controls/player_panel.dart';
import 'package:culcul/features/video/presentation/player/controls/video_overlay_styles.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/core/theme/culcul_tokens.dart';
import 'package:flutter/foundation.dart' show listEquals;
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

const double _settingsSectionOutlineAlpha = 0.18;
const double _settingsSectionCornerRadius = 16;

class PlayerSettingsSheet extends ConsumerWidget {
  final String bvid;
  final bool isBottomSheet;

  const PlayerSettingsSheet({super.key, required this.bvid, required this.isBottomSheet});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
    final colorScheme = Theme.of(context).colorScheme;
    final bottomPadding = MediaQuery.paddingOf(context).bottom;

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
    final danmakuSliderRows = [
      (
        label: t.video.player.danmaku_opacity,
        value: danmakuSettings.opacity,
        min: 0.1,
        max: 1.0,
        divisions: 9,
        onChanged: danmakuNotifier.setOpacity,
      ),
      (
        label: t.video.player.danmaku_scale,
        value: danmakuSettings.fontSizeScale,
        min: 0.5,
        max: 2.0,
        divisions: 15,
        onChanged: danmakuNotifier.setFontSizeScale,
      ),
      (
        label: t.video.player.danmaku_area,
        value: danmakuSettings.area,
        min: 0.25,
        max: 1.0,
        divisions: 3,
        onChanged: danmakuNotifier.setArea,
      ),
      (
        label: t.video.player.danmaku_speed,
        value: danmakuSettings.speed,
        min: 0.5,
        max: 2.0,
        divisions: 6,
        onChanged: danmakuNotifier.setSpeed,
      ),
    ];

    return PlayerPanelScaffold(
      isBottomSheet: isBottomSheet,
      panelWidth: 380,
      maxHeightFactor: 0.82,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.fromLTRB(
          CulculSpacing.md,
          CulculSpacing.md,
          CulculSpacing.md,
          isBottomSheet ? bottomPadding + CulculSpacing.md : CulculSpacing.md,
        ),
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
            const SizedBox(height: CulculSpacing.sm),
            _InlineTextOptionSection<int>(
              title: t.video.player.choose_quality,
              items: availableQualities,
              selectedItem: videoDetailState.selectedQuality,
              labelBuilder: (q) => qualityLabels[q] ?? getQualityLabel(q, t),
              onSelected: videoDetailNotifier.switchQuality,
              emptyLabel: t.video.player.quality_unavailable,
            ),
            const SizedBox(height: CulculSpacing.sm),
            PlayerPanelSection(
              title: t.video.player.danmaku_settings,
              subtitle: t.video.player.danmaku_section_hint,
              dense: true,
              showBody: danmakuSettings.isEnabled,
              backgroundColor: colorScheme.scrim.withValues(alpha: 0.82),
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
                    for (var i = 0; i < danmakuSliderRows.length; i++) ...[
                      if (i > 0) const SizedBox(height: CulculSpacing.xs),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  danmakuSliderRows[i].label,
                                  style: VideoOverlayStyles.titleStyle(
                                    colorScheme,
                                  ).copyWith(fontSize: 12.5, fontWeight: FontWeight.w600),
                                ),
                              ),
                              Text(
                                '${(danmakuSliderRows[i].value * 100).toInt()}%',
                                style: VideoOverlayStyles.bodyStyle(
                                  colorScheme,
                                ).copyWith(fontSize: 11.5, fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                          const SizedBox(height: CulculSpacing.xs),
                          Slider(
                            value: danmakuSliderRows[i].value,
                            min: danmakuSliderRows[i].min,
                            max: danmakuSliderRows[i].max,
                            divisions: danmakuSliderRows[i].divisions,
                            onChanged: danmakuSliderRows[i].onChanged,
                          ),
                        ],
                      ),
                    ],
                    const SizedBox(height: CulculSpacing.sm),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        child: Row(
                          children: [
                            for (var i = 0; i < danmakuFilters.length; i++) ...[
                              Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: danmakuFilters[i].$3,
                                  borderRadius: BorderRadius.circular(CulculRadius.xl),
                                  child: AnimatedContainer(
                                    duration: CulculMotion.fast,
                                    curve: Curves.easeOutCubic,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: CulculSpacing.md,
                                      vertical: CulculSpacing.xs,
                                    ),
                                    decoration: BoxDecoration(
                                      color: danmakuFilters[i].$2
                                          ? colorScheme.primaryContainer.withValues(
                                              alpha: 0.9,
                                            )
                                          : VideoOverlayStyles.panelSurface(
                                              colorScheme,
                                              alpha: 0.44,
                                            ),
                                      borderRadius: BorderRadius.circular(
                                        CulculRadius.xl,
                                      ),
                                      border: Border.all(
                                        color: danmakuFilters[i].$2
                                            ? colorScheme.primary.withValues(alpha: 0.9)
                                            : VideoOverlayStyles.panelOutline(
                                                colorScheme,
                                                alpha: 0.08,
                                              ),
                                      ),
                                    ),
                                    child: Text(
                                      danmakuFilters[i].$1,
                                      style: TextStyle(
                                        color: danmakuFilters[i].$2
                                            ? colorScheme.onPrimaryContainer
                                            : VideoOverlayStyles.foreground(
                                                colorScheme,
                                                alpha: 0.74,
                                              ),
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              if (i != danmakuFilters.length - 1)
                                const SizedBox(width: CulculSpacing.xs),
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

class _InlineTextOptionSection<T> extends StatefulWidget {
  final String title;
  final List<T> items;
  final T? selectedItem;
  final String Function(T) labelBuilder;
  final ValueChanged<T> onSelected;
  final String? emptyLabel;

  const _InlineTextOptionSection({
    super.key,
    required this.title,
    required this.items,
    required this.selectedItem,
    required this.labelBuilder,
    required this.onSelected,
    this.emptyLabel,
  });

  @override
  State<_InlineTextOptionSection<T>> createState() => _InlineTextOptionSectionState<T>();
}

class _InlineTextOptionSectionState<T> extends State<_InlineTextOptionSection<T>> {
  static const double _edgePadding = 8;

  final ScrollController _scrollController = ScrollController();
  final GlobalKey _scrollViewportKey = GlobalKey();
  late List<GlobalKey> _itemKeys;

  @override
  void initState() {
    super.initState();
    _itemKeys = List<GlobalKey>.generate(widget.items.length, (_) => GlobalKey());
    _scheduleScrollToSelected(animated: false);
  }

  @override
  void didUpdateWidget(covariant _InlineTextOptionSection<T> oldWidget) {
    super.didUpdateWidget(oldWidget);

    final itemsChanged = !listEquals(oldWidget.items, widget.items);
    if (itemsChanged) {
      _itemKeys = List<GlobalKey>.generate(widget.items.length, (_) => GlobalKey());
    }

    if (oldWidget.selectedItem != widget.selectedItem || itemsChanged) {
      _scheduleScrollToSelected(animated: oldWidget.selectedItem != null);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scheduleScrollToSelected({required bool animated}) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) {
        return;
      }
      _scrollToSelected(animated: animated);
    });
  }

  void _scrollToSelected({required bool animated}) {
    final selectedItem = widget.selectedItem;
    if (selectedItem == null || !_scrollController.hasClients) {
      return;
    }

    final selectedIndex = widget.items.indexOf(selectedItem);
    if (selectedIndex < 0 || selectedIndex >= _itemKeys.length) {
      return;
    }

    final selectedContext = _itemKeys[selectedIndex].currentContext;
    final viewportContext = _scrollViewportKey.currentContext;
    if (selectedContext == null || viewportContext == null) {
      return;
    }

    final selectedBox = selectedContext.findRenderObject() as RenderBox?;
    final viewportBox = viewportContext.findRenderObject() as RenderBox?;
    if (selectedBox == null || viewportBox == null) {
      return;
    }

    final selectedOffset = selectedBox.localToGlobal(Offset.zero, ancestor: viewportBox);
    final selectedStart = selectedOffset.dx;
    final selectedEnd = selectedStart + selectedBox.size.width;
    final viewportWidth = viewportBox.size.width;
    var targetOffset = _scrollController.offset;

    if (selectedStart < _edgePadding) {
      targetOffset += selectedStart - _edgePadding;
    } else if (selectedEnd > viewportWidth - _edgePadding) {
      targetOffset += selectedEnd - (viewportWidth - _edgePadding);
    } else {
      return;
    }

    targetOffset = targetOffset.clamp(0.0, _scrollController.position.maxScrollExtent);
    if ((targetOffset - _scrollController.offset).abs() < 1) {
      return;
    }

    if (animated) {
      _scrollController.animateTo(
        targetOffset,
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOutCubic,
      );
    } else {
      _scrollController.jumpTo(targetOffset);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    Widget buildOptionChip(int index) {
      final item = widget.items[index];
      final isSelected = item == widget.selectedItem;
      final label = widget.labelBuilder(item);

      return Semantics(
        key: _itemKeys[index],
        button: true,
        selected: isSelected,
        label: label,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () => widget.onSelected(item),
            borderRadius: BorderRadius.circular(CulculRadius.sm),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 3),
              child: AnimatedDefaultTextStyle(
                duration: CulculMotion.fast,
                curve: Curves.easeOutCubic,
                style: TextStyle(
                  color: isSelected
                      ? colorScheme.primary
                      : VideoOverlayStyles.foreground(colorScheme, alpha: 0.68),
                  fontSize: 11.5,
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                  height: 1.1,
                ),
                child: Text(label),
              ),
            ),
          ),
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: colorScheme.scrim.withValues(alpha: 0.82),
        borderRadius: BorderRadius.circular(_settingsSectionCornerRadius),
        border: Border.all(
          color: VideoOverlayStyles.panelOutline(
            colorScheme,
            alpha: _settingsSectionOutlineAlpha,
          ),
        ),
      ),
      child: Row(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            constraints: const BoxConstraints(minWidth: 56),
            child: Text(
              widget.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: VideoOverlayStyles.titleStyle(colorScheme).copyWith(fontSize: 14),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final content = widget.items.isEmpty
                    ? [
                        Text(
                          widget.emptyLabel ?? '',
                          style: VideoOverlayStyles.bodyStyle(
                            colorScheme,
                          ).copyWith(fontSize: 12),
                        ),
                      ]
                    : [
                        for (var i = 0; i < widget.items.length; i++) ...[
                          buildOptionChip(i),
                          if (i != widget.items.length - 1) const SizedBox(width: 10),
                        ],
                      ];

                return SingleChildScrollView(
                  key: _scrollViewportKey,
                  controller: _scrollController,
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(minWidth: constraints.maxWidth),
                    child: Row(children: content),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
