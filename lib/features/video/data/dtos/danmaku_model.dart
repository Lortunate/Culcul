import 'package:freezed_annotation/freezed_annotation.dart';

part 'danmaku_model.freezed.dart';

@freezed
sealed class DanmakuEntry with _$DanmakuEntry {
  const factory DanmakuEntry({
    required String content,
    required int progress,
    required int color,
    required int mode,
  }) = _DanmakuEntry;
}

@freezed
sealed class DanmakuSegment with _$DanmakuSegment {
  const factory DanmakuSegment({
    required List<DanmakuEntry> entries,
    required int state,
  }) = _DanmakuSegment;
}

@freezed
sealed class DanmakuViewConfig with _$DanmakuViewConfig {
  const factory DanmakuViewConfig({
    required bool closed,
    required bool allow,
    required int sendBoxStyle,
    required String textPlaceholder,
    required String inputPlaceholder,
  }) = _DanmakuViewConfig;
}
