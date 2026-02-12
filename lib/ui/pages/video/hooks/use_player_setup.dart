import 'package:culcul/core/constants/api_constants.dart';
import 'package:culcul/providers/video/player_controller.dart';
import 'package:culcul/providers/video/video_detail_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:media_kit/media_kit.dart';
import 'package:screen_brightness/screen_brightness.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

({ValueNotifier<double> brightness, double videoWidth, double videoHeight})
usePlayerSetup(
  WidgetRef ref,
  String bvid,
  Player player,
  VideoDetailState state,
) {
  final playerController = ref.read(playerControllerProvider.notifier);
  final brightness = useState(0.5);
  final lastLoadedCid = useRef<int?>(null);
  final lastPlayUrl = useRef<String?>(null);
  final videoWidth = useState(player.state.width ?? 0);
  final videoHeight = useState(player.state.height ?? 0);

  useEffect(() {
    final sub = player.stream.playing.listen((playing) {
      if (playing) {
        WakelockPlus.enable();
      } else {
        WakelockPlus.disable();
      }
    });
    return sub.cancel;
  }, []);

  useEffect(() {
    ScreenBrightness().application
        .then((val) {
          brightness.value = val;
        })
        .catchError((e) {
          debugPrint('Failed to get brightness: $e');
        });
    return null;
  }, []);

  useEffect(() {
    if (state.playUrl != null && state.playUrl!.durl.isNotEmpty) {
      final url = state.playUrl!.durl.first.url;

      if (lastPlayUrl.value == url) return null;

      final bool isQualitySwitch =
          lastLoadedCid.value == state.currentCid && lastPlayUrl.value != null;

      Future.microtask(() async {
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
      });
    }
    return null;
  }, [state.playUrl]);

  useEffect(() {
    player.setRate(state.playbackSpeed);
    return null;
  }, [state.playbackSpeed]);

  useEffect(() {
    final sub = player.stream.videoParams.listen((_) {
      videoWidth.value = player.state.width ?? 0;
      videoHeight.value = player.state.height ?? 0;
    });
    return sub.cancel;
  }, []);

  return (
    videoWidth: videoWidth.value.toDouble(),
    videoHeight: videoHeight.value.toDouble(),
    brightness: brightness,
  );
}
