import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:culcul/repositories/history_repository.dart';
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
    final response = await repository.getHistoryCursor();
    return response.list;
  }
}
