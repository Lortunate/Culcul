import 'package:culcul/core/constants/api_constants.dart';
import 'package:culcul/core/runtime/media_runtime_initializer.dart';
import 'package:culcul/features/live/presentation/view_models/live_room_view_model.dart';
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
    final colorScheme = Theme.of(context).colorScheme;
    final provider = liveRoomControllerProvider(roomId);
    final playUrl = ref.watch(provider.select((state) => state.playUrl));
    final isLoading = ref.watch(provider.select((state) => state.isLoading));

    MediaRuntimeInitializer.instance.ensureInitialized();
    final player = useMemoized(Player.new);
    final controller = useMemoized(() => VideoController(player));

    useEffect(() {
      return player.dispose;
    }, []);

    useEffect(() {
      if (playUrl != null && playUrl.durl.isNotEmpty) {
        final url = playUrl.durl.first.url;
        player.open(
          Media(
            url,
            httpHeaders: {
              'Referer': ApiConstants.referer,
              'User-Agent': ApiConstants.userAgent,
            },
          ),
        );
      }
      return null;
    }, [playUrl]);

    return Container(
      color: colorScheme.scrim,
      child: Stack(
        children: [
          Video(controller: controller),
          if (isLoading)
            Center(child: CircularProgressIndicator(color: colorScheme.onPrimary)),
        ],
      ),
    );
  }
}
