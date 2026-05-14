import 'package:culcul/features/history/data/dtos/history_entry.dart';
import 'package:culcul/features/history/data/history_repository_impl.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'history_view_model.g.dart';

@riverpod
class HistoryList extends _$HistoryList {
  @override
  Future<List<HistoryEntry>> build() async {
    return _fetchHistory();
  }

  Future<List<HistoryEntry>> _fetchHistory() async {
    final result = await ref.read(historyRepositoryProvider).getHistory();
    return result.when(
      success: (data) => data,
      failure: (error) {
        debugPrint('Error loading history: $error');
        return const <HistoryEntry>[];
      },
    );
  }
}
