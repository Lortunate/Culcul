import 'package:culcul/core/bootstrap/providers/storage_provider.dart';
import 'package:culcul/core/storage/storage_keys.dart';
import 'package:culcul/features/search/application/search_workflows.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'search_history_view_model.g.dart';

@riverpod
class SearchHistory extends _$SearchHistory {
  @override
  List<String> build() {
    final prefs = ref.watch(sharedPreferencesProvider);
    return prefs.getStringList(StorageKeys.searchHistory) ?? [];
  }

  Future<void> add(String term) async {
    final nextHistory = addSearchHistoryEntry(state, term);
    state = nextHistory;
    await ref
        .read(sharedPreferencesProvider)
        .setStringList(StorageKeys.searchHistory, nextHistory);
  }

  Future<void> remove(String term) async {
    final nextHistory = removeSearchHistoryEntry(state, term);
    state = nextHistory;
    await ref
        .read(sharedPreferencesProvider)
        .setStringList(StorageKeys.searchHistory, nextHistory);
  }

  Future<void> clear() async {
    state = [];
    await ref.read(sharedPreferencesProvider).remove(StorageKeys.searchHistory);
  }
}
