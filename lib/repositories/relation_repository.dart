import 'package:culcul/core/errors/exceptions.dart';
import 'package:culcul/core/repositories/base_repository.dart';
import 'package:culcul/core/types/result.dart';
import 'package:culcul/data/api/relation_api.dart';
import 'package:culcul/data/models/relation/relation_model.dart';

class RelationRepository extends BaseRepository {
  final RelationApi _api;

  RelationRepository(this._api);

  Future<Result<RelationResponseData, AppException>> getFollowings(
    int vmid, {
    int pn = 1,
    int ps = 50,
    String? orderType,
  }) {
    return safeApiCall(
      () => _api.getFollowings(vmid, pn: pn, ps: ps, orderType: orderType),
    );
  }

  Future<Result<RelationResponseData, AppException>> getFollowers(
    int vmid, {
    int pn = 1,
    int ps = 50,
  }) {
    return safeApiCall(() => _api.getFollowers(vmid, pn: pn, ps: ps));
  }

  Future<Result<void, AppException>> modifyRelation({
    required int fid,
    required int act,
  }) {
    return safeVoidApiCall(() => _api.modifyRelation(fid, act));
  }
}
