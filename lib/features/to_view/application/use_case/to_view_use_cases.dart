import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/features/to_view/data/mappers/to_view_mapper.dart';
import 'package:culcul/features/to_view/data/toview_repository.dart';
import 'package:culcul/features/to_view/domain/entities/to_view_entry.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'to_view_use_cases.g.dart';

@riverpod
ToViewUseCases toViewUseCases(Ref ref) {
  return ToViewUseCases(ref.read(toViewRepositoryProvider));
}

class ToViewUseCases {
  final ToViewRepository _repository;

  const ToViewUseCases(this._repository);

  Future<Result<List<ToViewEntry>, AppError>> getList() async {
    try {
      final data = await _repository.getToViewList();
      return Success(data.list.map((item) => item.toDomain()).toList());
    } catch (error) {
      return Failure(AppError.fromObject(error));
    }
  }

  Future<Result<void, AppError>> add(int aid) async {
    try {
      await _repository.addToView(aid: aid);
      return const Success(null);
    } catch (error) {
      return Failure(AppError.fromObject(error));
    }
  }

  Future<Result<void, AppError>> delete(int aid) async {
    try {
      await _repository.deleteToView(aid: aid);
      return const Success(null);
    } catch (error) {
      return Failure(AppError.fromObject(error));
    }
  }

  Future<Result<void, AppError>> clear() async {
    try {
      await _repository.clearToView();
      return const Success(null);
    } catch (error) {
      return Failure(AppError.fromObject(error));
    }
  }
}
