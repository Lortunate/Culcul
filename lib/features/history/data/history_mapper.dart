import 'package:culcul/features/history/data/dtos/history_dtos.dart';
import 'package:culcul/features/history/domain/entities/history_entry.dart';

extension HistoryItemMapper on HistoryItem {
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
