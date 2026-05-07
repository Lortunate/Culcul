import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/features/history/domain/entities/history_entry.dart';

abstract class HistoryRepository {
  Future<Result<List<HistoryEntry>, AppError>> getHistory({int max = 0, int viewAt = 0});
}
