import 'package:culcul/core/contracts/video_model_contract.dart';
import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/features/ranking/data/ranking_repository_impl.dart';
import 'package:culcul/features/ranking/presentation/view_models/category_ranking_view_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  group('categoryRankingListProvider', () {
    test('returns ranking entries for given rid', () async {
      const expected = <VideoModel>[
        VideoModel(
          bvid: 'BV1aaa',
          title: 'Top Video',
          pic: 'https://example.com/cover.jpg',
          owner: VideoOwner(mid: 0, name: 'Creator', face: ''),
          stat: VideoStat(view: 5000, danmaku: 200),
          duration: 180,
          pubDate: 0,
        ),
        VideoModel(
          bvid: 'BV2bbb',
          title: 'Second Video',
          pic: 'https://example.com/cover2.jpg',
          owner: VideoOwner(mid: 0, name: 'OtherCreator', face: ''),
          stat: VideoStat(view: 3000, danmaku: 100),
          duration: 300,
          pubDate: 0,
        ),
      ];

      final container = ProviderContainer(
        overrides: [
          rankingRepositoryProvider.overrideWithValue(
            _FakeRankingRepository(result: const Success(expected)),
          ),
        ],
      );
      addTearDown(container.dispose);

      final videos = await container.read(categoryRankingListProvider(rid: 0).future);

      expect(videos, hasLength(2));
      expect(videos[0].bvid, 'BV1aaa');
      expect(videos[0].title, 'Top Video');
      expect(videos[0].owner.name, 'Creator');
      expect(videos[0].stat.view, 5000);
      expect(videos[1].bvid, 'BV2bbb');
    });

    test('returns empty list when repository returns failure', () async {
      final container = ProviderContainer(
        overrides: [
          rankingRepositoryProvider.overrideWithValue(
            _FakeRankingRepository(
              result: const Failure(NetworkAppError('connection timeout')),
            ),
          ),
        ],
      );
      addTearDown(container.dispose);

      final videos = await container.read(categoryRankingListProvider(rid: 0).future);

      expect(videos, isEmpty);
    });

    test('returns empty list when repository returns empty success', () async {
      final container = ProviderContainer(
        overrides: [
          rankingRepositoryProvider.overrideWithValue(
            _FakeRankingRepository(result: const Success(<VideoModel>[])),
          ),
        ],
      );
      addTearDown(container.dispose);

      final videos = await container.read(categoryRankingListProvider(rid: 0).future);

      expect(videos, isEmpty);
    });

    test('passes rid to repository', () async {
      final fakeRepo = _FakeRankingRepository(result: const Success(<VideoModel>[]));
      final container = ProviderContainer(
        overrides: [rankingRepositoryProvider.overrideWithValue(fakeRepo)],
      );
      addTearDown(container.dispose);

      await container.read(categoryRankingListProvider(rid: 42).future);

      expect(fakeRepo.lastRid, 42);
    });
  });
}

class _FakeRankingRepository implements RankingRepositoryImpl {
  _FakeRankingRepository({required this.result});

  final Result<List<VideoModel>, AppError> result;
  int? lastRid;

  @override
  Future<Result<List<VideoModel>, AppError>> getRanking({int? rid}) async {
    lastRid = rid;
    return result;
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
