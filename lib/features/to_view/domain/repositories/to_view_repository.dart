import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/features/to_view/domain/entities/to_view_entry.dart';

abstract class ToViewRepository {
  Future<List<ToViewEntry>> getList();

  Future<Result<void, AppError>> add({required int aid});

  Future<Result<void, AppError>> delete({required int aid});

  Future<Result<void, AppError>> clear();
}
