import 'package:culcul/core/base_repository.dart';
import 'package:culcul/core/providers/api_provider.dart';
import 'package:culcul/features/profile/data/mappers/profile_mapper.dart';
import 'package:culcul/features/profile/data/relation_api.dart';
import 'package:culcul/features/profile/domain/entities/relation_user.dart';
import 'package:culcul/features/profile/domain/repositories/relation_repository.dart'
    as domain;
import 'package:culcul/features/profile/models/profile_models.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'relation_repository.g.dart';

@riverpod
domain.RelationRepository relationRepository(Ref ref) {
  return RelationRepositoryImpl(ref.watch(relationApiProvider));
}

class RelationRepositoryImpl extends BaseRepository implements domain.RelationRepository {
  final RelationApi _api;

  RelationRepositoryImpl(this._api);

  Future<RelationResponseData> getFollowingsModel(
    int vmid, {
    int pn = 1,
    int ps = 50,
    String? orderType,
  }) {
    return requestApi(
      () => _api.getFollowings(vmid, pn: pn, ps: ps, orderType: orderType),
    );
  }

  Future<RelationResponseData> getFollowersModel(int vmid, {int pn = 1, int ps = 50}) {
    return requestApi(() => _api.getFollowers(vmid, pn: pn, ps: ps));
  }

  @override
  Future<void> modifyRelation({required int fid, required int act}) {
    return requestVoid(() => _api.modifyRelation(fid, act));
  }

  @override
  Future<List<ProfileRelationUser>> getFollowings(
    int vmid, {
    int page = 1,
    int pageSize = 50,
    String? orderType,
  }) async {
    final data = await getFollowingsModel(
      vmid,
      pn: page,
      ps: pageSize,
      orderType: orderType,
    );
    return data.list.map((item) => item.toDomain()).toList();
  }

  @override
  Future<List<ProfileRelationUser>> getFollowers(
    int vmid, {
    int page = 1,
    int pageSize = 50,
  }) async {
    final data = await getFollowersModel(vmid, pn: page, ps: pageSize);
    return data.list.map((item) => item.toDomain()).toList();
  }
}
