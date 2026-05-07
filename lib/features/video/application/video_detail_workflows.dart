import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/network/request_cancel_token.dart';
import 'package:culcul/core/network/network_concurrency_executor.dart';
import 'package:culcul/core/network/network_concurrency_profiles.dart';
import 'package:culcul/core/perf/video_perf_logger.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/features/video/domain/entities/video_entities.dart';
import 'package:culcul/features/video/domain/repositories/video_repository.dart';
import 'package:culcul/features/video/feature_scope.dart';
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
  final NetworkConcurrencyExecutor _concurrencyExecutor;

  const LoadVideoDetailWorkflow(
    this._repository, {
    NetworkConcurrencyExecutor concurrencyExecutor = const NetworkConcurrencyExecutor(),
  }) : _concurrencyExecutor = concurrencyExecutor;

  Future<Result<VideoInitialData, AppError>> call(
    String bvid, {
    RequestCancelToken? cancelToken,
  }) {
    return loadCritical(bvid, cancelToken: cancelToken);
  }

  Future<Result<VideoInitialData, AppError>> loadCritical(
    String bvid, {
    RequestCancelToken? cancelToken,
  }) async {
    final stopwatch = Stopwatch()..start();
    return (await _repository.fetchVideoView(bvid, cancelToken: cancelToken)).when(
      success: (detail) async {
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
            cancelToken: cancelToken,
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
      },
      failure: (error) async => Failure(error),
    );
  }

  Future<Result<VideoAuxiliaryData, AppError>> loadAuxiliary(
    String bvid, {
    RequestCancelToken? cancelToken,
  }) async {
    final responses = await _concurrencyExecutor.runConcurrent(
      tasks: <ConcurrentTask<dynamic>>[
        ConcurrentTask<List<RelatedVideo>>(
          label: 'related',
          critical: false,
          fallback: (_) => const <RelatedVideo>[],
          task: () async {
            final result = await _repository.fetchRelatedVideos(
              bvid,
              cancelToken: cancelToken,
            );
            return result.dataOrNull ?? const <RelatedVideo>[];
          },
        ),
        ConcurrentTask<List<VideoTag>>(
          label: 'tags',
          critical: false,
          fallback: (_) => const <VideoTag>[],
          task: () async {
            final result = await _repository.fetchVideoTags(
              bvid,
              cancelToken: cancelToken,
            );
            return result.dataOrNull ?? const <VideoTag>[];
          },
        ),
      ],
      profile: NetworkConcurrencyProfile.enrich,
      scope: 'video_detail_load_auxiliary',
    );

    return Success(
      VideoAuxiliaryData(
        relatedVideos:
            responses['related'] as List<RelatedVideo>? ?? const <RelatedVideo>[],
        tags: responses['tags'] as List<VideoTag>? ?? const <VideoTag>[],
      ),
    );
  }
}
