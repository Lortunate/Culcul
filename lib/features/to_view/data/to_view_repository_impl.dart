import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/data/network/dio_client.dart';
import 'package:culcul/core/data/network/request_executor.dart';
import 'package:culcul/core/data/network/request_executor_binding.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/features/to_view/data/dtos/to_view_model_dto.dart';
import 'package:culcul/features/to_view/data/to_view_mapper.dart';
import 'package:culcul/features/to_view/data/to_view_api.dart';
import 'package:culcul/features/to_view/domain/entities/to_view_entry.dart';
import 'package:culcul/features/to_view/domain/repositories/to_view_repository.dart' as domain;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'to_view_repository_impl.g.dart';

@riverpod
domain.ToViewRepository toViewRepository(Ref ref) {
  return ToViewRepositoryImpl(ToViewApi(ref.watch(dioClientProvider)));
}

class ToViewRepositoryImpl
    with RequestExecutorBinding
    implements domain.ToViewRepository {
  final ToViewApi _api;
  final RequestExecutor _requestExecutor;

  ToViewRepositoryImpl(this._api, {RequestExecutor? requestExecutor})
    : _requestExecutor = requestExecutor ?? const RequestExecutor();

  @override
  RequestExecutor get requestExecutor => _requestExecutor;

  Future<Result<ToViewListResponseDto, AppError>> getToViewList() async {
    final result = await requestApiResult(() => _api.getToViewList());
    return result.when(
      success: Success.new,
      failure: (error) {
        if (error is ServerAppError && error.code == 0 && error.message == 'No Data') {
          return const Success(ToViewListResponseDto(count: 0, list: []));
        }
        return Failure(error);
      },
    );
  }

  Future<Result<void, AppError>> addToView({required int aid}) {
    return requestResult(() => _api.addToView(aid));
  }

  Future<Result<void, AppError>> deleteToView({required int aid}) {
    return requestResult(() => _api.deleteToView(aid));
  }

  Future<Result<void, AppError>> clearToView() {
    return requestResult(() => _api.clearToView());
  }

  @override
  Future<Result<List<ToViewEntry>, AppError>> getList() async {
    final result = await getToViewList();
    return result.map((data) => data.list.map((item) => item.toDomain()).toList());
  }

  @override
  Future<Result<void, AppError>> add({required int aid}) {
    return addToView(aid: aid);
  }

  @override
  Future<Result<void, AppError>> delete({required int aid}) {
    return deleteToView(aid: aid);
  }

  @override
  Future<Result<void, AppError>> clear() {
    return clearToView();
  }
}
