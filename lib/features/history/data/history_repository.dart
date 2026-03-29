import 'package:culcul/core/base_repository.dart';
import 'package:culcul/data/api/history_api.dart';
import 'package:culcul/data/models/history/history_model.dart';

class HistoryRepository extends BaseRepository {
  final HistoryApi _api;

  HistoryRepository(this._api);

  Future<HistoryResponseData> getHistoryCursor({
    int max = 0,
    int viewAt = 0,
    String business = '',
    int ps = 20,
  }) {
    return requestApi(() => _api.getHistoryCursor(max, viewAt, business, ps));
  }
}

