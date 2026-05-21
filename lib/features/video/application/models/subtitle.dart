import 'package:freezed_annotation/freezed_annotation.dart';

part 'subtitle.freezed.dart';
part 'subtitle.g.dart';

@freezed
sealed class VideoSubtitleDto with _$VideoSubtitleDto {
  const factory VideoSubtitleDto({@Default([]) List<SubtitleInfo> list}) =
      _VideoSubtitleDto;

  factory VideoSubtitleDto.fromJson(Map<String, dynamic> json) =>
      _$VideoSubtitleDtoFromJson(json);
}

@freezed
sealed class SubtitleInfo with _$SubtitleInfo {
  const factory SubtitleInfo({
    required int id,
    required String lan,
    @JsonKey(name: 'lan_doc') required String lanDoc,
    @JsonKey(name: 'subtitle_url') required String subtitleUrl,
    @JsonKey(name: 'is_lock') @Default(false) bool isLock,
    @JsonKey(name: 'id_str') String? idStr,
    @Default(0) int type,
  }) = _SubtitleInfo;

  factory SubtitleInfo.fromJson(Map<String, dynamic> json) =>
      _$SubtitleInfoFromJson(json);
}

@freezed
sealed class SubtitleContent with _$SubtitleContent {
  const factory SubtitleContent({
    @JsonKey(name: 'font_size') double? fontSize,
    @JsonKey(name: 'font_color') String? fontColor,
    @JsonKey(name: 'background_alpha') double? backgroundAlpha,
    @JsonKey(name: 'background_color') String? backgroundColor,
    @Default([]) List<SubtitleItem> body,
  }) = _SubtitleContent;

  factory SubtitleContent.fromJson(Map<String, dynamic> json) =>
      _$SubtitleContentFromJson(json);
}

@freezed
sealed class SubtitleItem with _$SubtitleItem {
  const factory SubtitleItem({
    required double from,
    required double to,
    required int location,
    required String content,
  }) = _SubtitleItem;

  factory SubtitleItem.fromJson(Map<String, dynamic> json) =>
      _$SubtitleItemFromJson(json);
}
