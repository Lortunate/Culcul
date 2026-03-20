import 'package:culcul/core/constants/api_constants.dart';
import 'package:culcul/features/live/controllers/live_room_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';

class LivePlayerView extends HookConsumerWidget {
  final int roomId;

  const LivePlayerView({super.key, required this.roomId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(liveRoomControllerProvider(roomId));

    final player = useMemoized(() => Player());
    final controller = useMemoized(() => VideoController(player));

    useEffect(() {
      return () {
        player.dispose();
      };
    }, []);

    useEffect(() {
      if (state.playUrl != null && state.playUrl!.durl.isNotEmpty) {
        final url = state.playUrl!.durl.first.url;
        player.open(
          Media(
            url,
            httpHeaders: {
              'Referer': ApiConstants.referer,
              'User-Agent': ApiConstants.userAgent,
            },
          ),
          play: true,
        );
      }
      return null;
    }, [state.playUrl]);

    return Container(
      color: Colors.black,
      child: Stack(
        children: [
          Video(
            controller: controller,
            controls: (state) => AdaptiveVideoControls(state),
          ),
          if (state.isLoading)
            const Center(child: CircularProgressIndicator(color: Colors.white)),
        ],
      ),
    );
  }
}
