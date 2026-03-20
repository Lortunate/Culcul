import 'dart:async';
import 'package:culcul/features/video/controllers/video_detail_controller.dart';
import 'package:culcul/repositories/video_repository.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:media_kit/media_kit.dart';

void useVideoProgressReport(
  WidgetRef ref,
  String bvid,
  Player player,
  bool isPlaying,
) {
  final detailState = ref.watch(videoDetailControllerProvider(bvid));
  final aid = detailState.videoDetail?.aid;
  final cid = detailState.currentCid;

  final latestInfoRef = useRef((aid: aid, cid: cid));
  latestInfoRef.value = (aid: aid, cid: cid);

  final isPlayingRef = useRef(isPlaying);
  isPlayingRef.value = isPlaying;

  final videoRepo = ref.read(videoRepositoryProvider);

  void reportProgress() {
    final pos = player.state.position.inSeconds;
    final info = latestInfoRef.value;
    if (pos > 0 && info.aid != null && info.cid != 0) {
      videoRepo.reportVideoProgress(
        aid: info.aid!,
        cid: info.cid,
        progress: pos,
      );
    }
  }

  useEffect(() {
    final timer = Timer.periodic(const Duration(seconds: 30), (_) {
      if (isPlayingRef.value) {
        reportProgress();
      }
    });
    return timer.cancel;
  }, []);

  useEffect(() {
    if (!isPlaying) {
      reportProgress();
    }
    return null;
  }, [isPlaying]);

  useEffect(() {
    return reportProgress;
  }, []);
}
