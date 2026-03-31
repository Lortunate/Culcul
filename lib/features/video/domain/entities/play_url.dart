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
    @JsonKey(name: 'support_formats') @Default([]) List<SupportFormat> supportFormats,
  }) = _PlayUrl;

  factory PlayUrl.fromJson(Map<String, dynamic> json) => _$PlayUrlFromJson(json);
}

@freezed
sealed class Durl with _$Durl {
  const factory Durl({
    required int order,
    required int length,
    required int size,
    required String url,
    @Default([]) List<String> backupUrl,
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
