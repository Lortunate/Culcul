import 'package:culcul/core/contracts/video_model_contract.dart';
import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/features/video/application/models/play_url.dart';
import 'package:culcul/features/video/application/video_detail_application_providers.dart';
import 'package:culcul/features/video/application/video_detail_models.dart';
import 'package:culcul/features/video/application/video_detail_port.dart';
import 'package:culcul/features/video/data/video_repository_impl.dart';
import 'package:culcul/features/video/presentation/detail/video_detail_state.dart';
import 'package:culcul/features/video/presentation/detail/video_detail_view_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  test('video detail interactions read through the application port', () async {
    const bvid = 'BV1xx411c7mD';
    const aid = 100;
    const cid = 200;
    final port = _FakeVideoDetailPort(playUrl: _playUrl(quality: 64));
    final provider = videoDetailControllerProvider(bvid);
    final container = ProviderContainer(
      overrides: [
        videoDetailPortProvider.overrideWithValue(port),
        provider.overrideWith(() => _SeededVideoDetailController(aid: aid, cid: cid)),
        videoRepositoryProvider.overrideWith(
          (ref) =>
              throw StateError('videoRepositoryProvider should not be read by UI state'),
        ),
      ],
    );
    addTearDown(container.dispose);
    final subscription = container.listen(provider, (_, _) {});
    addTearDown(subscription.close);

    final notifier = container.read(provider.notifier);

    await notifier.toggleVideoLike();
    await notifier.addVideoCoin();
    await notifier.reportProgress(120);
    await notifier.switchQuality(64);

    expect(port.likeCalls, const [(aid: aid, isLiked: true)]);
    expect(port.coinCalls, const [(aid: aid)]);
    expect(port.progressCalls, const [(aid: aid, cid: cid, progress: 120)]);
    expect(port.playUrlCalls, const [(aid: aid, cid: cid, quality: 64, fnval: 1)]);

    final state = container.read(provider);
    expect(state.videoDetail?.reqUser.like, 1);
    expect(state.videoDetail?.stat.like, 1);
    expect(state.videoDetail?.reqUser.coin, 1);
    expect(state.videoDetail?.stat.coin, 1);
    expect(state.playUrl, port.playUrl);
    expect(state.selectedQuality, 64);
  });
}

final class _SeededVideoDetailController extends VideoDetailController {
  _SeededVideoDetailController({required this.aid, required this.cid});

  final int aid;
  final int cid;

  @override
  VideoDetailState build(String bvid) {
    return VideoDetailState(
      isLoading: false,
      currentCid: cid,
      videoDetail: VideoDetailViewData(
        bvid: bvid,
        aid: aid,
        title: 'Video',
        pic: '',
        pubDate: 0,
        desc: '',
        owner: const VideoOwner(mid: 1, name: 'Uploader'),
        stat: const VideoStat(),
        pages: [VideoPartViewData(cid: cid)],
      ),
      availableQualities: const [80, 64],
    );
  }
}

final class _FakeVideoDetailPort implements VideoDetailPort {
  _FakeVideoDetailPort({required this.playUrl});

  final PlayUrl playUrl;
  final likeCalls = <({int aid, bool isLiked})>[];
  final coinCalls = <({int aid})>[];
  final progressCalls = <({int aid, int cid, int progress})>[];
  final playUrlCalls = <({int aid, int cid, int quality, int fnval})>[];

  @override
  Future<Result<PlayUrl, AppError>> fetchVideoPlayUrl({
    required int aid,
    required int cid,
    int quality = 80,
    int fnval = 1,
    int fnver = 0,
    int fourk = 1,
    CancelToken? cancelToken,
  }) async {
    playUrlCalls.add((aid: aid, cid: cid, quality: quality, fnval: fnval));
    return Success(playUrl);
  }

  @override
  Future<Result<void, AppError>> setVideoLike({
    required int aid,
    required bool isLiked,
  }) async {
    likeCalls.add((aid: aid, isLiked: isLiked));
    return const Success(null);
  }

  @override
  Future<Result<void, AppError>> addVideoCoin({
    required int aid,
    int count = 1,
    bool alsoLike = false,
  }) async {
    coinCalls.add((aid: aid));
    return const Success(null);
  }

  @override
  Future<Result<void, AppError>> reportVideoProgress({
    required int aid,
    required int cid,
    required int progress,
  }) async {
    progressCalls.add((aid: aid, cid: cid, progress: progress));
    return const Success(null);
  }
}

PlayUrl _playUrl({required int quality}) {
  return PlayUrl(
    format: 'dash',
    quality: quality,
    timeLength: 1000,
    acceptFormat: 'dash',
    acceptDescription: const ['64'],
    acceptQuality: const [64],
    videoCodecId: 7,
    durl: const [
      Durl(order: 1, length: 1000, size: 100, url: 'https://example.test/video.mp4'),
    ],
  );
}
