import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/core/contracts/relation_user_contract.dart';

abstract class RelationRepository {
  Future<List<ProfileRelationUser>> getFollowings(
    int vmid, {
    int page = 1,
    String? orderType,
  });

  Future<List<ProfileRelationUser>> getFollowers(int vmid, {int page = 1});

  Future<Result<void, AppError>> modifyRelation({required int fid, required int act});
}
