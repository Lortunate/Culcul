import 'package:culcul/core/base_repository.dart';
import 'package:culcul/core/providers/api_provider.dart';
import 'package:culcul/data/api/history_api.dart';
import 'package:culcul/data/models/history/history_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'history_repository.g.dart';

@riverpod
HistoryRepository historyRepository(Ref ref) {
  return HistoryRepository(ref.watch(historyApiProvider));
}

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
