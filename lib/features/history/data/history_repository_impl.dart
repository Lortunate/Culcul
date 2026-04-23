import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/shared/network/dio_client.dart';
import 'package:culcul/shared/network/request_executor.dart';
import 'package:culcul/shared/network/request_executor_binding.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/features/history/data/history_api.dart';
import 'package:culcul/features/history/data/dtos/history_model_dto.dart';
import 'package:culcul/features/history/data/history_mapper.dart';
import 'package:culcul/features/history/data/models/history_entry.dart';
import 'package:culcul/features/history/data/history_repository.dart'
    as domain;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'history_repository_impl.g.dart';

@riverpod
domain.HistoryRepository historyRepository(Ref ref) {
  return HistoryRepositoryImpl(HistoryApi(ref.watch(dioClientProvider)));
}

class HistoryRepositoryImpl with RequestExecutorBinding implements domain.HistoryRepository {
  static const int _defaultPageSize = 20;
  final HistoryApi _api;
  final RequestExecutor _requestExecutor;

  HistoryRepositoryImpl(this._api, {RequestExecutor? requestExecutor})
    : _requestExecutor = requestExecutor ?? const RequestExecutor();

  @override
  RequestExecutor get requestExecutor => _requestExecutor;

  Future<Result<HistoryResponseDataDto, AppError>> getHistoryCursor({
    int max = 0,
    int viewAt = 0,
    int ps = _defaultPageSize,
  }) {
    return requestApiResult(() => _api.getHistoryCursor(max, viewAt, '', ps));
  }

  @override
  Future<Result<List<HistoryEntry>, AppError>> getHistory({
    int max = 0,
    int viewAt = 0,
  }) async {
    final result = await getHistoryCursor(max: max, viewAt: viewAt);
    return result.map((data) => data.list.map((item) => item.toDomain()).toList());
  }
}
