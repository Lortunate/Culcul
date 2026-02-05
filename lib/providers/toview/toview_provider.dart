import 'package:culcul/data/models/toview/to_view_model.dart';
import 'package:culcul/core/providers/api_provider.dart';
import 'package:culcul/repositories/toview_repository.dart';
import 'package:culcul/providers/auth/auth_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'toview_provider.g.dart';

@riverpod
class ToViewList extends _$ToViewList {
  @override
  Future<List<ToViewModel>> build() async {
    final authState = ref.watch(authProvider);
    if (!authState.isLoggedIn || authState.user == null) {
      return [];
    }

    final response = await ref.read(toViewRepositoryProvider).getToViewList();
    return response.list;
  }

  Future<void> addToView(int aid) async {
    await ref.read(toViewRepositoryProvider).addToView(aid: aid);
    ref.invalidateSelf();
  }

  Future<void> deleteToView(int aid) async {
    await ref.read(toViewRepositoryProvider).deleteToView(aid: aid);
    final currentList = state.asData?.value ?? [];
    state = AsyncValue.data(
      currentList.where((item) => item.aid != aid).toList(),
    );
  }

  Future<void> clearToView() async {
    await ref.read(toViewRepositoryProvider).clearToView();
    state = const AsyncValue.data([]);
  }
}
