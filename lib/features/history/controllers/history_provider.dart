import 'package:culcul/data/models/history/history_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:culcul/features/history/data/history_repository.dart';

part 'history_provider.g.dart';

@riverpod
class HistoryList extends _$HistoryList {
  @override
  Future<List<HistoryItem>> build() async {
    return _fetchHistory();
  }

  Future<List<HistoryItem>> _fetchHistory() async {
    final repository = ref.read(historyRepositoryProvider);
    final data = await repository.getHistoryCursor();
    return data.list;
  }
}
