import 'package:culcul/data/models/history/history_model.dart';
import 'package:culcul/features/history/application/use_case/history_use_cases.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'history_view_model.g.dart';

@riverpod
class HistoryList extends _$HistoryList {
  @override
  Future<List<HistoryItem>> build() async {
    return _fetchHistory();
  }

  Future<List<HistoryItem>> _fetchHistory() async {
    final result = await ref.read(historyUseCasesProvider).getHistory();
    return result.when(
      success: (value) => value,
      failure: (error) => throw Exception(error.message),
    );
  }
}
