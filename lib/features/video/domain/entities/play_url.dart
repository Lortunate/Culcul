import 'package:freezed_annotation/freezed_annotation.dart';

part 'play_url.freezed.dart';

@freezed
sealed class PlayUrl with _$PlayUrl {
  const factory PlayUrl({
    required String format,
    required int quality,
    required int timeLength,
    required String acceptFormat,
    required List<String> acceptDescription,
    required List<int> acceptQuality,
    required int videoCodecId,
    required List<Durl> durl,
    @Default([]) List<SupportFormat> supportFormats,
  }) = _PlayUrl;
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
}

@freezed
sealed class SupportFormat with _$SupportFormat {
  const factory SupportFormat({
    required int quality,
    required String format,
    required String newDescription,
    required String displayDesc,
    required String superscript,
    @Default([]) List<String> codecs,
  }) = _SupportFormat;
}
