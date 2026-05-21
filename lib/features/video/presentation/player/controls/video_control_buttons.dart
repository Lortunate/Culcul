import 'package:culcul/core/utils/format_extensions.dart';
import 'package:culcul/features/video/presentation/overlays/danmaku_settings_view_model.dart';
import 'package:culcul/features/video/presentation/player/playback_snapshot_view_model.dart';
import 'package:culcul/features/video/presentation/player/player_view_model.dart';
import 'package:culcul/features/video/presentation/overlays/subtitle_view_model.dart';
import 'package:culcul/features/video/presentation/detail/video_detail_view_model.dart';
import 'package:culcul/features/video/presentation/player/controls/controls_utils.dart';
import 'package:culcul/features/video/presentation/player/controls/player_constants.dart';
import 'package:culcul/features/video/presentation/player/controls/player_theme.dart';
import 'package:culcul/features/video/presentation/player/controls/quick_selection_sheet.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/ui/theme/culcul_tokens.dart';
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
      padding: const EdgeInsets.fromLTRB(
        CulculSpacing.sm,
        0,
        CulculSpacing.sm,
        CulculSpacing.xs,
      ),
      child: Row(
        children: [
          const _PlayPauseControlButton(),
          if (onNext != null) ...[
            const SizedBox(width: CulculSpacing.xxs),
            ControlButton(onPressed: onNext, icon: Icons.skip_next_rounded, size: 24),
          ],
          const SizedBox(width: CulculSpacing.xs),
          const TimeText(),
          const Spacer(),
          if (isFullscreen) ...[
            _PlaybackSpeedButton(bvid: bvid),
            const SizedBox(width: CulculSpacing.xs),
            _PlaybackQualityButton(bvid: bvid),
            const SizedBox(width: CulculSpacing.xs),
            const _DanmakuToggleButton(),
            const SizedBox(width: CulculSpacing.xxs),
            _SubtitleToggleButton(bvid: bvid),
          ],
          _FullscreenToggleButton(onToggleFullscreen: onToggleFullscreen),
        ],
      ),
    );
  }
}
