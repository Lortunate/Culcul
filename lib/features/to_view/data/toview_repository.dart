import 'package:culcul/core/errors/exceptions.dart';
import 'package:culcul/core/providers/api_provider.dart';
import 'package:culcul/core/base_repository.dart';
import 'package:culcul/core/result.dart';
import 'package:culcul/data/api/toview_api.dart';
import 'package:culcul/data/models/toview/to_view_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'toview_repository.g.dart';

@riverpod
ToViewRepository toViewRepository(Ref ref) {
  return ToViewRepository(ref.watch(toViewApiProvider));
}

class ToViewRepository extends BaseRepository {
  final ToViewApi _api;

  ToViewRepository(this._api);

  Future<Result<ToViewListResponse, AppException>> getToViewList() async {
    final result = await safeApiCall(() => _api.getToViewList());
    return switch (result) {
      Success(value: final data) => Success(data),
      Failure(exception: final e) =>
        (e is ServerException && e.code == 0 && e.message == 'No Data')
            ? Success(ToViewListResponse(count: 0, list: []))
            : Failure(e),
    };
  }

  Future<Result<void, AppException>> addToView({required int aid}) {
    return safeCall(() => _api.addToView(aid));
  }

  Future<Result<void, AppException>> deleteToView({required int aid}) {
    return safeCall(() => _api.deleteToView(aid));
  }

  Future<Result<void, AppException>> clearToView() {
    return safeCall(() => _api.clearToView());
  }
}
