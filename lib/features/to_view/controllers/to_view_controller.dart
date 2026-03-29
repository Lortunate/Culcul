import 'package:culcul/data/models/toview/to_view_model.dart';
import 'package:culcul/features/auth/controllers/auth_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:culcul/features/to_view/data/toview_repository.dart';

part 'to_view_controller.g.dart';

@riverpod
class ToViewList extends _$ToViewList {
  @override
  Future<List<ToViewModel>> build() async {
    final authState = ref.watch(authProvider);
    if (!authState.isLoggedIn || authState.user == null) {
      return [];
    }

    final data = await ref.read(toViewRepositoryProvider).getToViewList();
    return data.list;
  }

  Future<void> add(int aid) async {
    await ref.read(toViewRepositoryProvider).addToView(aid: aid);
    ref.invalidateSelf();
  }

  Future<void> delete(int aid) async {
    await ref.read(toViewRepositoryProvider).deleteToView(aid: aid);
    final currentList = state.asData?.value ?? [];
    state = AsyncValue.data(currentList.where((item) => item.aid != aid).toList());
  }

  Future<void> clear() async {
    await ref.read(toViewRepositoryProvider).clearToView();
    state = const AsyncValue.data([]);
  }
}
