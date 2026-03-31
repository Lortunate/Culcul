import 'package:culcul/core/contracts/relation_user_contract.dart';

abstract class RelationRepository {
  Future<List<ProfileRelationUser>> getFollowings(
    int vmid, {
    int page = 1,
    int pageSize = 50,
    String? orderType,
  });

  Future<List<ProfileRelationUser>> getFollowers(
    int vmid, {
    int page = 1,
    int pageSize = 50,
  });

  Future<void> modifyRelation({required int fid, required int act});
}
