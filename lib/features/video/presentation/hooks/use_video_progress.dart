import 'dart:async';
import 'package:culcul/features/video/controllers/video_detail_controller.dart';
import 'package:culcul/features/video/data/video_repository.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:media_kit/media_kit.dart';

void useVideoProgressReport(WidgetRef ref, String bvid, Player player, bool isPlaying) {
  final info = ref.watch(
    videoDetailControllerProvider(
      bvid,
    ).select((state) => (aid: state.videoDetail?.aid, cid: state.currentCid)),
  );

  final latestInfoRef = useRef(info);
  latestInfoRef.value = info;

  final isPlayingRef = useRef(isPlaying);
  isPlayingRef.value = isPlaying;

  final videoRepo = ref.read(videoRepositoryProvider);

  void reportProgress() {
    final pos = player.state.position.inSeconds;
    final current = latestInfoRef.value;
    if (pos > 0 && current.aid != null && current.cid != 0) {
      videoRepo.reportVideoProgress(aid: current.aid!, cid: current.cid, progress: pos);
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

