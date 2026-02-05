import 'package:culcul/core/providers/storage_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'search_history_provider.g.dart';

@riverpod
class SearchHistory extends _$SearchHistory {
  static const _key = 'search_history';
  static const _maxHistory = 15;

  @override
  List<String> build() {
    final box = ref.watch(storageBoxProvider);
    final history = box.get(_key, defaultValue: <String>[]);
    if (history is List) {
      return history.cast<String>();
    }
    return [];
  }

  Future<void> add(String term) async {
    if (term.isEmpty) return;

    final current = state.toList();
    current.remove(term);
    current.insert(0, term);

    if (current.length > _maxHistory) {
      current.removeLast();
    }

    state = current;
    await ref.read(storageBoxProvider).put(_key, current);
  }

  Future<void> remove(String term) async {
    final current = state.where((element) => element != term).toList();
    state = current;
    await ref.read(storageBoxProvider).put(_key, current);
  }

  Future<void> clear() async {
    state = [];
    await ref.read(storageBoxProvider).delete(_key);
  }
}
