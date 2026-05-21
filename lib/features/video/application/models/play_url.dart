import 'package:freezed_annotation/freezed_annotation.dart';

part 'play_url.freezed.dart';
part 'play_url.g.dart';

@freezed
sealed class PlayUrl with _$PlayUrl {
  const factory PlayUrl({
    required String format,
    required int quality,
    @JsonKey(name: 'timelength') required int timeLength,
    @JsonKey(name: 'accept_format') required String acceptFormat,
    @JsonKey(name: 'accept_description') required List<String> acceptDescription,
    @JsonKey(name: 'accept_quality') required List<int> acceptQuality,
    @JsonKey(name: 'video_codecid') required int videoCodecId,
    required List<Durl> durl,
    DashInfo? dash,
    @JsonKey(name: 'support_formats') @Default([]) List<SupportFormat> supportFormats,
  }) = _PlayUrl;

  factory PlayUrl.fromJson(Map<String, dynamic> json) => _$PlayUrlFromJson(json);
}

@freezed
sealed class DashInfo with _$DashInfo {
  const factory DashInfo({@Default([]) List<DashStream> audio}) = _DashInfo;

  factory DashInfo.fromJson(Map<String, dynamic> json) => _$DashInfoFromJson(json);
}

@freezed
sealed class DashStream with _$DashStream {
  const factory DashStream({
    required int id,
    @JsonKey(readValue: _readBaseUrl) required String baseUrl,
    @JsonKey(readValue: _readBackupUrls) @Default([]) List<String> backupUrl,
    @Default(0) int bandwidth,
  }) = _DashStream;

  factory DashStream.fromJson(Map<String, dynamic> json) => _$DashStreamFromJson(json);
}

@freezed
sealed class Durl with _$Durl {
  const factory Durl({
    required int order,
    required int length,
    required int size,
    required String url,
    @JsonKey(name: 'backup_url') @Default([]) List<String> backupUrl,
  }) = _Durl;

  factory Durl.fromJson(Map<String, dynamic> json) => _$DurlFromJson(json);
}

@freezed
sealed class SupportFormat with _$SupportFormat {
  const factory SupportFormat({
    required int quality,
    required String format,
    @JsonKey(name: 'new_description') required String newDescription,
    @JsonKey(name: 'display_desc') required String displayDesc,
    required String superscript,
    @Default([]) List<String> codecs,
  }) = _SupportFormat;

  factory SupportFormat.fromJson(Map<String, dynamic> json) =>
      _$SupportFormatFromJson(json);
}

Object? _readBaseUrl(Map<dynamic, dynamic> json, String _) =>
    json['baseUrl'] ?? json['base_url'];

Object? _readBackupUrls(Map<dynamic, dynamic> json, String _) =>
    json['backupUrl'] ?? json['backup_url'];
