import 'package:culcul/features/history/models/history_models.dart';
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
