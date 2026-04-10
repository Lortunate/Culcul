import 'package:culcul/shared/errors/app_error.dart';
import 'package:culcul/shared/result/result.dart';
import 'package:culcul/features/to_view/data/models/to_view_entry.dart';

abstract class ToViewRepository {
  Future<Result<List<ToViewEntry>, AppError>> getList();

  Future<Result<void, AppError>> add({required int aid});

  Future<Result<void, AppError>> delete({required int aid});

  Future<Result<void, AppError>> clear();
}
