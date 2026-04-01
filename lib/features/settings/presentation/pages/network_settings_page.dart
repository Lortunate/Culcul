import 'package:culcul/core/network/bilibili_acceleration.dart';
import 'package:culcul/features/settings/presentation/widgets/network_settings_formatters.dart';
import 'package:culcul/features/settings/presentation/widgets/network_settings_sections.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class NetworkSettingsPage extends ConsumerWidget {
  const NetworkSettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = Translations.of(context);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final accelerationState = ref.watch(bilibiliAccelerationControllerProvider);

    return Scaffold(
      backgroundColor: colorScheme.surfaceContainerLowest,
      appBar: AppBar(
        title: Text(
          t.settings.network.page_title,
          style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
        backgroundColor: colorScheme.surfaceContainerLowest,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18),
          onPressed: () => context.pop(),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        children: [
          NetworkModeSection(
            title: t.settings.network.mode,
            currentMode: accelerationState.mode,
            autoLabel: t.settings.network.mode_auto,
            manualLabel: t.settings.network.mode_manual,
            onSelect: (mode) =>
                ref.read(bilibiliAccelerationControllerProvider.notifier).setMode(mode),
          ),
          const SizedBox(height: 24),
          NetworkPresetSection(
            title: t.settings.network.active_preset,
            hintText: t.settings.network.preset_hint,
            activePresetId: accelerationState.activePresetId,
            latencies: accelerationState.latencies,
            titleBuilder: (presetId) => formatNetworkPresetLabel(t, presetId),
            latencyBuilder: (snapshot) => formatNetworkLatency(t, snapshot),
            activeTag: t.settings.network.active,
            onTapPreset: (presetId) {
              if (presetId == accelerationState.activePresetId) {
                return;
              }
              ref
                  .read(bilibiliAccelerationControllerProvider.notifier)
                  .manualSwitchPreset(presetId);
            },
          ),
          const SizedBox(height: 24),
          NetworkOperationsSection(
            title: t.settings.network.operations,
            lockTitle: t.settings.network.lock_preset,
            lockSubtitle: t.settings.network.lock_description,
            isLocked: accelerationState.locked,
            onChangedLock: (value) => ref
                .read(bilibiliAccelerationControllerProvider.notifier)
                .setLocked(value),
            testTitle: t.settings.network.test_latency,
            testValue: accelerationState.isTesting
                ? t.settings.network.testing
                : formatNetworkProbeTime(t, accelerationState.lastProbeAt),
            testButtonLabel: accelerationState.isTesting
                ? t.settings.network.testing
                : t.settings.network.test_now,
            isTesting: accelerationState.isTesting,
            onTapTest: () => ref
                .read(bilibiliAccelerationControllerProvider.notifier)
                .probeLatencies(),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}
