import 'package:culcul/core/network/bilibili_acceleration.dart';
import 'package:culcul/ui/widgets/app_clickable.dart';
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
    return _Section(
      title: title,
      child: _SectionCard(
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
    return _Section(
      title: title,
      description: hintText,
      child: _SectionCard(
        child: Column(
          children: [
            for (var i = 0; i < kBiliAccelerationPresets.length; i++) ...[
              _PresetTile(
                key: ValueKey<String>('preset_tile_${kBiliAccelerationPresets[i].id}'),
                title: titleBuilder(kBiliAccelerationPresets[i].id),
                subtitle: latencyBuilder(latencies[kBiliAccelerationPresets[i].id]),
                isActive: kBiliAccelerationPresets[i].id == activePresetId,
                activeTag: activeTag,
                onTap: () => onTapPreset(kBiliAccelerationPresets[i].id),
              ),
              if (i < kBiliAccelerationPresets.length - 1) const SizedBox(height: 4),
            ],
          ],
        ),
      ),
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

    return _Section(
      title: title,
      child: _SectionCard(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                color: colorScheme.surface.withValues(alpha: 0.65),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(lockTitle),
                        const SizedBox(height: 4),
                        Text(
                          lockSubtitle,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Switch(
                    key: const ValueKey<String>('network_lock_switch'),
                    value: isLocked,
                    onChanged: onChangedLock,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Container(
              key: const ValueKey<String>('network_test_row'),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                color: colorScheme.surface.withValues(alpha: 0.65),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(testTitle),
                        const SizedBox(height: 4),
                        Text(
                          testValue,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  SizedBox(
                    width: 116,
                    child: FilledButton(
                      key: const ValueKey<String>('network_test_button'),
                      onPressed: isTesting ? null : onTapTest,
                      style: FilledButton.styleFrom(
                        minimumSize: const Size.fromHeight(42),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: Text(testButtonLabel),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({required this.title, this.description, required this.child});

  final String title;
  final String? description;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(4, 0, 4, 8),
            child: Text(
              title,
              style: theme.textTheme.labelLarge?.copyWith(
                color: colorScheme.onSurfaceVariant,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          if (description != null)
            Padding(
              padding: const EdgeInsets.fromLTRB(4, 0, 4, 8),
              child: Text(
                description!,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ),
          child,
        ],
      ),
    );
  }
}

class _PresetTile extends StatelessWidget {
  const _PresetTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.isActive,
    required this.activeTag,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final bool isActive;
  final String activeTag;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final titleStyle = theme.textTheme.bodyLarge?.copyWith(
      color: isActive ? colorScheme.primary : colorScheme.onSurface,
      fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
    );

    return AppClickable(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: isActive
              ? colorScheme.primaryContainer.withValues(alpha: 0.4)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: titleStyle),
                  const SizedBox(height: 4),
                  Text(
                    isActive ? '$subtitle · $activeTag' : subtitle,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              isActive ? Icons.check_rounded : Icons.chevron_right_rounded,
              color: isActive ? colorScheme.primary : colorScheme.outline,
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  const _SectionCard({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(16),
      ),
      child: child,
    );
  }
}
