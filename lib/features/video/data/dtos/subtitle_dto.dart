import 'package:freezed_annotation/freezed_annotation.dart';

part 'subtitle_dto.freezed.dart';
part 'subtitle_dto.g.dart';

@freezed
sealed class VideoSubtitlesDto with _$VideoSubtitlesDto {
  const factory VideoSubtitlesDto({@Default([]) List<SubtitleInfoDto> list}) =
      _VideoSubtitlesDto;

  factory VideoSubtitlesDto.fromJson(Map<String, dynamic> json) =>
      _$VideoSubtitlesDtoFromJson(json);
}

@freezed
sealed class SubtitleInfoDto with _$SubtitleInfoDto {
  const factory SubtitleInfoDto({
    required int id,
    required String lan,
    @JsonKey(name: 'lan_doc') required String lanDoc,
    @JsonKey(name: 'subtitle_url') required String subtitleUrl,
    @JsonKey(name: 'is_lock') @Default(false) bool isLock,
    @JsonKey(name: 'id_str') String? idStr,
    @Default(0) int type,
  }) = _SubtitleInfoDto;

  factory SubtitleInfoDto.fromJson(Map<String, dynamic> json) =>
      _$SubtitleInfoDtoFromJson(json);
}

@freezed
sealed class SubtitleContentDto with _$SubtitleContentDto {
  const factory SubtitleContentDto({
    @JsonKey(name: 'font_size') double? fontSize,
    @JsonKey(name: 'font_color') String? fontColor,
    @JsonKey(name: 'background_alpha') double? backgroundAlpha,
    @JsonKey(name: 'background_color') String? backgroundColor,
    @Default([]) List<SubtitleItemDto> body,
  }) = _SubtitleContentDto;

  factory SubtitleContentDto.fromJson(Map<String, dynamic> json) =>
      _$SubtitleContentDtoFromJson(json);
}

@freezed
sealed class SubtitleItemDto with _$SubtitleItemDto {
  const factory SubtitleItemDto({
    required double from,
    required double to,
    required int location,
    required String content,
  }) = _SubtitleItemDto;

  factory SubtitleItemDto.fromJson(Map<String, dynamic> json) =>
      _$SubtitleItemDtoFromJson(json);
}
