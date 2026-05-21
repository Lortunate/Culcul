import 'package:culcul/core/utils/format_utils.dart';
import 'package:culcul/features/video/application/video_detail_models.dart';
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

part 'vertical_video_page.top_right.dart';
part 'vertical_video_page.bottom_bar.dart';

typedef _VideoAction = ({IconData icon, int count, String label});

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
    final loaderInput = watchVideoLoaderInput(ref, bvid);
    final player = playerController.player;

    useVideoLoader(ref, player, loaderInput, sessionId: sessionId);
    final brightness = usePlayerSystemSettings(player);
    useVideoProgressReport(ref, bvid, player, isPlaying);

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
                const Positioned.fill(child: VideoLayer()),
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
