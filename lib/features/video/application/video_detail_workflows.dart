import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/contracts/video_model_contract.dart';
import 'package:dio/dio.dart';
import 'package:culcul/core/data/network/network_concurrency_executor.dart';
import 'package:culcul/core/data/network/network_concurrency_profiles.dart';
import 'package:culcul/core/perf/dev_logger.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/features/video/application/video_detail_models.dart';
import 'package:culcul/features/video/data/dtos/video_detail_dto.dart';
import 'package:culcul/features/video/data/video_repository_impl.dart';
import 'package:culcul/features/video/application/models/play_url.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'video_detail_workflows.g.dart';

class VideoInitialData {
  final VideoDetailViewData detail;
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
  final List<VideoModel> relatedVideos;
  final List<String> tags;

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
          playResult = loadedPlayUrl.map<PlayUrl?>((value) => value);
        }

        final playUrl = playResult.dataOrNull;

        return Success(
          VideoInitialData(
            detail: _videoDetailToViewData(detail),
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
        ConcurrentTask<List<VideoModel>>(
          label: 'related',
          critical: false,
          fallback: (_) => const <VideoModel>[],
          task: () async {
            final result = await _repository.fetchRelatedVideos(
              bvid,
              cancelToken: cancelToken,
            );
            return result.when(success: (data) => data, failure: (error) => throw error);
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
            return result.when(success: (data) => data, failure: (error) => throw error);
          },
        ),
      ],
      profile: NetworkConcurrencyProfile.enrich,
      scope: 'video_detail_load_auxiliary',
    );

    final relatedVideos =
        responses['related'] as List<VideoModel>? ?? const <VideoModel>[];
    final tags = responses['tags'] as List<VideoTag>? ?? const <VideoTag>[];

    return Success(
      VideoAuxiliaryData(
        relatedVideos: relatedVideos.toList(growable: false),
        tags: tags.map((tag) => tag.tagName).toList(growable: false),
      ),
    );
  }
}

VideoDetailViewData _videoDetailToViewData(VideoDetail detail, {List<VideoTag>? tags}) {
  return VideoDetailViewData(
    bvid: detail.bvid,
    aid: detail.aid,
    title: detail.title,
    pic: detail.pic,
    pubDate: detail.pubDate,
    desc: detail.desc,
    owner: detail.owner,
    stat: detail.stat,
    dimension: detail.dimension,
    subtitle: detail.subtitle,
    pages: detail.pages.map(_videoPageToViewData).toList(growable: false),
    tags: (tags ?? detail.tag).map((tag) => tag.tagName).toList(growable: false),
    reqUser: _reqUserToState(detail.reqUser),
  );
}

VideoPartViewData _videoPageToViewData(VideoPage page) {
  return VideoPartViewData(
    cid: page.cid,
    page: page.page,
    part: page.part,
    duration: page.duration,
    dimension: page.dimension,
  );
}

VideoRequestUserState _reqUserToState(ReqUser? user) {
  if (user == null) {
    return const VideoRequestUserState();
  }
  return VideoRequestUserState(
    attention: user.attention,
    guestAttention: user.guestAttention,
    like: user.like,
    coin: user.coin,
    favorite: user.favorite,
  );
}
