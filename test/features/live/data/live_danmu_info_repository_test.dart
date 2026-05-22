import 'package:flutter_test/flutter_test.dart';

import 'package:culcul/core/data/network/models/api_response.dart';
import 'package:culcul/features/live/data/dtos/live_danmu_info_dto.dart';
import 'package:culcul/features/live/data/live_api.dart';
import 'package:culcul/features/live/data/live_repository_impl.dart';

void main() {
  test('getDanmuInfo maps transport DTO to JSON-free application model', () async {
    final api = _FakeLiveApi(
      LiveDanmuInfoDto.fromJson({
        'token': 'danmu-token',
        'host_list': [
          {'host': 'broadcast.example.test', 'wss_port': 443, 'ws_port': 2243},
        ],
      }),
    );
    final repository = LiveRepositoryImpl(api);

    final result = await repository.getDanmuInfo(12345);

    expect(api.requestedRoomId, 12345);
    expect(api.requestedType, 0);
    final info = result.dataOrNull;
    expect(info, isNotNull);
    expect(info!.token, 'danmu-token');
    expect(info.hostList, hasLength(1));
    expect(info.hostList.single.host, 'broadcast.example.test');
    expect(info.hostList.single.wssPort, 443);
    expect(info.hostList.single.wsPort, 2243);
  });
}

final class _FakeLiveApi implements LiveApi {
  _FakeLiveApi(this.response);

  final LiveDanmuInfoDto response;
  int? requestedRoomId;
  int? requestedType;

  @override
  Future<ApiResponse<LiveDanmuInfoDto>> getDanmuInfo(int roomId, int type) async {
    requestedRoomId = roomId;
    requestedType = type;
    return ApiResponse(code: 0, message: '0', data: response);
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
