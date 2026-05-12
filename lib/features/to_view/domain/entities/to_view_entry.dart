import 'package:freezed_annotation/freezed_annotation.dart';

part 'to_view_entry.freezed.dart';

@freezed
sealed class ToViewEntry with _$ToViewEntry {
  const ToViewEntry._();

  const factory ToViewEntry({
    required int aid,
    required String bvid,
    required String title,
    required String coverUrl,
    required int duration,
    required int progress,
    required String ownerName,
    required int viewCount,
    required int danmakuCount,
  }) = _ToViewEntry;

  bool get hasProgress => progress > 0;

  double get progressRatio {
    final normalizedDuration = duration == 0 ? 1 : duration;
    return progress / normalizedDuration;
  }
}
