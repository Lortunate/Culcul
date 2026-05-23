import 'package:culcul/core/contracts/video_model_contract.dart';
import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/features/ranking/application/ranking_application_providers.dart';
import 'package:culcul/features/ranking/application/ranking_port.dart';
import 'package:culcul/features/ranking/data/ranking_api.dart';
import 'package:culcul/features/ranking/data/ranking_repository_impl.dart';
import 'package:culcul/features/ranking/presentation/view_models/category_ranking_view_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  test('category ranking reads through the ranking application port', () async {
    final video = _videoModel(bvid: 'BV1');
    final port = _FakeRankingPort(videos: [video]);
    final container = ProviderContainer(
      overrides: [
        rankingPortProvider.overrideWithValue(port),
        rankingRepositoryProvider.overrideWithValue(_ThrowingRankingRepository()),
      ],
    );
    addTearDown(container.dispose);

    final videos = await container.read(categoryRankingListProvider(rid: 1).future);

    expect(videos, [video]);
    expect(port.requestedRids, const [1]);
  });
}

VideoModel _videoModel({required String bvid}) {
  return VideoModel(
    bvid: bvid,
    title: 'Title $bvid',
    pic: 'https://example.test/$bvid.jpg',
    owner: const VideoOwner(mid: 1, name: 'owner'),
    stat: const VideoStat(view: 1),
    duration: 60,
    pubDate: 1,
  );
}

final class _FakeRankingPort implements RankingPort {
  _FakeRankingPort({required this.videos});

  final List<VideoModel> videos;
  final List<int?> requestedRids = [];

  @override
  Future<Result<List<VideoModel>, AppError>> getRanking({int? rid}) async {
    requestedRids.add(rid);
    return Success(videos);
  }
}

final class _ThrowingRankingRepository extends RankingRepositoryImpl {
  _ThrowingRankingRepository() : super(_UnsupportedRankingApi());

  @override
  Future<Result<List<VideoModel>, AppError>> getRanking({int? rid}) {
    throw StateError('rankingRepositoryProvider should not be read by UI state');
  }
}

final class _UnsupportedRankingApi implements RankingApi {
  @override
  dynamic noSuchMethod(Invocation invocation) => throw UnimplementedError();
}
