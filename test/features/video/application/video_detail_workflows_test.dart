import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/data/network/request_cancel_token.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/features/video/application/video_detail_workflows.dart';
import 'package:culcul/core/contracts/video_model_contract.dart';
import 'package:culcul/features/video/data/dtos/video_detail_dto.dart';
import 'package:culcul/features/video/data/dtos/play_url_dto.dart';
import 'package:culcul/features/video/data/dtos/related_video_dto.dart';
import 'package:culcul/features/video/domain/repositories/video_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('LoadVideoDetailWorkflow', () {
    test('loadCritical only fetches detail and play url', () async {
      final repository = _FakeVideoRepository();
      final workflow = LoadVideoDetailWorkflow(repository);

      final result = await workflow.loadCritical('BV1');

      expect(result.dataOrNull, isNotNull);
      expect(repository.fetchVideoViewCount, 1);
      expect(repository.fetchVideoPlayUrlCount, 1);
      expect(repository.fetchRelatedVideosCount, 0);
      expect(repository.fetchVideoTagsCount, 0);
    });

    test('loadAuxiliary fetches related and tags concurrently', () async {
      final repository = _FakeVideoRepository(
        relatedDelay: const Duration(milliseconds: 140),
        tagsDelay: const Duration(milliseconds: 140),
      );
      final workflow = LoadVideoDetailWorkflow(repository);

      final stopwatch = Stopwatch()..start();
      final result = await workflow.loadAuxiliary('BV1');
      stopwatch.stop();

      expect(result.dataOrNull, isNotNull);
      expect(repository.fetchRelatedVideosCount, 1);
      expect(repository.fetchVideoTagsCount, 1);
      expect(stopwatch.elapsedMilliseconds, lessThan(240));
    });

    test('loadAuxiliary degrades to empty lists when requests fail', () async {
      final repository = _FakeVideoRepository(
        relatedResult: Failure(AppError.data('related failed')),
        tagsResult: Failure(AppError.data('tags failed')),
      );
      final workflow = LoadVideoDetailWorkflow(repository);

      final result = await workflow.loadAuxiliary('BV1');
      final data = result.dataOrNull;

      expect(data, isNotNull);
      expect(data!.relatedVideos, isEmpty);
      expect(data.tags, isEmpty);
    });
  });
}

class _FakeVideoRepository extends Fake implements VideoRepository {
  int fetchVideoViewCount = 0;
  int fetchVideoPlayUrlCount = 0;
  int fetchRelatedVideosCount = 0;
  int fetchVideoTagsCount = 0;

  final Duration relatedDelay;
  final Duration tagsDelay;
  final Result<VideoDetail, AppError> videoViewResult;
  final Result<PlayUrl, AppError> playUrlResult;
  final Result<List<RelatedVideo>, AppError> relatedResult;
  final Result<List<VideoTag>, AppError> tagsResult;

  _FakeVideoRepository({
    this.relatedDelay = Duration.zero,
    this.tagsDelay = Duration.zero,
    Result<VideoDetail, AppError>? videoViewResult,
    Result<PlayUrl, AppError>? playUrlResult,
    Result<List<RelatedVideo>, AppError>? relatedResult,
    Result<List<VideoTag>, AppError>? tagsResult,
  }) : videoViewResult = videoViewResult ?? Success(_buildVideoDetail()),
       playUrlResult = playUrlResult ?? Success(_buildPlayUrl()),
       relatedResult = relatedResult ?? Success(<RelatedVideo>[_buildRelatedVideo()]),
       tagsResult =
           tagsResult ?? Success(const <VideoTag>[VideoTag(tagId: 1, tagName: 'tag')]);

  @override
  Future<Result<VideoDetail, AppError>> fetchVideoView(
    String bvid, {
    RequestCancelToken? cancelToken,
  }) async {
    fetchVideoViewCount++;
    return videoViewResult;
  }

  @override
  Future<Result<PlayUrl, AppError>> fetchVideoPlayUrl({
    required int aid,
    required int cid,
    int quality = 80,
    int fnval = 1,
    int fnver = 0,
    int fourk = 1,
    RequestCancelToken? cancelToken,
  }) async {
    fetchVideoPlayUrlCount++;
    return playUrlResult;
  }

  @override
  Future<Result<List<RelatedVideo>, AppError>> fetchRelatedVideos(
    String bvid, {
    RequestCancelToken? cancelToken,
  }) async {
    fetchRelatedVideosCount++;
    if (relatedDelay > Duration.zero) {
      await Future<void>.delayed(relatedDelay);
    }
    return relatedResult;
  }

  @override
  Future<Result<List<VideoTag>, AppError>> fetchVideoTags(
    String bvid, {
    RequestCancelToken? cancelToken,
  }) async {
    fetchVideoTagsCount++;
    if (tagsDelay > Duration.zero) {
      await Future<void>.delayed(tagsDelay);
    }
    return tagsResult;
  }
}

VideoDetail _buildVideoDetail() {
  return VideoDetail(
    bvid: 'BV1',
    aid: 100,
    videos: 1,
    tid: 1,
    tname: 'test',
    copyright: 1,
    pic: 'https://example.com/pic.jpg',
    title: 'title',
    pubDate: 0,
    ctime: 0,
    desc: 'desc',
    owner: const VideoOwner(mid: 1, name: 'owner'),
    stat: const VideoStat(),
    pages: const <VideoPage>[VideoPage(cid: 1001)],
  );
}

PlayUrl _buildPlayUrl() {
  return const PlayUrl(
    format: 'flv',
    quality: 80,
    timeLength: 1000,
    acceptFormat: 'flv',
    acceptDescription: <String>['HD'],
    acceptQuality: <int>[64, 80],
    videoCodecId: 7,
    durl: <Durl>[
      Durl(order: 1, length: 1000, size: 100, url: 'https://example.com/video.flv'),
    ],
  );
}

RelatedVideo _buildRelatedVideo() {
  return RelatedVideo(
    aid: 200,
    bvid: 'BV2',
    title: 'related',
    pic: 'https://example.com/related.jpg',
    owner: const VideoOwner(mid: 2, name: 'owner2'),
    stat: const VideoStat(),
    duration: 120,
    pubDate: 0,
  );
}
