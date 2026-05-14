import 'package:culcul/core/contracts/relation_user_contract.dart';
import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/result/result.dart';

/// Feature-neutral runtime port for cross-feature relation access.
abstract interface class RelationPort {
  Future<Result<List<ProfileRelationUser>, AppError>> getFollowings(
    int vmid, {
    int page = 1,
  });

  Future<Result<List<ProfileRelationUser>, AppError>> getFollowers(
    int vmid, {
    int page = 1,
  });

  Future<Result<void, AppError>> modifyRelation({
    required int mid,
    required bool isFollow,
  });
}
