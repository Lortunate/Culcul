import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/data/network/dio_client.dart';
import 'package:culcul/core/data/network/request_executor.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/core/utils/json_utils.dart';
import 'package:culcul/features/history/data/history_api.dart';
import 'package:culcul/features/history/models/history_entry.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'history_repository_impl.g.dart';

@riverpod
HistoryRepositoryImpl historyRepository(Ref ref) {
  return HistoryRepositoryImpl(HistoryApi(ref.watch(dioClientProvider)));
}

class HistoryRepositoryImpl {
  final HistoryApi _api;
  final RequestExecutor _requestExecutor;

  HistoryRepositoryImpl(
    this._api, {
    RequestExecutor requestExecutor = const RequestExecutor(),
  }) : _requestExecutor = requestExecutor;

  Future<Result<List<HistoryEntry>, AppError>> getHistory({
    int max = 0,
    int viewAt = 0,
  }) async {
    return _requestExecutor.runApi<List<HistoryEntry>, Object>(
      () => _api.getHistoryCursor(max, viewAt, '', 20),
      transform: (data) {
        final map = JsonUtils.asStringKeyedMap(data);
        final list = map?['list'];
        if (list is! List) {
          return const <HistoryEntry>[];
        }
        return [
          for (final item in list)
            if (item is Map<String, dynamic>)
              HistoryEntry.fromJson(item)
            else if (item is Map)
              HistoryEntry.fromJson(Map<String, dynamic>.from(item)),
        ];
      },
    );
  }
}
