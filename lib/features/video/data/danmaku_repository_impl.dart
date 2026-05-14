import 'package:culcul/core/data/network/dio_client.dart';
import 'package:culcul/core/data/network/request_executor.dart';
import 'package:culcul/core/data/network/resource_api.dart';
import 'package:culcul/core/data/network/resource_api_provider.dart';
import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/features/video/data/dtos/danmaku_model.dart';
import 'package:culcul/features/video/data/danmaku_api.dart';
import 'package:culcul/protos/dm.pb.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'danmaku_repository_impl.g.dart';

@riverpod
DanmakuRepositoryImpl danmakuRepository(Ref ref) {
  return DanmakuRepositoryImpl(
    DanmakuApi(ref.watch(basicDioProvider)),
    ref.watch(basicResourceApiProvider),
  );
}

class DanmakuRepositoryImpl {
  final DanmakuApi _api;
  final ResourceApi _resourceApi;
  final RequestExecutor _requestExecutor;

  DanmakuRepositoryImpl(this._api, this._resourceApi, {RequestExecutor? requestExecutor})
    : _requestExecutor = requestExecutor ?? const RequestExecutor();

  Future<Result<DanmakuSegment, AppError>> fetchDanmakuSegment({
    required int oid,
    required int pid,
    required int segmentIndex,
  }) {
    return _requestExecutor.run(() async {
      final response = await _api.fetchDanmakuSegment(
        oid: oid,
        pid: pid,
        segmentIndex: segmentIndex,
      );
      final payload = DmSegMobileReply.fromBuffer(response);
      return DanmakuSegment(
        entries: payload.elems
            .map(
              (item) => DanmakuEntry(
                content: item.content,
                progress: item.progress,
                color: item.color,
                mode: item.mode,
              ),
            )
            .toList(growable: false),
        state: payload.state,
      );
    });
  }

  Future<Result<DanmakuViewConfig, AppError>> fetchDanmakuView({
    required int oid,
    required int pid,
  }) {
    return _requestExecutor.run(() async {
      final response = DmViewReply.fromBuffer(
        await _api.fetchDanmakuView(oid: oid, pid: pid),
      );
      return DanmakuViewConfig(
        closed: response.closed,
        allow: response.allow,
        sendBoxStyle: response.sendBoxStyle,
        textPlaceholder: response.textPlaceholder,
        inputPlaceholder: response.inputPlaceholder,
      );
    });
  }

  Future<Result<List<int>, AppError>> fetchMaskData(String url) {
    return _requestExecutor.run(() => _resourceApi.fetchBytes(url));
  }
}
