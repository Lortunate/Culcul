import 'package:culcul/core/constants/api_constants.dart';
import 'package:culcul/core/utils/format_utils.dart';
import 'package:culcul/data/models/video/video_detail.dart';
import 'package:culcul/providers/video/player_controller.dart';
import 'package:culcul/providers/video/video_detail_controller.dart';
import 'package:culcul/ui/pages/video/hooks/use_video_progress.dart';
import 'package:culcul/ui/pages/video/widgets/danmaku_layer.dart';
import 'package:culcul/ui/pages/video/widgets/player_gestures.dart';
import 'package:culcul/ui/pages/video/widgets/subtitle_overlay.dart';
import 'package:culcul/ui/theme/app_colors.dart';
import 'package:culcul/ui/widgets/app_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:media_kit_video/media_kit_video.dart';
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
    final controller = playerController.videoController;
    final state = ref.watch(videoDetailControllerProvider(bvid));

    final isSpeedingUp = useState(false);
    final lastLoadedCid = useRef<int?>(null);
    final lastPlayUrl = useRef<String?>(null);

    // Wakelock
    useEffect(() {
      WakelockPlus.enable();
      return () => WakelockPlus.disable();
    }, []);

    // Player initialization
    useEffect(() {
      if (state.playUrl != null && state.playUrl!.durl.isNotEmpty) {
        final url = state.playUrl!.durl.first.url;

        if (lastPlayUrl.value == url) return null;

        final bool isQualitySwitch =
            lastLoadedCid.value == state.currentCid &&
            lastPlayUrl.value != null;

        Future.microtask(() async {
          await playerController.loadVideo(
            url,
            httpHeaders: {
              'Referer': ApiConstants.referer,
              'User-Agent': ApiConstants.userAgent,
            },
            isQualitySwitch: isQualitySwitch,
            title: videoDetail.title,
            artist: videoDetail.owner.name,
            coverUrl: videoDetail.pic,
          );

          player.setRate(state.playbackSpeed);

          lastLoadedCid.value = state.currentCid;
          lastPlayUrl.value = url;
        });
      }
      return null;
    }, [state.playUrl]);

    // Report progress
    useVideoProgressReport(ref, bvid, player, playerState.isPlaying);

    return Scaffold(
      backgroundColor: Colors.black,
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          // Video Layer
          Positioned.fill(
            child: Video(
              controller: controller,
              controls: (state) => const SizedBox(),
              fit: BoxFit
                  .contain, // Maintain aspect ratio, might have black bars
            ),
          ),

          // Danmaku Layer
          Positioned.fill(child: DanmakuLayer(bvid: bvid)),

          // Subtitle Layer
          Positioned.fill(child: SubtitleOverlay(bvid: bvid)),

          // Gestures
          Positioned.fill(
            child: PlayerGestures(
              isLocked: playerState.isLocked,
              volume: player.state.volume,
              brightness: 0.5, // Simplified
              onTap: playerController.playOrPause,
              onDoubleTap: () {
                // TODO: Like action
              },
              onLongPressStart: () {
                if (playerState.isPlaying) {
                  isSpeedingUp.value = true;
                  player.setRate(2.0);
                }
              },
              onLongPressEnd: () {
                isSpeedingUp.value = false;
                player.setRate(state.playbackSpeed);
              },
              onVerticalDragUpdate:
                  (_, __) {}, // Disable for now or implement simplified
              onHorizontalDragUpdate:
                  (_) {}, // Disable seeking for now or implement
              onDragEnd: () {},
              child: Container(color: Colors.transparent),
            ),
          ),

          // Top Bar
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SafeArea(child: _buildTopBar(context)),
          ),

          // Right Bar (Interaction)
          Positioned(
            right: 8,
            bottom: 120, // Leave space for bottom bar
            child: _buildRightBar(context, videoDetail),
          ),

          // Bottom Bar (Info & Controls)
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: _buildBottomBar(
              context,
              videoDetail,
              playerState,
              playerController,
            ),
          ),

          if (isSpeedingUp.value)
            const Positioned(
              top: 40,
              child: Center(
                child: Text(
                  '2.0x Speed',
                  style: TextStyle(color: Colors.white),
                ),
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
            '12人正在看', // Mock data, replace with real data if available
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
        _buildIconAction(Icons.thumb_down_alt_rounded, 438, '不喜欢'), // Mock
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

  Widget _buildBottomBar(
    BuildContext context,
    VideoDetail detail,
    dynamic playerState,
    dynamic playerController,
  ) {
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
          // Author Info
          Row(
            children: [
              AppAvatar(url: detail.owner.face, size: 36, onTap: () {}),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    detail.owner.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    '504.4万粉丝', // Mock
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
          // Title
          Row(
            children: [
              Expanded(
                child: Text(
                  detail.title,
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
                '${FormatUtils.formatNumber(detail.stat.view)}播放',
                style: const TextStyle(color: Colors.white60, fontSize: 12),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Progress Bar
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
                value: playerState.position.inSeconds.toDouble(),
                max: playerState.duration.inSeconds.toDouble() > 0
                    ? playerState.duration.inSeconds.toDouble()
                    : 1.0,
                onChanged: (value) {
                  playerController.seek(Duration(seconds: value.toInt()));
                },
              ),
            ),
          ),
          // Controls
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
              const Icon(
                Icons.notes,
                color: Colors.white,
                size: 24,
              ), // Danmaku settings
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
