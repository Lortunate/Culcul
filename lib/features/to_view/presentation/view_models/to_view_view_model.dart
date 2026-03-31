import 'package:culcul/features/auth/presentation/view_models/auth_view_model.dart';
import 'package:culcul/features/to_view/domain/entities/to_view_entry.dart';
import 'package:culcul/features/to_view/to_view_providers.dart';
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

    return ref.read(toViewRepositoryProvider).getList();
  }

  Future<void> add(int aid) async {
    try {
      await ref.read(toViewRepositoryProvider).add(aid: aid);
      ref.invalidateSelf();
    } catch (_) {
      // Keep current state when action fails.
    }
  }

  Future<void> delete(int aid) async {
    try {
      await ref.read(toViewRepositoryProvider).delete(aid: aid);
      final currentList = state.asData?.value ?? [];
      state = AsyncValue.data(currentList.where((item) => item.aid != aid).toList());
    } catch (_) {
      // Keep current state when action fails.
    }
  }

  Future<void> clear() async {
    try {
      await ref.read(toViewRepositoryProvider).clear();
      state = const AsyncValue.data([]);
    } catch (_) {
      // Keep current state when action fails.
    }
  }
}
