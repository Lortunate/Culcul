import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/data/models/subtitle.dart';
import 'package:culcul/features/video/data/danmaku_repository.dart';
import 'package:culcul/features/video/data/video_repository.dart';
import 'package:culcul/protos/dm.pb.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'video_extra_use_cases.g.dart';

class DanmakuSegmentQuery {
  final int oid;
  final int pid;
  final int segmentIndex;

  const DanmakuSegmentQuery({
    required this.oid,
    required this.pid,
    required this.segmentIndex,
  });
}

@riverpod
VideoExtraUseCases videoExtraUseCases(Ref ref) {
  return VideoExtraUseCases(
    videoRepository: ref.read(videoRepositoryProvider),
    danmakuRepository: ref.read(danmakuRepositoryProvider),
  );
}

class VideoExtraUseCases {
  final VideoRepository videoRepository;
  final DanmakuRepository danmakuRepository;

  const VideoExtraUseCases({
    required this.videoRepository,
    required this.danmakuRepository,
  });

  Future<Result<SubtitleContent, AppError>> loadSubtitleContent(String url) async {
    try {
      return Success(await videoRepository.fetchSubtitleContent(url));
    } catch (error) {
      return Failure(AppError.fromObject(error));
    }
  }

  Future<Result<DmSegMobileReply, AppError>> loadDanmakuSegment(
    DanmakuSegmentQuery query,
  ) async {
    try {
      return Success(
        await danmakuRepository.fetchDanmakuSegment(
          oid: query.oid,
          pid: query.pid,
          segmentIndex: query.segmentIndex,
        ),
      );
    } catch (error) {
      return Failure(AppError.fromObject(error));
    }
  }
}
