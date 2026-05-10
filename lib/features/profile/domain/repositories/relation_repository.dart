import 'package:culcul/core/contracts/relation_port.dart';
import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/core/contracts/relation_user_contract.dart';

abstract class RelationRepository implements RelationPort {
  @override
  Future<Result<List<ProfileRelationUser>, AppError>> getFollowings(
    int vmid, {
    int page = 1,
    String? orderType,
  });

  Future<Result<List<ProfileRelationUser>, AppError>> getFollowers(
    int vmid, {
    int page = 1,
  });

  Future<Result<void, AppError>> modifyRelation({required int fid, required int act});
}
