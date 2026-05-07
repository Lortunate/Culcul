import 'package:culcul/core/contracts/relation_user_contract.dart';
import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/result/result.dart';

/// Cross-feature contract for fetching follow lists.
/// Used by dynamic feature to show recently followed users.
abstract interface class FollowListService {
  Future<Result<List<ProfileRelationUser>, AppError>> getFollowings(
    int vmid, {
    int page = 1,
  });
}
