import 'package:culcul/features/video/controllers/danmaku_settings_controller.dart';
import 'package:culcul/features/video/controllers/player_controller.dart';
import 'package:culcul/features/video/controllers/video_detail_controller.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PlayerSettingsSheet extends ConsumerWidget {
  final String bvid;
  final ValueChanged<Duration?>? onSetSleepTimer;
  final DateTime? sleepTimerTarget;
  final bool isBottomSheet;

  const PlayerSettingsSheet({
    super.key,
    required this.bvid,
    this.onSetSleepTimer,
    this.sleepTimerTarget,
    this.isBottomSheet = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    final danmakuSettings = ref.watch(danmakuSettingsControllerProvider);
    final danmakuNotifier = ref.read(danmakuSettingsControllerProvider.notifier);

    final videoDetailState = ref.watch(videoDetailControllerProvider(bvid));
    final videoDetailNotifier = ref.read(videoDetailControllerProvider(bvid).notifier);

    // Calculate quality labels
    final qualityLabels = <int, String>{};
    if (videoDetailState.playUrl != null) {
      final qualities = videoDetailState.playUrl!.acceptQuality;
      final descs = videoDetailState.playUrl!.acceptDescription;
      for (int i = 0; i < qualities.length && i < descs.length; i++) {
        qualityLabels[qualities[i]] = descs[i];
      }
    }

    // More compact side panel
    const double panelWidth = 320.0;

    return Container(
      width: isBottomSheet ? double.infinity : panelWidth,
      constraints: BoxConstraints(
        maxHeight: isBottomSheet
            ? MediaQuery.of(context).size.height * 0.75
            : double.infinity,
      ),
      child: ClipRRect(
        borderRadius: isBottomSheet
            ? const BorderRadius.vertical(top: Radius.circular(24))
            : const BorderRadius.horizontal(left: Radius.circular(24)),
        child: Container(
          color: const Color(0xE61E1E1E), // Slightly lighter, modern dark grey
          child: Material(
            color: Colors.transparent,
            child: SafeArea(
              top: false,
              bottom: !isBottomSheet,
              left: !isBottomSheet,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (isBottomSheet) _buildDragHandle(),
                  Flexible(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.fromLTRB(
                        24,
                        isBottomSheet ? 8 : 24,
                        24,
                        isBottomSheet ? bottomPadding + 24 : 24,
                      ),
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Danmaku Settings
                          _buildDanmakuSection(
                            danmakuSettings,
                            danmakuNotifier,
                            colorScheme,
                          ),
                          const SizedBox(height: 32),
                          _buildSectionTitle('播放速度'),
                          const SizedBox(height: 16),
                          _buildSpeedOptions(
                            colorScheme,
                            videoDetailState.playbackSpeed,
                            (s) {
                              videoDetailNotifier.setPlaybackSpeed(s);
                              ref
                                  .read(playerControllerProvider.notifier)
                                  .player
                                  .setRate(s);
                            },
                          ),
                          const SizedBox(height: 32),
                          _buildSectionTitle('清晰度'),
                          const SizedBox(height: 16),
                          _buildQualityOptions(
                            colorScheme,
                            videoDetailState.selectedQuality,
                            videoDetailState.availableQualities,
                            qualityLabels,
                            (q) => videoDetailNotifier.switchQuality(q),
                          ),
                          const SizedBox(height: 32),
                          _buildSectionTitle('定时停止'),
                          const SizedBox(height: 16),
                          _buildSleepTimerOptions(colorScheme, context),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDanmakuSection(
    dynamic settings,
    dynamic notifier,
    ColorScheme colorScheme,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildSectionTitle('弹幕设置'),
            Transform.scale(
              scale: 0.8,
              child: Switch(
                value: settings.isEnabled,
                onChanged: (v) => notifier.setEnabled(v),
                activeThumbColor: colorScheme.primary,
                activeTrackColor: colorScheme.primary.withValues(alpha: 0.3),
                inactiveThumbColor: Colors.grey,
                inactiveTrackColor: Colors.white10,
              ),
            ),
          ],
        ),
        if (settings.isEnabled) ...[
          const SizedBox(height: 16),
          // Settings Grid
          _buildSliderRow(
            '不透明度',
            '${(settings.opacity * 100).toInt()}%',
            settings.opacity,
            (v) => notifier.setOpacity(v),
            min: 0.1,
            max: 1.0,
            divisions: 9,
            colorScheme: colorScheme,
          ),
          const SizedBox(height: 12),
          _buildSliderRow(
            '字号缩放',
            '${(settings.fontSizeScale * 100).toInt()}%',
            settings.fontSizeScale,
            (v) => notifier.setFontSizeScale(v),
            min: 0.5,
            max: 2.0,
            divisions: 15,
            colorScheme: colorScheme,
          ),
          const SizedBox(height: 12),
          _buildSliderRow(
            '显示区域',
            '${(settings.area * 100).toInt()}%',
            settings.area,
            (v) => notifier.setArea(v),
            min: 0.25,
            max: 1.0,
            divisions: 3,
            colorScheme: colorScheme,
          ),
          const SizedBox(height: 12),
          _buildSliderRow(
            '弹幕速度',
            '${(settings.speed * 100).toInt()}%',
            settings.speed,
            (v) => notifier.setSpeed(v),
            min: 0.5,
            max: 2.0,
            divisions: 6,
            colorScheme: colorScheme,
          ),

          const SizedBox(height: 20),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              _ModernFilterChip(
                label: '滚动',
                isSelected: settings.showScroll,
                onTap: notifier.toggleScroll,
                colorScheme: colorScheme,
              ),
              _ModernFilterChip(
                label: '顶部',
                isSelected: settings.showTop,
                onTap: notifier.toggleTop,
                colorScheme: colorScheme,
              ),
              _ModernFilterChip(
                label: '底部',
                isSelected: settings.showBottom,
                onTap: notifier.toggleBottom,
                colorScheme: colorScheme,
              ),
              _ModernFilterChip(
                label: '彩色',
                isSelected: settings.showColor,
                onTap: notifier.toggleColor,
                colorScheme: colorScheme,
              ),
            ],
          ),
        ],
      ],
    );
  }

  Widget _buildSliderRow(
    String label,
    String valueText,
    double value,
    ValueChanged<double> onChanged, {
    double min = 0.0,
    double max = 1.0,
    int? divisions,
    required ColorScheme colorScheme,
  }) {
    return Row(
      children: [
        SizedBox(
          width: 60,
          child: Text(
            label,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Expanded(
          child: SizedBox(
            height: 24,
            child: SliderTheme(
              data: SliderThemeData(
                trackHeight: 4,
                thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8),
                overlayShape: const RoundSliderOverlayShape(overlayRadius: 16),
                activeTrackColor: colorScheme.primary,
                inactiveTrackColor: Colors.white10,
                thumbColor: Colors.white,
                trackShape: const RoundedRectSliderTrackShape(),
              ),
              child: Slider(
                value: value,
                min: min,
                max: max,
                divisions: divisions,
                onChanged: onChanged,
              ),
            ),
          ),
        ),
        SizedBox(
          width: 48,
          child: Text(
            valueText,
            textAlign: TextAlign.end,
            style: const TextStyle(
              color: Colors.white54,
              fontSize: 12,
              fontFeatures: [FontFeature.tabularFigures()],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDragHandle() {
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 16),
        width: 36,
        height: 4,
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(2),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 15,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.5,
      ),
    );
  }

  Widget _buildSpeedOptions(
    ColorScheme colorScheme,
    double playbackSpeed,
    ValueChanged<double> onSpeedChanged,
  ) {
    const speeds = [0.5, 0.75, 1.0, 1.25, 1.5, 2.0];
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: speeds.map((speed) {
        final isSelected = playbackSpeed == speed;
        return _CompactOptionChip(
          label: '${speed}x',
          isSelected: isSelected,
          colorScheme: colorScheme,
          onTap: () => onSpeedChanged(speed),
        );
      }).toList(),
    );
  }

  Widget _buildSleepTimerOptions(ColorScheme colorScheme, BuildContext context) {
    final options = [
      null,
      const Duration(minutes: 15),
      const Duration(minutes: 30),
      const Duration(minutes: 60),
    ];

    String getLabel(Duration? d) {
      if (d == null) return '不开启';
      return '${d.inMinutes}分钟';
    }

    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: options.map((duration) {
        final isOff = duration == null;
        final bool selected = isOff ? sleepTimerTarget == null : false;

        return _CompactOptionChip(
          label: getLabel(duration),
          isSelected: selected,
          colorScheme: colorScheme,
          onTap: () {
            if (onSetSleepTimer != null) {
              onSetSleepTimer!(duration);
            }
          },
        );
      }).toList(),
    );
  }

  Widget _buildQualityOptions(
    ColorScheme colorScheme,
    int selectedQuality,
    List<int> availableQualities,
    Map<int, String> qualityLabels,
    ValueChanged<int> onQualityChanged,
  ) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: availableQualities.map((quality) {
        final isSelected = selectedQuality == quality;
        final label = qualityLabels[quality] ?? '未知';
        final shortLabel = label.split(' ').first;

        return _CompactOptionChip(
          label: shortLabel,
          isSelected: isSelected,
          colorScheme: colorScheme,
          onTap: () => onQualityChanged(quality),
        );
      }).toList(),
    );
  }
}

class _CompactOptionChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final ColorScheme colorScheme;

  const _CompactOptionChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOutQuad,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          decoration: BoxDecoration(
            color: isSelected
                ? colorScheme.primary
                : Colors.white.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: isSelected
                  ? Colors.transparent
                  : Colors.white.withValues(alpha: 0.1),
              width: 1,
            ),
          ),
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? colorScheme.onPrimary : Colors.white70,
              fontSize: 13,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}

class _ModernFilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final ColorScheme colorScheme;

  const _ModernFilterChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: isSelected
                ? colorScheme.primary.withValues(alpha: 0.2)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isSelected ? colorScheme.primary : Colors.white24,
              width: 1,
            ),
          ),
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? colorScheme.primary : Colors.white70,
              fontSize: 12,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
