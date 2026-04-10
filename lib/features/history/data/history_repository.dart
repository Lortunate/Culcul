import 'package:culcul/shared/errors/app_error.dart';
import 'package:culcul/shared/result/result.dart';
import 'package:culcul/features/history/data/models/history_entry.dart';

abstract class HistoryRepository {
  Future<Result<List<HistoryEntry>, AppError>> getHistory({int max = 0, int viewAt = 0});
}
