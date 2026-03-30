import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/features/profile/data/profile_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'profile_follow_use_case.g.dart';

class ToggleProfileFollowCommand {
  final int mid;
  final bool isFollow;

  const ToggleProfileFollowCommand({required this.mid, required this.isFollow});
}

@riverpod
ProfileFollowUseCase profileFollowUseCase(Ref ref) {
  return ProfileFollowUseCase(ref.read(profileRepositoryProvider));
}

class ProfileFollowUseCase {
  final ProfileRepository _repository;

  const ProfileFollowUseCase(this._repository);

  Future<Result<void, AppError>> call(ToggleProfileFollowCommand command) async {
    try {
      await _repository.modifyRelation(mid: command.mid, isFollow: command.isFollow);
      return const Success(null);
    } catch (error) {
      return Failure(AppError.fromObject(error));
    }
  }
}
