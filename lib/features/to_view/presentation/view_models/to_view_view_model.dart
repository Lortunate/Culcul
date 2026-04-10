import 'package:culcul/features/auth/auth.dart';
import 'package:culcul/features/to_view/data/models/to_view_entry.dart';
import 'package:culcul/features/to_view/to_view.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'to_view_view_model.g.dart';

@riverpod
class ToViewList extends _$ToViewList {
  @override
  Future<List<ToViewEntry>> build() async {
    final authState = ref.watch(authProvider);
    if (!authState.isLoggedIn || authState.user == null) {
      return [];
    }

    final result = await ref.read(toViewRepositoryProvider).getList();
    return result.dataOrNull ?? const <ToViewEntry>[];
  }

  Future<void> add(int aid) async {
    final result = await ref.read(toViewRepositoryProvider).add(aid: aid);
    if (result.isSuccess) {
      ref.invalidateSelf();
    }
  }

  Future<void> delete(int aid) async {
    final result = await ref.read(toViewRepositoryProvider).delete(aid: aid);
    if (result.isSuccess) {
      final currentList = state.asData?.value ?? [];
      state = AsyncValue.data(currentList.where((item) => item.aid != aid).toList());
    }
  }

  Future<void> clear() async {
    final result = await ref.read(toViewRepositoryProvider).clear();
    if (result.isSuccess) {
      state = const AsyncValue.data([]);
    }
  }
}

