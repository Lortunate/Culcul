import 'package:culcul/core/base_repository.dart';
import 'package:culcul/core/providers/api_provider.dart';
import 'package:culcul/features/history/data/history_api.dart';
import 'package:culcul/features/history/data/mappers/history_mapper.dart';
import 'package:culcul/features/history/domain/entities/history_entry.dart';
import 'package:culcul/features/history/domain/repositories/history_repository.dart'
    as domain;
import 'package:culcul/features/history/models/history_models.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'history_repository.g.dart';

@riverpod
domain.HistoryRepository historyRepository(Ref ref) {
  return HistoryRepositoryImpl(ref.watch(historyApiProvider));
}

class HistoryRepositoryImpl extends BaseRepository implements domain.HistoryRepository {
  final HistoryApi _api;

  HistoryRepositoryImpl(this._api);

  Future<HistoryResponseData> getHistoryCursor({
    int max = 0,
    int viewAt = 0,
    String business = '',
    int ps = 20,
  }) {
    return requestApi(() => _api.getHistoryCursor(max, viewAt, business, ps));
  }

  @override
  Future<List<HistoryEntry>> getHistory({
    int max = 0,
    int viewAt = 0,
    String business = '',
    int pageSize = 20,
  }) async {
    final data = await getHistoryCursor(
      max: max,
      viewAt: viewAt,
      business: business,
      ps: pageSize,
    );
    return data.list.map((item) => item.toDomain()).toList();
  }
}
