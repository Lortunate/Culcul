import 'package:culcul/features/video/domain/repositories/danmaku_repository.dart';
import 'package:culcul/features/video/domain/repositories/video_repository.dart';
import 'package:culcul/features/video/data/danmaku_repository_impl.dart';
import 'package:culcul/features/video/data/video_repository_impl.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'video_facade.g.dart';

@riverpod
VideoFacade videoFacade(Ref ref) {
  return VideoFacade(
    ref.watch(videoRepositoryProvider),
    ref.watch(danmakuRepositoryProvider),
  );
}

class VideoFacade {
  VideoFacade(this.videoRepository, this.danmakuRepository);

  final VideoRepository videoRepository;
  final DanmakuRepository danmakuRepository;
}
