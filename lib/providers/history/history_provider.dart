import 'package:culcul/core/types/result.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/models/history/history_model.dart';
import '../../core/providers/api_provider.dart';

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
