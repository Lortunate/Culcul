import 'package:culcul/core/errors/exceptions.dart';
import 'package:culcul/core/base_repository.dart';
import 'package:culcul/core/result.dart';
import 'package:culcul/data/api/history_api.dart';
import 'package:culcul/data/models/history/history_model.dart';

class HistoryRepository extends BaseRepository {
  final HistoryApi _api;

  HistoryRepository(this._api);

  Future<Result<HistoryResponseData, AppException>> getHistoryCursor({
    int max = 0,
    int viewAt = 0,
    String business = '',
    int ps = 20,
  }) {
    return safeApiCall(() => _api.getHistoryCursor(max, viewAt, business, ps));
  }
}
