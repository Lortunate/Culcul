import 'package:culcul/core/errors/app_error.dart';
import 'package:dio/dio.dart';
import 'package:culcul/core/data/network/network_concurrency_executor.dart';
import 'package:culcul/core/data/network/network_concurrency_profiles.dart';
import 'package:culcul/core/perf/dev_logger.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/features/video/application/video_view_contracts.dart';
import 'package:culcul/features/video/data/video_repository_impl.dart';
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
  final VideoRepositoryImpl _repository;
  final NetworkConcurrencyExecutor _concurrencyExecutor;

  const LoadVideoDetailWorkflow(
    this._repository, {
    NetworkConcurrencyExecutor concurrencyExecutor = const NetworkConcurrencyExecutor(),
  }) : _concurrencyExecutor = concurrencyExecutor;

  Future<Result<VideoInitialData, AppError>> call(
    String bvid, {
    CancelToken? cancelToken,
  }) {
    return loadCritical(bvid, cancelToken: cancelToken);
  }

  Future<Result<VideoInitialData, AppError>> loadCritical(
    String bvid, {
    CancelToken? cancelToken,
  }) async {
    final stopwatch = Stopwatch()..start();
    return (await _repository.fetchVideoView(bvid, cancelToken: cancelToken)).when(
      success: (detail) async {
        DevLogger.log('video', 'critical_loaded', <String, Object?>{
          'bvid': bvid,
          'ms': stopwatch.elapsedMilliseconds,
        });
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
            DevLogger.log('video', 'playurl_loaded', <String, Object?>{
              'bvid': bvid,
              'cid': cid,
              'ms': playUrlStopwatch.elapsedMilliseconds,
            });
          }
          playResult = loadedPlayUrl.map<PlayUrl?>((value) => value.toPlayUrl());
        }

        final playUrl = playResult.dataOrNull;

        return Success(
          VideoInitialData(
            detail: detail.toVideoDetail(),
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
    CancelToken? cancelToken,
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
            return result.when(
              success: (data) => data.toRelatedVideos(),
              failure: (error) => throw error,
            );
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
            return result.when(
              success: (data) => data.map((item) => item.toVideoTag()).toList(),
              failure: (error) => throw error,
            );
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
