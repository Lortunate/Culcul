import 'package:culcul/data/api/relation_api.dart';
import 'package:culcul/data/models/relation/relation_model.dart';

class RelationRepository {
  final RelationApi _api;

  RelationRepository(this._api);

  Future<RelationResponseData> getFollowings(
    int vmid, {
    int pn = 1,
    int ps = 50,
    String? orderType,
  }) async {
    final response = await _api.getFollowings(
      vmid,
      pn: pn,
      ps: ps,
      orderType: orderType,
    );
    if (response.code != 0) {
      throw Exception(response.message);
    }
    return response.data ?? const RelationResponseData();
  }

  Future<RelationResponseData> getFollowers(
    int vmid, {
    int pn = 1,
    int ps = 50,
  }) async {
    final response = await _api.getFollowers(vmid, pn: pn, ps: ps);
    if (response.code != 0) {
      throw Exception(response.message);
    }
    return response.data ?? const RelationResponseData();
  }

  Future<void> modifyRelation({
    required int fid,
    required int act,
  }) async {
    final response = await _api.modifyRelation(fid, act);
    if (response.code != 0) {
      throw Exception(response.message);
    }
  }
}
