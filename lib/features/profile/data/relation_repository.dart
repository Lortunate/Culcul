import 'package:culcul/core/base_repository.dart';
import 'package:culcul/core/providers/api_provider.dart';
import 'package:culcul/data/api/relation_api.dart';
import 'package:culcul/data/models/relation/relation_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'relation_repository.g.dart';

@riverpod
RelationRepository relationRepository(Ref ref) {
  return RelationRepository(ref.watch(relationApiProvider));
}

class RelationRepository extends BaseRepository {
  final RelationApi _api;

  RelationRepository(this._api);

  Future<RelationResponseData> getFollowings(
    int vmid, {
    int pn = 1,
    int ps = 50,
    String? orderType,
  }) {
    return requestApi(
      () => _api.getFollowings(vmid, pn: pn, ps: ps, orderType: orderType),
    );
  }

  Future<RelationResponseData> getFollowers(int vmid, {int pn = 1, int ps = 50}) {
    return requestApi(() => _api.getFollowers(vmid, pn: pn, ps: ps));
  }

  Future<void> modifyRelation({required int fid, required int act}) {
    return requestVoid(() => _api.modifyRelation(fid, act));
  }
}
