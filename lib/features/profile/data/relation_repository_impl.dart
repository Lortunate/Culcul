import 'package:culcul/shared/errors/app_error.dart';
import 'package:culcul/shared/network/dio_client.dart';
import 'package:culcul/shared/network/request_executor.dart';
import 'package:culcul/shared/network/request_executor_binding.dart';
import 'package:culcul/shared/result/result.dart';
import 'package:culcul/features/profile/data/dtos/profile_dtos.dart';
import 'package:culcul/features/profile/data/profile_mapper.dart';
import 'package:culcul/features/profile/data/relation_api.dart';
import 'package:culcul/shared/contracts/relation_user_contract.dart';
import 'package:culcul/features/profile/domain/repositories/relation_repository.dart'
    as domain;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'relation_repository_impl.g.dart';

@riverpod
domain.RelationRepository relationRepository(Ref ref) {
  return RelationRepositoryImpl(RelationApi(ref.watch(dioClientProvider)));
}

class RelationRepositoryImpl with RequestExecutorBinding implements domain.RelationRepository {
  static const int _defaultPageSize = 50;
  final RelationApi _api;
  final RequestExecutor _requestExecutor;

  RelationRepositoryImpl(this._api, {RequestExecutor? requestExecutor})
    : _requestExecutor = requestExecutor ?? const RequestExecutor();

  @override
  RequestExecutor get requestExecutor => _requestExecutor;

  Future<Result<RelationResponseData, AppError>> getFollowingsModel(
    int vmid, {
    int pn = 1,
    int ps = _defaultPageSize,
    String? orderType,
  }) {
    return requestApiResult(
      () => _api.getFollowings(vmid, pn: pn, ps: ps, orderType: orderType),
    );
  }

  Future<Result<RelationResponseData, AppError>> getFollowersModel(
    int vmid, {
    int pn = 1,
    int ps = _defaultPageSize,
  }) {
    return requestApiResult(() => _api.getFollowers(vmid, pn: pn, ps: ps));
  }

  @override
  Future<Result<void, AppError>> modifyRelation({required int fid, required int act}) {
    return requestVoidResult(() => _api.modifyRelation(fid, act));
  }

  @override
  Future<Result<List<ProfileRelationUser>, AppError>> getFollowings(
    int vmid, {
    int page = 1,
    String? orderType,
  }) async {
    final result = await getFollowingsModel(vmid, pn: page, orderType: orderType);
    return result.map((data) => data.list.map((item) => item.toDomain()).toList());
  }

  @override
  Future<Result<List<ProfileRelationUser>, AppError>> getFollowers(
    int vmid, {
    int page = 1,
  }) async {
    final result = await getFollowersModel(vmid, pn: page);
    return result.map((data) => data.list.map((item) => item.toDomain()).toList());
  }
}
