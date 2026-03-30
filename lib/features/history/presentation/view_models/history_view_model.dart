import 'package:culcul/features/history/application/use_case/history_use_cases.dart';
import 'package:culcul/features/history/domain/entities/history_entry.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'history_view_model.g.dart';

@riverpod
class HistoryList extends _$HistoryList {
  @override
  Future<List<HistoryEntry>> build() async {
    return _fetchHistory();
  }

  Future<List<HistoryEntry>> _fetchHistory() async {
    final result = await ref.read(historyUseCasesProvider).getHistory();
    return result.when(success: (value) => value, failure: (error) => throw error);
  }
}
