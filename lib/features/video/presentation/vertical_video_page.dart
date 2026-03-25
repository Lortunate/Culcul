import 'package:culcul/core/utils/format_utils.dart';
import 'package:culcul/data/models/video/video_detail.dart';
import 'package:culcul/features/video/controllers/playback_snapshot_controller.dart';
import 'package:culcul/features/video/controllers/player_controller.dart';
import 'package:culcul/features/video/controllers/video_detail_controller.dart';
import 'package:culcul/features/video/presentation/hooks/use_player_system_settings.dart';
import 'package:culcul/features/video/presentation/hooks/use_video_loader.dart';
import 'package:culcul/features/video/presentation/hooks/use_video_progress.dart';
import 'package:culcul/features/video/presentation/widgets/layers/danmaku_layer.dart';
import 'package:culcul/features/video/presentation/widgets/layers/interaction_layer.dart';
import 'package:culcul/features/video/presentation/widgets/layers/subtitle_layer.dart';
import 'package:culcul/features/video/presentation/widgets/layers/video_layer.dart';
import 'package:culcul/ui/widgets/app_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

typedef _VideoAction = ({IconData icon, int count, String label});

class VerticalVideoPage extends HookConsumerWidget {
  final String bvid;
  final VideoDetail videoDetail;

  const VerticalVideoPage({super.key, required this.bvid, required this.videoDetail});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;

    final playerController = ref.watch(playerControllerProvider.notifier);
    final playerState = ref.watch(playerControllerProvider);
    final player = playerController.player;
    final state = ref.watch(videoDetailControllerProvider(bvid));

    useVideoLoader(ref, player, state);
    final brightness = usePlayerSystemSettings(player);
    useVideoProgressReport(ref, bvid, player, playerState.isPlaying);

    useEffect(() {
      WakelockPlus.enable();
      return () => WakelockPlus.disable();
    }, []);

    final volumeSnapshot = useStream(player.stream.volume);
    final currentVolume = volumeSnapshot.data ?? player.state.volume;

    return Scaffold(
      backgroundColor: colorScheme.scrim,
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          InteractionLayer(
            bvid: bvid,
            brightness: brightness,
            currentVolume: currentVolume,
            child: Stack(
              children: [
                const Positioned.fill(child: VideoLayer(fit: BoxFit.contain)),
                Positioned.fill(child: DanmakuLayer(bvid: bvid)),
                Positioned.fill(child: SubtitleLayer(bvid: bvid)),
              ],
            ),
          ),

          const Positioned(top: 0, left: 0, right: 0, child: SafeArea(child: _TopBar())),

          Positioned(right: 8, bottom: 120, child: _RightBar(videoDetail: videoDetail)),

          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: _BottomBar(
              videoDetail: videoDetail,
              playerController: playerController,
            ),
          ),
        ],
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  const _TopBar();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          GestureDetector(
            onTap: context.pop,
            child: Icon(Icons.arrow_back_ios_new, color: colorScheme.onPrimary, size: 20),
          ),
          const SizedBox(width: 8),
          Text(
            '12人正在看',
            style: TextStyle(
              color: colorScheme.onPrimary.withValues(alpha: 0.7),
              fontSize: 12,
            ),
          ),
          const Spacer(),
          Icon(Icons.search, color: colorScheme.onPrimary, size: 24),
          const SizedBox(width: 16),
          Icon(Icons.more_vert, color: colorScheme.onPrimary, size: 24),
        ],
      ),
    );
  }
}

class _RightBar extends StatelessWidget {
  const _RightBar({required this.videoDetail});

  final VideoDetail videoDetail;

  @override
  Widget build(BuildContext context) {
    final actions = <_VideoAction>[
      (icon: Icons.thumb_up_rounded, count: videoDetail.stat.like, label: '点赞'),
      (icon: Icons.comment_rounded, count: videoDetail.stat.reply, label: '评论'),
      (icon: Icons.thumb_down_alt_rounded, count: 438, label: '不喜欢'),
      (icon: Icons.star_rounded, count: videoDetail.stat.favorite, label: '收藏'),
      (icon: Icons.share_rounded, count: videoDetail.stat.share, label: '转发'),
    ];

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (var index = 0; index < actions.length; index++) ...[
          _RightActionItem(action: actions[index]),
          if (index != actions.length - 1) const SizedBox(height: 20),
        ],
      ],
    );
  }
}

class _RightActionItem extends StatelessWidget {
  const _RightActionItem({required this.action});

  final _VideoAction action;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      children: [
        Icon(action.icon, color: colorScheme.onPrimary, size: 32),
        const SizedBox(height: 4),
        Text(
          FormatUtils.formatNumber(action.count),
          style: TextStyle(
            color: colorScheme.onPrimary,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class _BottomBar extends ConsumerWidget {
  final VideoDetail videoDetail;
  final PlayerController playerController;

  const _BottomBar({required this.videoDetail, required this.playerController});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final position = ref.watch(playbackPositionProvider);
    final duration = ref.watch(playbackDurationProvider);
    final maxValue = duration.inSeconds > 0 ? duration.inSeconds.toDouble() : 1.0;
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.transparent, colorScheme.scrim.withValues(alpha: 0.87)],
        ),
      ),
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildAuthorRow(colorScheme),
          const SizedBox(height: 12),
          _buildTitleRow(colorScheme),
          const SizedBox(height: 4),
          _buildPlayCountRow(colorScheme),
          const SizedBox(height: 12),
          _buildProgressBar(position, maxValue, colorScheme),
          _buildActionRow(colorScheme),
        ],
      ),
    );
  }

  Widget _buildAuthorRow(ColorScheme colorScheme) {
    return Row(
      children: [
        AppAvatar(url: videoDetail.owner.face, size: 36, onTap: () {}),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              videoDetail.owner.name,
              style: TextStyle(
                color: colorScheme.onPrimary,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '504.4万粉丝',
              style: TextStyle(
                color: colorScheme.onPrimary.withValues(alpha: 0.7),
                fontSize: 12,
              ),
            ),
          ],
        ),
        const SizedBox(width: 12),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: colorScheme.primary,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text(
            '+ 关注',
            style: TextStyle(
              color: colorScheme.onPrimary,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTitleRow(ColorScheme colorScheme) {
    // Keep high contrast for on-video readability.
    return Row(
      children: [
        Expanded(
          child: Text(
            videoDetail.title,
            style: TextStyle(color: colorScheme.onPrimary, fontSize: 14),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(width: 4),
        Icon(
          Icons.keyboard_arrow_down,
          color: colorScheme.onPrimary.withValues(alpha: 0.7),
          size: 20,
        ),
      ],
    );
  }

  Widget _buildPlayCountRow(ColorScheme colorScheme) {
    return Row(
      children: [
        Icon(
          Icons.play_circle_outline,
          size: 12,
          color: colorScheme.onPrimary.withValues(alpha: 0.6),
        ),
        const SizedBox(width: 4),
        Text(
          '${FormatUtils.formatNumber(videoDetail.stat.view)}播放',
          style: TextStyle(
            color: colorScheme.onPrimary.withValues(alpha: 0.6),
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildProgressBar(Duration position, double maxValue, ColorScheme colorScheme) {
    return SizedBox(
      height: 20,
      child: SliderTheme(
        data: SliderThemeData(
          trackHeight: 2,
          thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 4),
          overlayShape: const RoundSliderOverlayShape(overlayRadius: 8),
          activeTrackColor: colorScheme.onPrimary,
          inactiveTrackColor: colorScheme.onPrimary.withValues(alpha: 0.24),
          thumbColor: colorScheme.onPrimary,
        ),
        child: Slider(
          value: position.inSeconds.toDouble().clamp(0, maxValue),
          max: maxValue,
          onChanged: (value) => playerController.seek(Duration(seconds: value.toInt())),
        ),
      ),
    );
  }

  Widget _buildActionRow(ColorScheme colorScheme) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 36,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: colorScheme.onPrimary.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Row(
              children: [
                Text(
                  '已关闭弹幕',
                  style: TextStyle(
                    color: colorScheme.onPrimary.withValues(alpha: 0.54),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 12),
        Icon(Icons.notes, color: colorScheme.onPrimary, size: 24),
        const SizedBox(width: 16),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          decoration: BoxDecoration(
            border: Border.all(color: colorScheme.onPrimary.withValues(alpha: 0.3)),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            '详情页',
            style: TextStyle(color: colorScheme.onPrimary, fontSize: 10),
          ),
        ),
        const SizedBox(width: 16),
        Icon(Icons.fullscreen, color: colorScheme.onPrimary, size: 24),
      ],
    );
  }
}
