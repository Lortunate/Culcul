import 'package:culcul/core/utils/format_utils.dart';
import 'package:culcul/data/models/video/video_detail.dart';
import 'package:culcul/features/video/logic/player_controller.dart';
import 'package:culcul/features/video/logic/video_detail_controller.dart';
import 'package:culcul/features/video/presentation/hooks/use_player_system_settings.dart';
import 'package:culcul/features/video/presentation/hooks/use_video_loader.dart';
import 'package:culcul/features/video/presentation/hooks/use_video_progress.dart';
import 'package:culcul/ui/pages/video/widgets/layers/danmaku_layer.dart';
import 'package:culcul/ui/pages/video/widgets/layers/interaction_layer.dart';
import 'package:culcul/ui/pages/video/widgets/layers/subtitle_layer.dart';
import 'package:culcul/ui/pages/video/widgets/layers/video_layer.dart';
import 'package:culcul/ui/theme/app_colors.dart';
import 'package:culcul/ui/widgets/app_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:media_kit/media_kit.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

class VerticalVideoPage extends HookConsumerWidget {
  final String bvid;
  final VideoDetail videoDetail;

  const VerticalVideoPage({
    super.key,
    required this.bvid,
    required this.videoDetail,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
      backgroundColor: Colors.black,
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

          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SafeArea(child: _buildTopBar(context)),
          ),

          Positioned(
            right: 8,
            bottom: 120,
            child: _buildRightBar(context, videoDetail),
          ),

          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: _BottomBar(
              videoDetail: videoDetail,
              player: player,
              playerController: playerController,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => context.pop(),
            child: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.white,
              size: 20,
            ),
          ),
          const SizedBox(width: 8),
          const Text(
            '12人正在看', // TODO: Real data
            style: TextStyle(color: Colors.white70, fontSize: 12),
          ),
          const Spacer(),
          const Icon(Icons.search, color: Colors.white, size: 24),
          const SizedBox(width: 16),
          const Icon(Icons.more_vert, color: Colors.white, size: 24),
        ],
      ),
    );
  }

  Widget _buildRightBar(BuildContext context, VideoDetail detail) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildIconAction(Icons.thumb_up_rounded, detail.stat.like, '点赞'),
        const SizedBox(height: 20),
        _buildIconAction(Icons.comment_rounded, detail.stat.reply, '评论'),
        const SizedBox(height: 20),
        _buildIconAction(Icons.thumb_down_alt_rounded, 438, '不喜欢'),
        const SizedBox(height: 20),
        _buildIconAction(Icons.star_rounded, detail.stat.favorite, '收藏'),
        const SizedBox(height: 20),
        _buildIconAction(Icons.share_rounded, detail.stat.share, '转发'),
      ],
    );
  }

  Widget _buildIconAction(IconData icon, int count, String label) {
    return Column(
      children: [
        Icon(icon, color: Colors.white, size: 32),
        const SizedBox(height: 4),
        Text(
          FormatUtils.formatNumber(count),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class _BottomBar extends HookWidget {
  final VideoDetail videoDetail;
  final Player player;
  final PlayerController playerController;

  const _BottomBar({
    required this.videoDetail,
    required this.player,
    required this.playerController,
  });

  @override
  Widget build(BuildContext context) {
    final positionSnapshot = useStream(player.stream.position);
    final durationSnapshot = useStream(player.stream.duration);
    final position = positionSnapshot.data ?? Duration.zero;
    final duration = durationSnapshot.data ?? Duration.zero;

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.transparent, Colors.black87],
        ),
      ),
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              AppAvatar(url: videoDetail.owner.face, size: 36, onTap: () {}),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    videoDetail.owner.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    '504.4万粉丝', // TODO: Real data
                    style: TextStyle(color: Colors.white70, fontSize: 12),
                  ),
                ],
              ),
              const SizedBox(width: 12),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Text(
                  '+ 关注',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: Text(
                  videoDetail.title,
                  style: const TextStyle(color: Colors.white, fontSize: 14),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 4),
              const Icon(
                Icons.keyboard_arrow_down,
                color: Colors.white70,
                size: 20,
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              const Icon(
                Icons.play_circle_outline,
                size: 12,
                color: Colors.white60,
              ),
              const SizedBox(width: 4),
              Text(
                '${FormatUtils.formatNumber(videoDetail.stat.view)}播放',
                style: const TextStyle(color: Colors.white60, fontSize: 12),
              ),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 20,
            child: SliderTheme(
              data: SliderThemeData(
                trackHeight: 2,
                thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 4),
                overlayShape: const RoundSliderOverlayShape(overlayRadius: 8),
                activeTrackColor: Colors.white,
                inactiveTrackColor: Colors.white24,
                thumbColor: Colors.white,
              ),
              child: Slider(
                value: position.inSeconds.toDouble(),
                max: duration.inSeconds.toDouble() > 0
                    ? duration.inSeconds.toDouble()
                    : 1.0,
                onChanged: (value) {
                  playerController.seek(Duration(seconds: value.toInt()));
                },
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 36,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.white12,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: const Row(
                    children: [
                      Text(
                        '已关闭弹幕',
                        style: TextStyle(color: Colors.white54, fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 12),
              const Icon(Icons.notes, color: Colors.white, size: 24),
              const SizedBox(width: 16),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white30),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Text(
                  '详情页',
                  style: TextStyle(color: Colors.white, fontSize: 10),
                ),
              ),
              const SizedBox(width: 16),
              const Icon(Icons.fullscreen, color: Colors.white, size: 24),
            ],
          ),
        ],
      ),
    );
  }
}
