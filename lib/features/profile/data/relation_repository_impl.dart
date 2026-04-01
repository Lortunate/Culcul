import 'package:culcul/core/base_repository.dart';
import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/network/dio_client.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/core/result/run_result.dart';
import 'package:culcul/features/profile/data/dtos/profile_dtos.dart';
import 'package:culcul/features/profile/data/profile_mapper.dart';
import 'package:culcul/features/profile/data/relation_api.dart';
import 'package:culcul/core/contracts/relation_user_contract.dart';
import 'package:culcul/features/profile/domain/repositories/relation_repository.dart'
    as domain;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'relation_repository_impl.g.dart';

@riverpod
domain.RelationRepository relationRepository(Ref ref) {
  return RelationRepositoryImpl(RelationApi(ref.watch(dioClientProvider)));
}

class RelationRepositoryImpl extends BaseRepository implements domain.RelationRepository {
  static const int _defaultPageSize = 50;
  final RelationApi _api;

  RelationRepositoryImpl(this._api);

  Future<RelationResponseData> getFollowingsModel(
    int vmid, {
    int pn = 1,
    int ps = _defaultPageSize,
    String? orderType,
  }) {
    return requestApi(
      () => _api.getFollowings(vmid, pn: pn, ps: ps, orderType: orderType),
    );
  }

  Future<RelationResponseData> getFollowersModel(
    int vmid, {
    int pn = 1,
    int ps = _defaultPageSize,
  }) {
    return requestApi(() => _api.getFollowers(vmid, pn: pn, ps: ps));
  }

  @override
  Future<Result<void, AppError>> modifyRelation({required int fid, required int act}) {
    return runVoidResult(() => requestVoid(() => _api.modifyRelation(fid, act)));
  }

  @override
  Future<List<ProfileRelationUser>> getFollowings(
    int vmid, {
    int page = 1,
    String? orderType,
  }) async {
    final data = await getFollowingsModel(vmid, pn: page, orderType: orderType);
    return data.list.map((item) => item.toDomain()).toList();
  }

  @override
  Future<List<ProfileRelationUser>> getFollowers(int vmid, {int page = 1}) async {
    final data = await getFollowersModel(vmid, pn: page);
    return data.list.map((item) => item.toDomain()).toList();
  }
}
