import 'package:culcul/core/utils/format_extensions.dart';
import 'package:culcul/features/video/presentation/view_models/listen_sleep_timer_view_model.dart';
import 'package:culcul/features/video/presentation/widgets/controls/player_panel.dart';
import 'package:culcul/features/video/presentation/widgets/controls/video_overlay_styles.dart';
import 'package:culcul/i18n/i18n.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ListenSettingsSheet extends HookConsumerWidget {
  final bool isBottomSheet;

  const ListenSettingsSheet({super.key, this.isBottomSheet = false});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = i18n(context);
    final colorScheme = Theme.of(context).colorScheme;
    final timerState = ref.watch(listenSleepTimerControllerProvider);
    final timerController = ref.read(listenSleepTimerControllerProvider.notifier);
    final customInputController = useTextEditingController();
    useListenable(customInputController);
    final presetMinutes = const [15, 30, 60, 90];
    final selectedPresetMinutes = timerState.isActive
        ? timerState.total?.inMinutes
        : null;
    final rawCustomMinutes = customInputController.text.trim();
    final parsedCustomMinutes = int.tryParse(rawCustomMinutes);
    final isCustomMinutesValid =
        parsedCustomMinutes != null &&
        parsedCustomMinutes >= minListenSleepMinutes &&
        parsedCustomMinutes <= maxListenSleepMinutes;
    final customErrorText = rawCustomMinutes.isEmpty || isCustomMinutesValid
        ? null
        : t.video.listen_settings.custom_invalid_range(
            min: minListenSleepMinutes,
            max: maxListenSleepMinutes,
          );

    void submitCustomMinutes() {
      final minutes = parsedCustomMinutes;
      if (!isCustomMinutesValid || minutes == null) {
        return;
      }
      timerController.setCustomMinutes(minutes);
      customInputController.clear();
      FocusScope.of(context).unfocus();
    }

    String timerStatus;
    final remaining = timerState.remaining;
    if (timerState.isActive && remaining != null) {
      timerStatus = t.video.listen_settings.remaining(time: remaining.formatDuration);
    } else {
      timerStatus = t.video.listen_settings.timer_off;
    }

    return PlayerPanelScaffold(
      title: t.video.listen_settings.title,
      subtitle: t.video.listen_settings.sleep_timer,
      isBottomSheet: isBottomSheet,
      panelWidth: 360,
      maxHeightFactor: 0.62,
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
        child: PlayerPanelSection(
          title: t.video.listen_settings.sleep_timer,
          subtitle: timerStatus,
          dense: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                t.video.listen_settings.sleep_timer,
                style: VideoOverlayStyles.bodyStyle(
                  colorScheme,
                ).copyWith(fontSize: 12, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 6,
                runSpacing: 6,
                children: [
                  for (final minutes in presetMinutes)
                    _PresetMinuteTextButton(
                      minutes: minutes,
                      isSelected: selectedPresetMinutes == minutes,
                      onTap: () => timerController.setPresetMinutes(minutes),
                    ),
                ],
              ),
              const SizedBox(height: 12),
              TextField(
                controller: customInputController,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.done,
                onSubmitted: (_) => submitCustomMinutes(),
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(3),
                ],
                decoration: InputDecoration(
                  hintText: t.video.listen_settings.custom_hint(
                    min: minListenSleepMinutes,
                    max: maxListenSleepMinutes,
                  ),
                  suffixText: t.video.listen_settings.minutes_unit,
                  errorText: customErrorText,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  TextButton(
                    onPressed: isCustomMinutesValid ? submitCustomMinutes : null,
                    style: TextButton.styleFrom(
                      foregroundColor: colorScheme.primary,
                      textStyle: const TextStyle(fontWeight: FontWeight.w700),
                    ),
                    child: Text(t.video.listen_settings.set_custom),
                  ),
                  const SizedBox(width: 4),
                  TextButton(
                    onPressed: timerController.clearTimer,
                    style: TextButton.styleFrom(
                      foregroundColor: colorScheme.error.withValues(alpha: 0.82),
                    ),
                    child: Text(t.video.listen_settings.disable),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PresetMinuteTextButton extends StatelessWidget {
  final int minutes;
  final bool isSelected;
  final VoidCallback onTap;

  const _PresetMinuteTextButton({
    required this.minutes,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final t = i18n(context);
    final colorScheme = Theme.of(context).colorScheme;
    final label = t.video.listen_settings.preset_minutes(minutes: minutes);

    return Semantics(
      button: true,
      selected: isSelected,
      label: label,
      child: TextButton(
        onPressed: onTap,
        style: TextButton.styleFrom(
          foregroundColor: isSelected
              ? colorScheme.primary
              : VideoOverlayStyles.foreground(colorScheme, alpha: 0.7),
          textStyle: TextStyle(
            fontSize: 13,
            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          minimumSize: Size.zero,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        child: Text(label),
      ),
    );
  }
}
