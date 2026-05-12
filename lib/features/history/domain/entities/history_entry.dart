import 'package:freezed_annotation/freezed_annotation.dart';

part 'history_entry.freezed.dart';

@freezed
sealed class HistoryEntry with _$HistoryEntry {
  const factory HistoryEntry({
    required String title,
    required String coverUrl,
    required String bvid,
    required String business,
    required String authorName,
    required int viewedAt,
    required int progress,
    required int duration,
    required String badge,
  }) = _HistoryEntry;
}
