import 'package:culcul/features/video/domain/repositories/danmaku_repository.dart';
import 'package:culcul/features/video/domain/repositories/video_repository.dart';
import 'package:culcul/features/video/application/video_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'video_facade.g.dart';

@riverpod
VideoFacade videoFacade(Ref ref) {
  return VideoFacade(
    ref.watch(videoRepositoryEntryProvider),
    ref.watch(danmakuRepositoryEntryProvider),
  );
}

class VideoFacade {
  VideoFacade(VideoRepository videoRepository, DanmakuRepository danmakuRepository)
    : _videoRepository = videoRepository,
      _danmakuRepository = danmakuRepository;

  // ignore: unused_field
  final VideoRepository _videoRepository;
  // ignore: unused_field
  final DanmakuRepository _danmakuRepository;
}
