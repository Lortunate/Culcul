import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/network/models/api_response.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/features/history/data/dtos/history_model_dto.dart';
import 'package:culcul/features/history/data/history_api.dart';
import 'package:culcul/features/history/data/history_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';

class _FakeHistoryApi extends Fake implements HistoryApi {
  _FakeHistoryApi({required this.response});

  final ApiResponse<HistoryResponseDataDto> response;

  @override
  Future<ApiResponse<HistoryResponseDataDto>> getHistoryCursor(
    int max,
    int viewAt,
    String business,
    int ps,
  ) async {
    return response;
  }
}

class _ThrowingHistoryApi extends Fake implements HistoryApi {
  @override
  Future<ApiResponse<HistoryResponseDataDto>> getHistoryCursor(
    int max,
    int viewAt,
    String business,
    int ps,
  ) async {
    throw StateError('network failure');
  }
}

HistoryDetailDto _detail({String bvid = 'BV1test', String business = 'archive'}) {
  return HistoryDetailDto(
    oid: 1,
    epid: 2,
    bvid: bvid,
    page: 1,
    cid: 3,
    part: 'P1',
    business: business,
    dt: 1700000000,
  );
}

HistoryItemDto _item({
  String title = 'Video',
  String authorName = 'Author',
  String cover = 'https://img.example.com/cover.jpg',
  int viewAt = 1700001000,
  int progress = 100,
  int duration = 500,
  String badge = '',
}) {
  return HistoryItemDto(
    title: title,
    longTitle: '$title Long',
    cover: cover,
    uri: 'https://bilibili.com/video/BV1test',
    history: _detail(),
    videos: 1,
    authorName: authorName,
    authorFace: 'https://img.example.com/face.jpg',
    authorMid: 100,
    viewAt: viewAt,
    progress: progress,
    badge: badge,
    showTitle: title,
    duration: duration,
    current: '1',
    total: 1,
    newDesc: '',
    isFinish: 0,
    isFav: 0,
    kid: 0,
    tagName: 'anime',
    liveStatus: 0,
  );
}

HistoryResponseDataDto _responseData(List<HistoryItemDto> items) {
  return HistoryResponseDataDto(
    cursor: const HistoryCursorDto(
      max: 0,
      viewAt: 0,
      business: 'archive',
      ps: 20,
    ),
    tab: const [],
    list: items,
  );
}

void main() {
  group('HistoryRepositoryImpl.getHistory', () {
    test('returns mapped entries on success', () async {
      final items = [
        _item(title: 'Video A', authorName: 'Author A', progress: 50, duration: 300),
        _item(title: 'Video B', authorName: 'Author B', progress: 200, duration: 600),
      ];
      final api = _FakeHistoryApi(
        response: ApiResponse(
          code: 0,
          message: 'ok',
          data: _responseData(items),
        ),
      );
      final repository = HistoryRepositoryImpl(api);

      final result = await repository.getHistory();

      expect(result.isSuccess, isTrue);
      final entries = result.dataOrNull!;
      expect(entries, hasLength(2));
      expect(entries[0].title, 'Video A');
      expect(entries[0].authorName, 'Author A');
      expect(entries[0].progress, 50);
      expect(entries[0].duration, 300);
      expect(entries[1].title, 'Video B');
      expect(entries[1].authorName, 'Author B');
    });

    test('returns empty list when API data list is empty', () async {
      final api = _FakeHistoryApi(
        response: ApiResponse(
          code: 0,
          message: 'ok',
          data: _responseData(const []),
        ),
      );
      final repository = HistoryRepositoryImpl(api);

      final result = await repository.getHistory();

      expect(result.isSuccess, isTrue);
      expect(result.dataOrNull, isEmpty);
    });

    test('returns failure when API returns error code', () async {
      final api = _FakeHistoryApi(
        response: const ApiResponse(
          code: -101,
          message: 'not logged in',
        ),
      );
      final repository = HistoryRepositoryImpl(api);

      final result = await repository.getHistory();

      expect(result.isFailure, isTrue);
      expect(result.errorOrNull, isA<ServerAppError>());
      expect(result.errorOrNull?.message, 'not logged in');
      expect(result.errorOrNull?.code, -101);
    });

    test('returns failure when API call throws exception', () async {
      final api = _ThrowingHistoryApi();
      final repository = HistoryRepositoryImpl(api);

      final result = await repository.getHistory();

      expect(result.isFailure, isTrue);
      expect(result.errorOrNull, isNotNull);
    });

    test('maps bvid and business from nested history detail', () async {
      final detail = HistoryDetailDto(
        oid: 10,
        epid: 20,
        bvid: 'BVcustom42',
        page: 1,
        cid: 30,
        part: 'P1',
        business: 'pgc',
        dt: 1700000000,
      );
      final item = HistoryItemDto(
        title: 'Special',
        longTitle: 'Special Long',
        cover: 'https://img.example.com/s.jpg',
        uri: 'https://bilibili.com',
        history: detail,
        videos: 1,
        authorName: 'Auth',
        authorFace: 'https://img.example.com/f.jpg',
        authorMid: 50,
        viewAt: 1700002000,
        progress: 60,
        badge: '',
        showTitle: 'Special',
        duration: 400,
        current: '1',
        total: 1,
        newDesc: '',
        isFinish: 0,
        isFav: 0,
        kid: 0,
        tagName: 'drama',
        liveStatus: 0,
      );
      final api = _FakeHistoryApi(
        response: ApiResponse(
          code: 0,
          message: 'ok',
          data: _responseData([item]),
        ),
      );
      final repository = HistoryRepositoryImpl(api);

      final result = await repository.getHistory();

      expect(result.isSuccess, isTrue);
      final entry = result.dataOrNull!.single;
      expect(entry.bvid, 'BVcustom42');
      expect(entry.business, 'pgc');
    });

    test('passes max and viewAt parameters to API', () async {
      int capturedMax = -1;
      int capturedViewAt = -1;

      final api = _SpyHistoryApi(
        onCall: (max, viewAt, _, __) {
          capturedMax = max;
          capturedViewAt = viewAt;
        },
        response: ApiResponse(
          code: 0,
          message: 'ok',
          data: _responseData(const []),
        ),
      );
      final repository = HistoryRepositoryImpl(api);

      await repository.getHistory(max: 42, viewAt: 99);

      expect(capturedMax, 42);
      expect(capturedViewAt, 99);
    });
  });
}

class _SpyHistoryApi extends Fake implements HistoryApi {
  _SpyHistoryApi({required this.onCall, required this.response});

  final void Function(int max, int viewAt, String business, int ps) onCall;
  final ApiResponse<HistoryResponseDataDto> response;

  @override
  Future<ApiResponse<HistoryResponseDataDto>> getHistoryCursor(
    int max,
    int viewAt,
    String business,
    int ps,
  ) async {
    onCall(max, viewAt, business, ps);
    return response;
  }
}
