import 'package:culcul/core/utils/format_utils.dart';
import 'package:culcul/features/video/presentation/player/hooks/use_player_system_settings.dart';
import 'package:culcul/features/video/presentation/player/hooks/use_video_loader.dart';
import 'package:culcul/features/video/presentation/player/hooks/use_video_progress.dart';
import 'package:culcul/features/video/presentation/player/hooks/use_video_session.dart';
import 'package:culcul/features/video/presentation/player/playback_snapshot_view_model.dart';
import 'package:culcul/features/video/presentation/player/player_view_model.dart';
import 'package:culcul/features/video/presentation/detail/video_detail_view_model.dart';
import 'package:culcul/features/video/presentation/overlays/layers/danmaku_layer.dart';
import 'package:culcul/features/video/presentation/overlays/layers/interaction_layer.dart';
import 'package:culcul/features/video/presentation/overlays/layers/subtitle_layer.dart';
import 'package:culcul/features/video/presentation/overlays/layers/video_layer.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/ui/widgets/users/app_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class VerticalVideoPage extends HookConsumerWidget {
  final String bvid;

  const VerticalVideoPage({super.key, required this.bvid});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final videoDetail = ref.watch(
      videoDetailControllerProvider(bvid).select((state) => state.videoDetail),
    );
    final sessionId = useVideoSession(ref, bvid);

    if (videoDetail == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final playerController = ref.read(playerControllerProvider.notifier);
    final isPlaying = ref.watch(
      playerControllerProvider.select((value) => value.isPlaying),
    );
    final player = playerController.player;

    useVideoLoader(ref, player, bvid, sessionId: sessionId);
    final brightness = usePlayerSystemSettings(player);
    useVideoProgressReport(ref, bvid, player, isPlaying);

    final volumeSnapshot = useStream(player.stream.volume);
    final currentVolume = volumeSnapshot.data ?? player.state.volume;
    final t = context.t;
    final actions = <({IconData icon, int count})>[
      (icon: Icons.thumb_up_rounded, count: videoDetail.stat.like),
      (icon: Icons.comment_rounded, count: videoDetail.stat.reply),
      (icon: Icons.thumb_down_alt_rounded, count: 438),
      (icon: Icons.star_rounded, count: videoDetail.stat.favorite),
      (icon: Icons.share_rounded, count: videoDetail.stat.share),
    ];

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
                const Positioned.fill(child: VideoLayer()),
                Positioned.fill(child: DanmakuLayer(bvid: bvid)),
                Positioned.fill(child: SubtitleLayer(bvid: bvid)),
              ],
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: context.pop,
                      child: Icon(
                        Icons.arrow_back_ios_new,
                        color: colorScheme.onPrimary,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      t.video.watching_count(count: '12'),
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
              ),
            ),
          ),
          Positioned(
            right: 8,
            bottom: 120,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                for (var index = 0; index < actions.length; index++) ...[
                  Column(
                    children: [
                      Icon(actions[index].icon, color: colorScheme.onPrimary, size: 32),
                      const SizedBox(height: 4),
                      Text(
                        FormatUtils.formatNumber(actions[index].count),
                        style: TextStyle(
                          color: colorScheme.onPrimary,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  if (index != actions.length - 1) const SizedBox(height: 20),
                ],
              ],
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Consumer(
              builder: (context, ref, child) {
                final position = ref.watch(playbackPositionProvider);
                final duration = ref.watch(playbackDurationProvider);
                final maxValue = duration.inSeconds > 0
                    ? duration.inSeconds.toDouble()
                    : 1.0;

                return Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        colorScheme.scrim.withValues(alpha: 0.87),
                      ],
                    ),
                  ),
                  padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          AppAvatar(url: videoDetail.owner.face, size: 36),
                          const SizedBox(width: 8),
                          Text(
                            videoDetail.owner.name,
                            style: TextStyle(
                              color: colorScheme.onPrimary,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      // Keep high contrast for on-video readability.
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              videoDetail.title,
                              style: TextStyle(
                                color: colorScheme.onPrimary,
                                fontSize: 14,
                              ),
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
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(
                            Icons.play_circle_outline,
                            size: 12,
                            color: colorScheme.onPrimary.withValues(alpha: 0.6),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            t.common.view_count(
                              count: FormatUtils.formatNumber(videoDetail.stat.view),
                            ),
                            style: TextStyle(
                              color: colorScheme.onPrimary.withValues(alpha: 0.6),
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        height: 20,
                        child: SliderTheme(
                          data: SliderThemeData(
                            trackHeight: 2,
                            thumbShape: const RoundSliderThumbShape(
                              enabledThumbRadius: 4,
                            ),
                            overlayShape: const RoundSliderOverlayShape(overlayRadius: 8),
                            activeTrackColor: colorScheme.onPrimary,
                            inactiveTrackColor: colorScheme.onPrimary.withValues(
                              alpha: 0.24,
                            ),
                            thumbColor: colorScheme.onPrimary,
                          ),
                          child: Slider(
                            value: position.inSeconds.toDouble().clamp(0, maxValue),
                            max: maxValue,
                            onChanged: (value) =>
                                playerController.seek(Duration(seconds: value.toInt())),
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
                                color: colorScheme.onPrimary.withValues(alpha: 0.12),
                                borderRadius: BorderRadius.circular(18),
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    t.video.player.danmaku_closed,
                                    style: TextStyle(
                                      color: colorScheme.onPrimary.withValues(
                                        alpha: 0.54,
                                      ),
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
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: colorScheme.onPrimary.withValues(alpha: 0.3),
                              ),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              t.video.detail_page,
                              style: TextStyle(
                                color: colorScheme.onPrimary,
                                fontSize: 10,
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Icon(Icons.fullscreen, color: colorScheme.onPrimary, size: 24),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
