import 'package:culcul/data/models/toview/to_view_model.dart';
import 'package:culcul/features/auth/presentation/view_model/auth_view_model.dart';
import 'package:culcul/features/to_view/application/use_case/to_view_use_cases.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'to_view_view_model.g.dart';

@riverpod
class ToViewList extends _$ToViewList {
  @override
  Future<List<ToViewModel>> build() async {
    final authState = ref.watch(authProvider);
    if (!authState.isLoggedIn || authState.user == null) {
      return [];
    }

    final result = await ref.read(toViewUseCasesProvider).getList();
    return result.when(
      success: (value) => value,
      failure: (error) => throw Exception(error.message),
    );
  }

  Future<void> add(int aid) async {
    final result = await ref.read(toViewUseCasesProvider).add(aid);
    if (result.isSuccess) {
      ref.invalidateSelf();
    }
  }

  Future<void> delete(int aid) async {
    final result = await ref.read(toViewUseCasesProvider).delete(aid);
    if (result.isSuccess) {
      final currentList = state.asData?.value ?? [];
      state = AsyncValue.data(currentList.where((item) => item.aid != aid).toList());
    }
  }

  Future<void> clear() async {
    final result = await ref.read(toViewUseCasesProvider).clear();
    if (result.isSuccess) {
      state = const AsyncValue.data([]);
    }
  }
}
