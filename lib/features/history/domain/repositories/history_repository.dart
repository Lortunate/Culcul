import 'package:culcul/features/history/domain/entities/history_entry.dart';

abstract class HistoryRepository {
  Future<List<HistoryEntry>> getHistory({int max = 0, int viewAt = 0});
}
