import 'package:culcul/shared/network/dio_client.dart';
import 'package:culcul/shared/network/request_executor.dart';
import 'package:culcul/shared/network/request_executor_binding.dart';
import 'package:culcul/shared/network/resource_api.dart';
import 'package:culcul/shared/errors/app_error.dart';
import 'package:culcul/shared/result/result.dart';
import 'package:culcul/features/video/domain/repositories/danmaku_repository.dart'
    as domain;
import 'package:culcul/features/video/data/danmaku_api.dart';
import 'package:culcul/protos/dm.pb.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'danmaku_repository_impl.g.dart';

@riverpod
domain.DanmakuRepository danmakuRepository(Ref ref) {
  return DanmakuRepositoryImpl(
    DanmakuApi(ref.watch(basicDioProvider)),
    ResourceApi(ref.watch(basicDioProvider)),
  );
}

class DanmakuRepositoryImpl
    with RequestExecutorBinding
    implements domain.DanmakuRepository {
  final DanmakuApi _api;
  final ResourceApi _resourceApi;
  final RequestExecutor _requestExecutor;

  DanmakuRepositoryImpl(this._api, this._resourceApi, {RequestExecutor? requestExecutor})
    : _requestExecutor = requestExecutor ?? const RequestExecutor();

  @override
  RequestExecutor get requestExecutor => _requestExecutor;

  @override
  Future<Result<DmSegMobileReply, AppError>> fetchDanmakuSegment({
    required int oid,
    required int pid,
    required int segmentIndex,
  }) {
    return requestResult(() async {
      final response = await _api.fetchDanmakuSegment(
        oid: oid,
        pid: pid,
        segmentIndex: segmentIndex,
      );
      return DmSegMobileReply.fromBuffer(response);
    });
  }

  @override
  Future<Result<DmViewReply, AppError>> fetchDanmakuView({
    required int oid,
    required int pid,
  }) {
    return requestResult(() async {
      final response = await _api.fetchDanmakuView(oid: oid, pid: pid);
      return DmViewReply.fromBuffer(response);
    });
  }

  @override
  Future<Result<List<int>, AppError>> fetchMaskData(String url) async {
    return requestResult(() async {
      return _resourceApi.fetchBytes(url);
    });
  }
}
