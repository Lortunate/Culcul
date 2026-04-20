import 'package:culcul/features/search/application/search_workflows.dart';
import 'package:culcul/shared/providers/storage_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'search_history_view_model.g.dart';

@riverpod
class SearchHistory extends _$SearchHistory {
  static const _maxHistory = 15;

  @override
  List<String> build() {
    final box = ref.watch(searchStorageBoxProvider);
    final history = box.get(StorageKeys.searchHistory, defaultValue: <String>[]);
    if (history is List) {
      return history.cast<String>();
    }
    return [];
  }

  Future<void> add(String term) async {
    final nextHistory = addSearchHistoryEntry(state, term, maxHistory: _maxHistory);
    state = nextHistory;
    await ref.read(searchStorageBoxProvider).put(StorageKeys.searchHistory, nextHistory);
  }

  Future<void> remove(String term) async {
    final nextHistory = removeSearchHistoryEntry(state, term);
    state = nextHistory;
    await ref.read(searchStorageBoxProvider).put(StorageKeys.searchHistory, nextHistory);
  }

  Future<void> clear() async {
    state = [];
    await ref.read(searchStorageBoxProvider).delete(StorageKeys.searchHistory);
  }
}
