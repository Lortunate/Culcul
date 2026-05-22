import 'package:freezed_annotation/freezed_annotation.dart';

part 'subtitle.freezed.dart';

@freezed
sealed class VideoSubtitles with _$VideoSubtitles {
  const factory VideoSubtitles({@Default([]) List<SubtitleInfo> list}) = _VideoSubtitles;
}

@freezed
sealed class SubtitleInfo with _$SubtitleInfo {
  const factory SubtitleInfo({
    required int id,
    required String lan,
    required String lanDoc,
    required String subtitleUrl,
    @Default(false) bool isLock,
    String? idStr,
    @Default(0) int type,
  }) = _SubtitleInfo;
}

@freezed
sealed class SubtitleContent with _$SubtitleContent {
  const factory SubtitleContent({
    double? fontSize,
    String? fontColor,
    double? backgroundAlpha,
    String? backgroundColor,
    @Default([]) List<SubtitleItem> body,
  }) = _SubtitleContent;
}

@freezed
sealed class SubtitleItem with _$SubtitleItem {
  const factory SubtitleItem({
    required double from,
    required double to,
    required int location,
    required String content,
  }) = _SubtitleItem;
}
