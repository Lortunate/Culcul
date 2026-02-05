import 'package:culcul/data/api/history_api.dart';
import 'package:culcul/data/models/history/history_model.dart';

class HistoryRepository {
  final HistoryApi _api;

  HistoryRepository(this._api);

  Future<HistoryResponseData> getHistoryCursor({
    int max = 0,
    int viewAt = 0,
    String business = '',
    int ps = 20,
  }) async {
    final response = await _api.getHistoryCursor(max, viewAt, business, ps);
    if (response.isSuccess && response.data != null) {
      return response.data!;
    } else {
      throw Exception(response.message);
    }
  }
}
