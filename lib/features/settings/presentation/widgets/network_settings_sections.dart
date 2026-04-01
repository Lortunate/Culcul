import 'package:culcul/core/network/bilibili_acceleration.dart';
import 'package:culcul/features/settings/presentation/widgets/settings_group.dart';
import 'package:culcul/features/settings/presentation/widgets/settings_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NetworkModeSection extends StatelessWidget {
  const NetworkModeSection({
    super.key,
    required this.title,
    required this.currentMode,
    required this.autoLabel,
    required this.manualLabel,
    required this.onSelect,
  });

  final String title;
  final BiliAccelerationMode currentMode;
  final String autoLabel;
  final String manualLabel;
  final ValueChanged<BiliAccelerationMode> onSelect;

  @override
  Widget build(BuildContext context) {
    return SettingsGroup(
      title: title,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: CupertinoSlidingSegmentedControl<BiliAccelerationMode>(
            groupValue: currentMode,
            padding: const EdgeInsets.all(3),
            backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
            thumbColor: Theme.of(context).colorScheme.surface,
            children: {
              BiliAccelerationMode.auto: _segmentText(context, autoLabel),
              BiliAccelerationMode.manual: _segmentText(context, manualLabel),
            },
            onValueChanged: (mode) {
              if (mode != null) {
                onSelect(mode);
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _segmentText(BuildContext context, String text) {
    final style = Theme.of(
      context,
    ).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w600);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
      child: Text(text, style: style),
    );
  }
}

class NetworkPresetSection extends StatelessWidget {
  const NetworkPresetSection({
    super.key,
    required this.title,
    required this.hintText,
    required this.activePresetId,
    required this.latencies,
    required this.titleBuilder,
    required this.latencyBuilder,
    required this.activeTag,
    required this.onTapPreset,
  });

  final String title;
  final String hintText;
  final String activePresetId;
  final Map<String, BiliLatencySnapshot> latencies;
  final String Function(String presetId) titleBuilder;
  final String Function(BiliLatencySnapshot? snapshot) latencyBuilder;
  final String activeTag;
  final ValueChanged<String> onTapPreset;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        SettingsGroup(
          title: title,
          children: kBiliAccelerationPresets.map((preset) {
            final isActive = preset.id == activePresetId;
            return SettingsTile(
              key: ValueKey<String>('preset_tile_${preset.id}'),
              title: titleBuilder(preset.id),
              subtitle: isActive 
                  ? '${latencyBuilder(latencies[preset.id])} · $activeTag' 
                  : latencyBuilder(latencies[preset.id]),
              showArrow: false,
              trailing: isActive
                  ? Icon(Icons.check_rounded, color: colorScheme.primary)
                  : null,
              onTap: () => onTapPreset(preset.id),
            );
          }).toList(),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
          child: Text(
            hintText,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        ),
      ],
    );
  }
}

class NetworkOperationsSection extends StatelessWidget {
  const NetworkOperationsSection({
    super.key,
    required this.title,
    required this.lockTitle,
    required this.lockSubtitle,
    required this.isLocked,
    required this.onChangedLock,
    required this.testTitle,
    required this.testValue,
    required this.testButtonLabel,
    required this.isTesting,
    required this.onTapTest,
  });

  final String title;
  final String lockTitle;
  final String lockSubtitle;
  final bool isLocked;
  final ValueChanged<bool> onChangedLock;
  final String testTitle;
  final String testValue;
  final String testButtonLabel;
  final bool isTesting;
  final VoidCallback onTapTest;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return SettingsGroup(
      title: title,
      children: [
        SettingsTile(
          title: lockTitle,
          subtitle: lockSubtitle,
          showArrow: false,
          onTap: () => onChangedLock(!isLocked),
          trailing: Switch(
            key: const ValueKey<String>('network_lock_switch'),
            value: isLocked,
            onChanged: onChangedLock,
          ),
        ),
        SettingsTile(
          key: const ValueKey<String>('network_test_row'),
          title: testTitle,
          subtitle: testValue,
          showArrow: false,
          trailing: SizedBox(
            width: 116,
            height: 38,
            child: FilledButton(
              key: const ValueKey<String>('network_test_button'),
              onPressed: isTesting ? null : onTapTest,
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                testButtonLabel,
                style: theme.textTheme.labelLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: isTesting ? colorScheme.onSurface.withValues(alpha: 0.38) : colorScheme.onPrimary,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
