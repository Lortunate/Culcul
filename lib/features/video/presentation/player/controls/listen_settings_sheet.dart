import 'package:culcul/core/utils/format_utils.dart';
import 'package:culcul/features/video/presentation/player/listen_sleep_timer_view_model.dart';
import 'package:culcul/features/video/presentation/player/controls/player_panel.dart';
import 'package:culcul/features/video/presentation/player/controls/video_overlay_styles.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/core/theme/culcul_tokens.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ListenSettingsSheet extends HookConsumerWidget {
  const ListenSettingsSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
    final colorScheme = Theme.of(context).colorScheme;
    final timerState = ref.watch(listenSleepTimerControllerProvider);
    final timerController = ref.read(listenSleepTimerControllerProvider.notifier);
    final customInputController = useTextEditingController();
    useListenable(customInputController);
    const presetMinutes = [15, 30, 60, 90];
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

    String timerStatus;
    final remaining = timerState.remaining;
    if (timerState.isActive && remaining != null) {
      timerStatus = t.video.listen_settings.remaining(time: remaining.formatDuration);
    } else {
      timerStatus = t.video.listen_settings.timer_off;
    }

    return PlayerPanelScaffold(
      isBottomSheet: true,
      maxHeightFactor: 0.62,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(CulculSpacing.md),
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
              const SizedBox(height: CulculSpacing.sm),
              Wrap(
                spacing: 6,
                runSpacing: 6,
                children: [
                  for (final minutes in presetMinutes)
                    Semantics(
                      button: true,
                      selected: selectedPresetMinutes == minutes,
                      label: t.video.listen_settings.preset_minutes(
                        minutes: minutes,
                      ),
                      child: TextButton(
                        onPressed: () =>
                            timerController.setCustomMinutes(minutes),
                        style: TextButton.styleFrom(
                          foregroundColor: selectedPresetMinutes == minutes
                              ? colorScheme.primary
                              : VideoOverlayStyles.foreground(
                                  colorScheme,
                                  alpha: 0.7,
                                ),
                          textStyle: TextStyle(
                            fontSize: 13,
                            fontWeight: selectedPresetMinutes == minutes
                                ? FontWeight.w700
                                : FontWeight.w600,
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: CulculSpacing.xs,
                            vertical: CulculSpacing.xxs,
                          ),
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: Text(
                          t.video.listen_settings.preset_minutes(
                            minutes: minutes,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: CulculSpacing.sm),
              TextField(
                controller: customInputController,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.done,
                onSubmitted: (_) {
                  final minutes = parsedCustomMinutes;
                  if (!isCustomMinutesValid || minutes == null) {
                    return;
                  }
                  timerController.setCustomMinutes(minutes);
                  customInputController.clear();
                  FocusScope.of(context).unfocus();
                },
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
                    onPressed: isCustomMinutesValid
                        ? () {
                            final minutes = parsedCustomMinutes;
                            timerController.setCustomMinutes(minutes);
                            customInputController.clear();
                            FocusScope.of(context).unfocus();
                          }
                        : null,
                    style: TextButton.styleFrom(
                      foregroundColor: colorScheme.primary,
                      textStyle: const TextStyle(fontWeight: FontWeight.w700),
                    ),
                    child: Text(t.video.listen_settings.set_custom),
                  ),
                  const SizedBox(width: CulculSpacing.xxs),
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
