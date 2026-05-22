import 'package:flutter_test/flutter_test.dart';

import 'package:culcul/core/data/network/models/api_response.dart';
import 'package:culcul/features/live/data/dtos/live_gold_rank_dto.dart';
import 'package:culcul/features/live/data/live_api.dart';
import 'package:culcul/features/live/data/live_repository_impl.dart';

void main() {
  test('getOnlineGoldRank maps transport DTO to JSON-free application model', () async {
    final api = _FakeLiveApi(
      LiveGoldRankDto.fromJson({
        'onlineNum': 123456,
        'OnlineRankItem': [
          {
            'userRank': 1,
            'uid': 42,
            'name': 'Alice',
            'face': 'https://example.test/avatar.png',
            'score': 9001,
            'medalInfo': {
              'guardLevel': 3,
              'medalColorStart': 1,
              'medalColorEnd': 2,
              'medalColorBorder': 3,
              'medalName': 'Captain',
              'level': 21,
              'targetId': 99,
              'isLight': 1,
            },
            'guard_level': 2,
            'wealth_level': 7,
          },
        ],
      }),
    );
    final repository = LiveRepositoryImpl(api);

    final result = await repository.getOnlineGoldRank(ruid: 99, roomId: 12345, page: 2);

    expect(api.requestedRuid, 99);
    expect(api.requestedRoomId, 12345);
    expect(api.requestedPage, 2);
    final rank = result.dataOrNull;
    expect(rank, isNotNull);
    expect(rank!.onlineNum, 123456);
    expect(rank.list, hasLength(1));
    final item = rank.list.single;
    expect(item.face, 'https://example.test/avatar.png');
    expect(item.score, 9001);
    expect(item.guardLevel, 2);
    expect(item.wealthLevel, 7);
    expect(item.medalInfo.medalName, 'Captain');
    expect(item.medalInfo.guardLevel, 3);
  });
}

final class _FakeLiveApi implements LiveApi {
  _FakeLiveApi(this.response);

  final LiveGoldRankDto response;
  int? requestedRuid;
  int? requestedRoomId;
  int? requestedPage;

  @override
  Future<ApiResponse<LiveGoldRankDto>> getOnlineGoldRank({
    required int ruid,
    required int roomId,
    int page = 1,
    int pageSize = 20,
  }) async {
    requestedRuid = ruid;
    requestedRoomId = roomId;
    requestedPage = page;
    return ApiResponse(code: 0, message: '0', data: response);
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
