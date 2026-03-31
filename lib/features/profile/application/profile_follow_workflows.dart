import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/core/result/run_result.dart';
import 'package:culcul/features/profile/profile_providers.dart';
import 'package:culcul/features/profile/domain/repositories/profile_repository.dart'
    as domain;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'profile_follow_workflows.g.dart';

class ToggleProfileFollowCommand {
  final int mid;
  final bool isFollow;

  const ToggleProfileFollowCommand({required this.mid, required this.isFollow});
}

@riverpod
ProfileFollowWorkflows profileFollowWorkflows(Ref ref) {
  return ProfileFollowWorkflows(ref.read(profileRepositoryProvider));
}

class ProfileFollowWorkflows {
  final domain.ProfileRepository _repository;

  const ProfileFollowWorkflows(this._repository);

  Future<Result<void, AppError>> call(ToggleProfileFollowCommand command) async {
    return runVoidResult(
      () => _repository.modifyRelation(mid: command.mid, isFollow: command.isFollow),
    );
  }
}
