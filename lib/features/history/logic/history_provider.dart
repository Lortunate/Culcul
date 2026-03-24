import 'package:culcul/core/result.dart';
import 'package:culcul/core/providers/api_provider.dart';
import 'package:culcul/data/models/history/history_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'history_provider.g.dart';

@riverpod
class HistoryList extends _$HistoryList {
  @override
  Future<List<HistoryItem>> build() async {
    return _fetchHistory();
  }

  Future<List<HistoryItem>> _fetchHistory() async {
    final repository = ref.read(historyRepositoryProvider);
    final result = await repository.getHistoryCursor();

    return switch (result) {
      Success(value: final data) => data.list,
      Failure(exception: final e) => throw e,
    };
  }
}
