import 'package:culcul/core/contracts/follow_list_contract.dart';
import 'package:culcul/core/contracts/relation_user_contract.dart';
import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/core/session/relation_providers.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// Bridges core's FollowListService contract with profile's relation repository.
class FollowListAdapter implements FollowListService {
  final Ref _ref;
  FollowListAdapter(this._ref);

  @override
  Future<Result<List<ProfileRelationUser>, AppError>> getFollowings(
    int vmid, {
    int page = 1,
  }) {
    return _ref.read(relationPortProvider).getFollowings(vmid, page: page);
  }
}
