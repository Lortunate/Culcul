import 'package:culcul/features/history/data/history_repository_impl.dart';
import 'package:culcul/features/history/domain/entities/history_entry.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'history_controller.g.dart';

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
