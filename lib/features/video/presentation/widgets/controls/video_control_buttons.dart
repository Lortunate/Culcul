import 'package:culcul/core/utils/format_extensions.dart';
import 'package:culcul/features/video/presentation/view_models/danmaku_settings_view_model.dart';
import 'package:culcul/features/video/presentation/view_models/playback_snapshot_view_model.dart';
import 'package:culcul/features/video/presentation/view_models/player_view_model.dart';
import 'package:culcul/features/video/presentation/view_models/subtitle_view_model.dart';
import 'package:culcul/features/video/presentation/view_models/video_detail_view_model.dart';
import 'package:culcul/features/video/presentation/widgets/controls/controls_utils.dart';
import 'package:culcul/features/video/presentation/widgets/controls/player_constants.dart';
import 'package:culcul/features/video/presentation/widgets/controls/player_theme.dart';
import 'package:culcul/features/video/presentation/widgets/controls/quick_selection_sheet.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

part 'video_control_buttons.actions.dart';
part 'video_control_buttons.components.dart';

class VideoControlButtons extends ConsumerWidget {
  final String bvid;
  final VoidCallback? onNext;
  final VoidCallback? onToggleFullscreen;

  const VideoControlButtons({
    super.key,
    required this.bvid,
    this.onNext,
    this.onToggleFullscreen,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isFullscreen = ref.watch(
      playerControllerProvider.select((s) => s.isFullscreen),
    );

    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 0, 12, 8),
      child: Row(
        children: [
          const _PlayPauseControlButton(),
          if (onNext != null) ...[
            const SizedBox(width: 4),
            ControlButton(onPressed: onNext, icon: Icons.skip_next_rounded, size: 24),
          ],
          const SizedBox(width: 8),
          const TimeText(),
          const Spacer(),
          if (isFullscreen) ...[
            _PlaybackSpeedButton(bvid: bvid),
            const SizedBox(width: 8),
            _PlaybackQualityButton(bvid: bvid),
            const SizedBox(width: 8),
            const _DanmakuToggleButton(),
            const SizedBox(width: 4),
            _SubtitleToggleButton(bvid: bvid),
          ],
          _FullscreenToggleButton(onToggleFullscreen: onToggleFullscreen),
        ],
      ),
    );
  }
}
