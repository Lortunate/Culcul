import 'package:freezed_annotation/freezed_annotation.dart';

part 'video_play_url_dto.freezed.dart';
part 'video_play_url_dto.g.dart';

@freezed
sealed class VideoPlayUrlDto with _$VideoPlayUrlDto {
  const factory VideoPlayUrlDto({
    required String format,
    required int quality,
    @JsonKey(name: 'timelength') required int timeLength,
    @JsonKey(name: 'accept_format') required String acceptFormat,
    @JsonKey(name: 'accept_description') required List<String> acceptDescription,
    @JsonKey(name: 'accept_quality') required List<int> acceptQuality,
    @JsonKey(name: 'video_codecid') required int videoCodecId,
    required List<DurlDto> durl,
    DashInfoDto? dash,
    @JsonKey(name: 'support_formats') @Default([]) List<SupportFormatDto> supportFormats,
  }) = _VideoPlayUrlDto;

  factory VideoPlayUrlDto.fromJson(Map<String, dynamic> json) =>
      _$VideoPlayUrlDtoFromJson(json);
}

@freezed
sealed class DashInfoDto with _$DashInfoDto {
  const factory DashInfoDto({@Default([]) List<DashStreamDto> audio}) = _DashInfoDto;

  factory DashInfoDto.fromJson(Map<String, dynamic> json) => _$DashInfoDtoFromJson(json);
}

@freezed
sealed class DashStreamDto with _$DashStreamDto {
  const factory DashStreamDto({
    required int id,
    @JsonKey(readValue: _readBaseUrl) required String baseUrl,
    @JsonKey(readValue: _readBackupUrls) @Default([]) List<String> backupUrl,
    @Default(0) int bandwidth,
  }) = _DashStreamDto;

  factory DashStreamDto.fromJson(Map<String, dynamic> json) =>
      _$DashStreamDtoFromJson(json);
}

@freezed
sealed class DurlDto with _$DurlDto {
  const factory DurlDto({
    required int order,
    required int length,
    required int size,
    required String url,
    @JsonKey(name: 'backup_url') @Default([]) List<String> backupUrl,
  }) = _DurlDto;

  factory DurlDto.fromJson(Map<String, dynamic> json) => _$DurlDtoFromJson(json);
}

@freezed
sealed class SupportFormatDto with _$SupportFormatDto {
  const factory SupportFormatDto({
    required int quality,
    required String format,
    @JsonKey(name: 'new_description') required String newDescription,
    @JsonKey(name: 'display_desc') required String displayDesc,
    required String superscript,
    @Default([]) List<String> codecs,
  }) = _SupportFormatDto;

  factory SupportFormatDto.fromJson(Map<String, dynamic> json) =>
      _$SupportFormatDtoFromJson(json);
}

Object? _readBaseUrl(Map<dynamic, dynamic> json, String _) =>
    json['baseUrl'] ?? json['base_url'];

Object? _readBackupUrls(Map<dynamic, dynamic> json, String _) =>
    json['backupUrl'] ?? json['backup_url'];
