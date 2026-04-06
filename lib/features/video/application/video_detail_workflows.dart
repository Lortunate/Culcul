import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/perf/video_perf_logger.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/features/video/video.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'video_detail_workflows.g.dart';

class VideoInitialData {
  final VideoDetail detail;
  final int currentCid;
  final PlayUrl? playUrl;
  final List<int> availableQualities;
  final int selectedQuality;

  const VideoInitialData({
    required this.detail,
    required this.currentCid,
    required this.playUrl,
    required this.availableQualities,
    required this.selectedQuality,
  });
}

class VideoAuxiliaryData {
  final List<RelatedVideo> relatedVideos;
  final List<VideoTag> tags;

  const VideoAuxiliaryData({required this.relatedVideos, required this.tags});
}

@riverpod
LoadVideoDetailWorkflow loadVideoDetailWorkflow(Ref ref) {
  return LoadVideoDetailWorkflow(ref.read(videoRepositoryProvider));
}

class LoadVideoDetailWorkflow {
  final VideoRepository _repository;

  const LoadVideoDetailWorkflow(this._repository);

  Future<Result<VideoInitialData, AppError>> call(String bvid) {
    return loadCritical(bvid);
  }

  Future<Result<VideoInitialData, AppError>> loadCritical(String bvid) async {
    final stopwatch = Stopwatch()..start();
    final detailResult = await _repository.fetchVideoView(bvid);
    if (detailResult.errorOrNull case final error?) {
      return Failure(error);
    }
    final detail = detailResult.dataOrNull!;
    VideoPerfLogger.log(
      VideoPerfEvent.criticalLoaded,
      fields: <String, Object?>{'bvid': bvid, 'ms': stopwatch.elapsedMilliseconds},
    );
    final cid = detail.pages.isNotEmpty ? detail.pages.first.cid : 0;

    final Result<PlayUrl?, AppError> playResult;
    if (cid == 0) {
      playResult = const Success(null);
    } else {
      final playUrlStopwatch = Stopwatch()..start();
      final loadedPlayUrl = await _repository.fetchVideoPlayUrl(
        aid: detail.aid,
        cid: cid,
      );
      if (loadedPlayUrl.dataOrNull != null) {
        VideoPerfLogger.log(
          VideoPerfEvent.playurlLoaded,
          fields: <String, Object?>{
            'bvid': bvid,
            'cid': cid,
            'ms': playUrlStopwatch.elapsedMilliseconds,
          },
        );
      }
      playResult = loadedPlayUrl.map<PlayUrl?>((value) => value);
    }

    final playUrl = playResult.dataOrNull;

    return Success(
      VideoInitialData(
        detail: detail,
        currentCid: cid,
        playUrl: playUrl,
        availableQualities: playUrl?.acceptQuality.toList() ?? const [],
        selectedQuality: playUrl?.quality ?? 80,
      ),
    );
  }

  Future<Result<VideoAuxiliaryData, AppError>> loadAuxiliary(String bvid) async {
    final relatedFuture = _repository.fetchRelatedVideos(bvid);
    final tagsFuture = _repository.fetchVideoTags(bvid);

    final relatedResult = await relatedFuture;
    final tagsResult = await tagsFuture;

    return Success(
      VideoAuxiliaryData(
        relatedVideos: relatedResult.dataOrNull ?? const [],
        tags: tagsResult.dataOrNull ?? const [],
      ),
    );
  }
}
