import 'package:culcul/core/errors/exceptions.dart';
import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/base_repository.dart';
import 'package:culcul/core/network/dio_client.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/core/result/run_result.dart';
import 'package:culcul/features/to_view/data/dtos/to_view_model_dto.dart';
import 'package:culcul/features/to_view/data/to_view_mapper.dart';
import 'package:culcul/features/to_view/data/toview_api.dart';
import 'package:culcul/features/to_view/domain/entities/to_view_entry.dart';
import 'package:culcul/features/to_view/domain/repositories/to_view_repository.dart'
    as domain;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'toview_repository_impl.g.dart';

@riverpod
domain.ToViewRepository toViewRepository(Ref ref) {
  return ToViewRepositoryImpl(ToViewApi(ref.watch(dioClientProvider)));
}

class ToViewRepositoryImpl extends BaseRepository implements domain.ToViewRepository {
  final ToViewApi _api;

  ToViewRepositoryImpl(this._api);

  Future<ToViewListResponseDto> getToViewList() async {
    try {
      return await requestApi(() => _api.getToViewList());
    } on ServerException catch (e) {
      if (e.code == 0 && e.message == 'No Data') {
        return const ToViewListResponseDto(count: 0, list: []);
      }
      rethrow;
    }
  }

  Future<void> addToView({required int aid}) {
    return request(() => _api.addToView(aid));
  }

  Future<void> deleteToView({required int aid}) {
    return request(() => _api.deleteToView(aid));
  }

  Future<void> clearToView() {
    return request(() => _api.clearToView());
  }

  @override
  Future<List<ToViewEntry>> getList() async {
    final data = await getToViewList();
    return data.list.map((item) => item.toDomain()).toList();
  }

  @override
  Future<Result<void, AppError>> add({required int aid}) {
    return runVoidResult(() => addToView(aid: aid));
  }

  @override
  Future<Result<void, AppError>> delete({required int aid}) {
    return runVoidResult(() => deleteToView(aid: aid));
  }

  @override
  Future<Result<void, AppError>> clear() {
    return runVoidResult(clearToView);
  }
}
