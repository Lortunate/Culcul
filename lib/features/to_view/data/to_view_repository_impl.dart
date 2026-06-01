import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/data/network/dio_client.dart';
import 'package:culcul/core/data/network/request_executor.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/core/utils/json_utils.dart';
import 'package:culcul/features/to_view/data/to_view_api.dart';
import 'package:culcul/features/to_view/domain/entities/to_view_entry.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'to_view_repository_impl.g.dart';

@riverpod
ToViewRepositoryImpl toViewRepository(Ref ref) {
  return ToViewRepositoryImpl(ToViewApi(ref.watch(dioClientProvider)));
}

class ToViewRepositoryImpl {
  final ToViewApi _api;
  final RequestExecutor _requestExecutor;

  ToViewRepositoryImpl(ToViewApi api, {RequestExecutor? requestExecutor})
    : _api = api,
      _requestExecutor = requestExecutor ?? const RequestExecutor();

  Future<Result<List<ToViewEntry>, AppError>> getList() async {
    final result = await _requestExecutor.runApi<List<ToViewEntry>, Object>(
      _api.getToViewList,
      transform: (data) {
        final map = JsonUtils.asStringKeyedMap(data);
        final list = map?['list'];
        if (list is! List) {
          return const <ToViewEntry>[];
        }
        return [
          for (final item in list)
            if (item is Map<String, dynamic>)
              ToViewEntry.fromJson(item)
            else if (item is Map)
              ToViewEntry.fromJson(Map<String, dynamic>.from(item)),
        ];
      },
    );
    return result.when(
      success: Success.new,
      failure: (error) {
        if (error is ServerAppError && error.code == 0 && error.message == 'No Data') {
          return const Success(<ToViewEntry>[]);
        }
        return Failure(error);
      },
    );
  }

  Future<Result<void, AppError>> add({required int aid}) {
    return _requestExecutor.run(() => _api.addToView(aid));
  }

  Future<Result<void, AppError>> delete({required int aid}) {
    return _requestExecutor.run(() => _api.deleteToView(aid));
  }

  Future<Result<void, AppError>> clear() {
    return _requestExecutor.run(_api.clearToView);
  }
}
