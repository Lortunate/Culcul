import 'package:flutter_test/flutter_test.dart';

import 'package:culcul/core/data/network/models/api_response.dart';
import 'package:culcul/features/live/data/dtos/live_guard_list_dto.dart';
import 'package:culcul/features/live/data/live_api.dart';
import 'package:culcul/features/live/data/live_repository_impl.dart';

void main() {
  test('getGuardList maps transport DTO to JSON-free application model', () async {
    final api = _FakeLiveApi(
      LiveGuardListDto.fromJson({
        'info': {'num': 9, 'page': 1, 'now': 3},
        'top3': [
          {
            'ruid': 99,
            'rank': 1,
            'uinfo': {
              'uid': 42,
              'base': {'name': 'Guard Alice', 'face': 'https://example.test/a.png'},
            },
            'guard_level': 3,
          },
        ],
        'list': [
          {
            'ruid': 99,
            'rank': 4,
            'uinfo': {
              'uid': 84,
              'base': {'name': 'Guard Bob', 'face': 'https://example.test/b.png'},
            },
            'guard_level': 2,
          },
        ],
      }),
    );
    final repository = LiveRepositoryImpl(api);

    final result = await repository.getGuardList(ruid: 99, roomId: 12345, page: 2);

    expect(api.requestedRuid, 99);
    expect(api.requestedRoomId, 12345);
    expect(api.requestedPage, 2);
    final guards = result.dataOrNull;
    expect(guards, isNotNull);
    expect(guards!.info.num, 9);
    expect(guards.info.now, 3);
    expect(guards.top3.single.userInfo.uid, 42);
    expect(guards.top3.single.userInfo.base.name, 'Guard Alice');
    expect(guards.top3.single.guardLevel, 3);
    expect(guards.list.single.userInfo.base.face, 'https://example.test/b.png');
    expect(guards.list.single.guardLevel, 2);
  });
}

final class _FakeLiveApi implements LiveApi {
  _FakeLiveApi(this.response);

  final LiveGuardListDto response;
  int? requestedRuid;
  int? requestedRoomId;
  int? requestedPage;

  @override
  Future<ApiResponse<LiveGuardListDto>> getGuardList({
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
