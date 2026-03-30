import 'dart:async';

import 'package:culcul/core/constants/api_constants.dart';
import 'package:culcul/features/video/presentation/view_model/player_view_model.dart';
import 'package:culcul/features/video/presentation/view_model/video_detail_state.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:media_kit/media_kit.dart';

void useVideoLoader(WidgetRef ref, Player player, VideoDetailState state) {
  final playerController = ref.read(playerControllerProvider.notifier);
  final lastLoadedCid = useRef<int?>(null);
  final lastPlayUrl = useRef<String?>(null);

  useEffect(() {
    if (state.playUrl != null && state.playUrl!.durl.isNotEmpty) {
      final url = state.playUrl!.durl.first.url;

      if (lastPlayUrl.value == url) return null;

      final bool isQualitySwitch =
          lastLoadedCid.value == state.currentCid && lastPlayUrl.value != null;

      unawaited(() async {
        await playerController.loadVideo(
          url,
          httpHeaders: {
            'Referer': ApiConstants.referer,
            'User-Agent': ApiConstants.userAgent,
          },
          isQualitySwitch: isQualitySwitch,
          title: state.videoDetail?.title,
          artist: state.videoDetail?.owner.name,
          coverUrl: state.videoDetail?.pic,
        );

        player.setRate(state.playbackSpeed);

        lastLoadedCid.value = state.currentCid;
        lastPlayUrl.value = url;
      }());
    }
    return null;
  }, [state.playUrl]);

  useEffect(() {
    player.setRate(state.playbackSpeed);
    return null;
  }, [state.playbackSpeed]);
}
