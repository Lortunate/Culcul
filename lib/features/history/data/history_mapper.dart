import 'package:culcul/features/history/data/dtos/history_model_dto.dart';
import 'package:culcul/features/history/data/dtos/history_entry.dart';

extension HistoryItemMapper on HistoryItemDto {
  HistoryEntry toDomain() {
    return HistoryEntry(
      title: title,
      coverUrl: cover,
      bvid: history.bvid,
      business: history.business,
      authorName: authorName,
      viewedAt: viewAt,
      progress: progress,
      duration: duration,
      badge: badge,
    );
  }
}
