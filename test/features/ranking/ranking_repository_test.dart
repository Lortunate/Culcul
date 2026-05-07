import 'package:culcul/core/contracts/video_model_contract.dart';
import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/data/network/models/api_response.dart';
import 'package:culcul/features/ranking/data/dtos/ranking_response_dto.dart';
import 'package:culcul/features/ranking/domain/entities/ranking_video.dart';
import 'package:culcul/features/ranking/data/ranking_api.dart';
import 'package:culcul/features/ranking/data/ranking_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('RankingRepositoryImpl.getRanking', () {
    test('returns mapped RankingVideo entries on success', () async {
      final api = _FakeRankingApi(
        response: ApiResponse<RankingResponseDto>(
          code: 0,
          message: 'ok',
          data: const RankingResponseDto(
            list: [
              VideoModel(
                bvid: 'BV1aaa',
                title: 'First Video',
                pic: 'https://example.com/1.jpg',
                owner: VideoOwner(mid: 10, name: 'Alice', face: ''),
                stat: VideoStat(view: 1000, danmaku: 50),
                duration: 120,
                pubDate: 1700000000,
              ),
              VideoModel(
                bvid: 'BV2bbb',
                title: 'Second Video',
                pic: 'https://example.com/2.jpg',
                owner: VideoOwner(mid: 20, name: 'Bob', face: ''),
                stat: VideoStat(view: 2000, danmaku: 100),
                duration: 240,
                pubDate: 1700001000,
              ),
            ],
          ),
        ),
      );
      final repository = RankingRepositoryImpl(api);

      final result = await repository.getRanking(rid: 0);

      expect(result.isSuccess, isTrue);
      final videos = result.dataOrNull!;
      expect(videos, hasLength(2));

      expect(videos[0].bvid, 'BV1aaa');
      expect(videos[0].title, 'First Video');
      expect(videos[0].coverUrl, 'https://example.com/1.jpg');
      expect(videos[0].ownerName, 'Alice');
      expect(videos[0].viewCount, 1000);
      expect(videos[0].danmakuCount, 50);
      expect(videos[0].duration, 120);

      expect(videos[1].bvid, 'BV2bbb');
      expect(videos[1].ownerName, 'Bob');
      expect(videos[1].viewCount, 2000);
    });

    test('returns empty list when response data list is empty', () async {
      final api = _FakeRankingApi(
        response: const ApiResponse<RankingResponseDto>(
          code: 0,
          message: 'ok',
          data: RankingResponseDto(list: []),
        ),
      );
      final repository = RankingRepositoryImpl(api);

      final result = await repository.getRanking(rid: 0);

      expect(result.isSuccess, isTrue);
      expect(result.dataOrNull, isEmpty);
    });

    test('returns ServerAppError when API returns non-zero code', () async {
      final api = _FakeRankingApi(
        response: const ApiResponse<RankingResponseDto>(
          code: -400,
          message: 'bad request',
        ),
      );
      final repository = RankingRepositoryImpl(api);

      final result = await repository.getRanking(rid: 0);

      expect(result.isFailure, isTrue);
      expect(result.errorOrNull, isA<ServerAppError>());
      expect(result.errorOrNull?.message, 'bad request');
    });

    test('returns AppError when API call throws', () async {
      final api = _FakeRankingApi(throwError: true);
      final repository = RankingRepositoryImpl(api);

      final result = await repository.getRanking(rid: 0);

      expect(result.isFailure, isTrue);
      expect(result.errorOrNull, isA<AppError>());
    });
  });
}

class _FakeRankingApi extends Fake implements RankingApi {
  _FakeRankingApi({this.response, this.throwError = false});

  final ApiResponse<RankingResponseDto>? response;
  final bool throwError;

  @override
  Future<ApiResponse<RankingResponseDto>> fetchRanking({int? rid}) async {
    if (throwError) {
      throw Exception('network failure');
    }
    return response!;
  }
}
