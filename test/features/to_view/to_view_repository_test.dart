import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/errors/exceptions.dart';
import 'package:culcul/core/network/models/api_response.dart';
import 'package:culcul/features/to_view/data/dtos/to_view_model_dto.dart';
import 'package:culcul/features/to_view/data/to_view_api.dart';
import 'package:culcul/features/to_view/data/to_view_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ToViewRepositoryImpl', () {
    group('getList', () {
      test('returns mapped entries on success', () async {
        final api = _FakeToViewApi()
          ..getToViewListResponse = ApiResponse(
            code: 0,
            message: 'ok',
            data: ToViewListResponseDto(
              count: 2,
              list: [
                _dto(1, 'First Video', 'Owner1'),
                _dto(2, 'Second Video', 'Owner2'),
              ],
            ),
          );
        final repo = ToViewRepositoryImpl(api);

        final result = await repo.getList();

        expect(result.isSuccess, isTrue);
        final entries = result.dataOrNull!;
        expect(entries.length, 2);
        expect(entries[0].aid, 1);
        expect(entries[0].title, 'First Video');
        expect(entries[0].ownerName, 'Owner1');
        expect(entries[1].aid, 2);
        expect(entries[1].title, 'Second Video');
        expect(entries[1].ownerName, 'Owner2');
      });

      test('returns empty list when ServerAppError with code 0 and "No Data"', () async {
        final api = _FakeToViewApi()
          ..getToViewListException = const ServerException('No Data', code: 0);
        final repo = ToViewRepositoryImpl(api);

        final result = await repo.getList();

        expect(result.isSuccess, isTrue);
        expect(result.dataOrNull, isEmpty);
      });

      test('returns failure for other server errors', () async {
        final api = _FakeToViewApi()
          ..getToViewListResponse = const ApiResponse(
            code: -400,
            message: 'Bad Request',
          );
        final repo = ToViewRepositoryImpl(api);

        final result = await repo.getList();

        expect(result.isFailure, isTrue);
      });
    });

    group('add', () {
      test('delegates to API and returns success', () async {
        final api = _FakeToViewApi();
        final repo = ToViewRepositoryImpl(api);

        final result = await repo.add(aid: 42);

        expect(result.isSuccess, isTrue);
        expect(api.lastAddAid, 42);
      });

      test('returns failure when API throws', () async {
        final api = _FakeToViewApi()
          ..addToViewException = Exception('network error');
        final repo = ToViewRepositoryImpl(api);

        final result = await repo.add(aid: 1);

        expect(result.isFailure, isTrue);
      });
    });

    group('delete', () {
      test('delegates to API and returns success', () async {
        final api = _FakeToViewApi();
        final repo = ToViewRepositoryImpl(api);

        final result = await repo.delete(aid: 99);

        expect(result.isSuccess, isTrue);
        expect(api.lastDeleteAid, 99);
      });

      test('returns failure when API throws', () async {
        final api = _FakeToViewApi()
          ..deleteToViewException = Exception('network error');
        final repo = ToViewRepositoryImpl(api);

        final result = await repo.delete(aid: 1);

        expect(result.isFailure, isTrue);
      });
    });

    group('clear', () {
      test('delegates to API and returns success', () async {
        final api = _FakeToViewApi();
        final repo = ToViewRepositoryImpl(api);

        final result = await repo.clear();

        expect(result.isSuccess, isTrue);
        expect(api.clearToViewCalls, 1);
      });

      test('returns failure when API throws', () async {
        final api = _FakeToViewApi()
          ..clearToViewException = Exception('network error');
        final repo = ToViewRepositoryImpl(api);

        final result = await repo.clear();

        expect(result.isFailure, isTrue);
      });
    });
  });
}

ToViewModelDto _dto(int aid, String title, String ownerName) {
  return ToViewModelDto(
    aid: aid,
    bvid: 'BV$aid',
    title: title,
    pic: '',
    duration: 100,
    progress: 0,
    owner: ToViewOwnerModelDto(mid: aid, name: ownerName, face: ''),
    stat: ToViewStatModelDto(view: 0, danmaku: 0),
  );
}

class _FakeToViewApi implements ToViewApi {
  ApiResponse<ToViewListResponseDto> getToViewListResponse = const ApiResponse(
    code: 0,
    message: 'ok',
    data: ToViewListResponseDto(count: 0, list: []),
  );

  Object? getToViewListException;
  Exception? addToViewException;
  Exception? deleteToViewException;
  Exception? clearToViewException;

  int? lastAddAid;
  int? lastDeleteAid;
  int clearToViewCalls = 0;

  @override
  Future<ApiResponse<ToViewListResponseDto>> getToViewList() async {
    if (getToViewListException != null) throw getToViewListException!;
    return getToViewListResponse;
  }

  @override
  Future<void> addToView(int aid) async {
    if (addToViewException != null) throw addToViewException!;
    lastAddAid = aid;
  }

  @override
  Future<void> deleteToView(int aid) async {
    if (deleteToViewException != null) throw deleteToViewException!;
    lastDeleteAid = aid;
  }

  @override
  Future<void> clearToView() async {
    if (clearToViewException != null) throw clearToViewException!;
    clearToViewCalls++;
  }
}
