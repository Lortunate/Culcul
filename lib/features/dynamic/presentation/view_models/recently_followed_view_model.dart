import 'package:culcul/features/dynamic/domain/entities/dynamic_models.dart';
import 'package:culcul/features/dynamic/application/use_case/dynamic_use_cases.dart';
import 'package:culcul/features/auth/presentation/view_models/auth_view_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'recently_followed_view_model.g.dart';

@riverpod
class RecentlyFollowed extends _$RecentlyFollowed {
  @override
  FutureOr<List<RelationUser>> build() async {
    final authState = ref.watch(authProvider);
    if (!authState.isLoggedIn || authState.user == null) {
      return [];
    }

    final result = await ref
        .read(recentlyFollowedUseCaseProvider)
        .call(int.parse(authState.user!.id));
    return result.when(success: (value) => value, failure: (_) => []);
  }
}
