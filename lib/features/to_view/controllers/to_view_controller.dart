import 'package:culcul/core/result.dart';
import 'package:culcul/data/models/toview/to_view_model.dart';
import 'package:culcul/core/providers/api_provider.dart';
import 'package:culcul/features/auth/controllers/auth_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'to_view_controller.g.dart';

@riverpod
class ToViewList extends _$ToViewList {
  @override
  Future<List<ToViewModel>> build() async {
    final authState = ref.watch(authProvider);
    if (!authState.isLoggedIn || authState.user == null) {
      return [];
    }

    final result = await ref.read(toViewRepositoryProvider).getToViewList();
    return switch (result) {
      Success(value: final data) => data.list,
      Failure(exception: final e) => throw e,
    };
  }

  Future<void> add(int aid) async {
    final result = await ref.read(toViewRepositoryProvider).addToView(aid: aid);
    switch (result) {
      case Success():
        ref.invalidateSelf();
      case Failure(exception: final e):
        throw e;
    }
  }

  Future<void> delete(int aid) async {
    final result = await ref.read(toViewRepositoryProvider).deleteToView(aid: aid);
    switch (result) {
      case Success():
        final currentList = state.asData?.value ?? [];
        state = AsyncValue.data(currentList.where((item) => item.aid != aid).toList());
      case Failure(exception: final e):
        throw e;
    }
  }

  Future<void> clear() async {
    final result = await ref.read(toViewRepositoryProvider).clearToView();
    switch (result) {
      case Success():
        state = const AsyncValue.data([]);
      case Failure(exception: final e):
        throw e;
    }
  }
}
