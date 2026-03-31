import 'package:culcul/core/base_repository.dart';
import 'package:culcul/core/network/dio_client.dart';
import 'package:culcul/features/history/data/history_api.dart';
import 'package:culcul/features/history/data/dtos/history_model_dto.dart';
import 'package:culcul/features/history/data/history_mapper.dart';
import 'package:culcul/features/history/domain/entities/history_entry.dart';
import 'package:culcul/features/history/domain/repositories/history_repository.dart'
    as domain;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'history_repository_impl.g.dart';

@riverpod
domain.HistoryRepository historyRepository(Ref ref) {
  return HistoryRepositoryImpl(HistoryApi(ref.watch(dioClientProvider)));
}

class HistoryRepositoryImpl extends BaseRepository implements domain.HistoryRepository {
  final HistoryApi _api;

  HistoryRepositoryImpl(this._api);

  Future<HistoryResponseDataDto> getHistoryCursor({
    int max = 0,
    int viewAt = 0,
    int ps = 20,
  }) {
    return requestApi(() => _api.getHistoryCursor(max, viewAt, '', ps));
  }

  @override
  Future<List<HistoryEntry>> getHistory({
    int max = 0,
    int viewAt = 0,
    int pageSize = 20,
  }) async {
    final data = await getHistoryCursor(max: max, viewAt: viewAt, ps: pageSize);
    return data.list.map((item) => item.toDomain()).toList();
  }
}
