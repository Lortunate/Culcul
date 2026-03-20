import 'package:freezed_annotation/freezed_annotation.dart';

part 'live_play_url_model.freezed.dart';
part 'live_play_url_model.g.dart';

@freezed
sealed class LivePlayUrlModel with _$LivePlayUrlModel {
  const factory LivePlayUrlModel({
    @JsonKey(name: 'current_quality') required int currentQuality,
    @JsonKey(name: 'accept_quality') required List<String> acceptQuality,
    @JsonKey(name: 'current_qn') required int currentQn,
    @JsonKey(name: 'quality_description')
    required List<LiveQualityDescription> qualityDescription,
    required List<LiveStreamUrl> durl,
  }) = _LivePlayUrlModel;

  factory LivePlayUrlModel.fromJson(Map<String, dynamic> json) =>
      _$LivePlayUrlModelFromJson(json);
}

@freezed
sealed class LiveQualityDescription with _$LiveQualityDescription {
  const factory LiveQualityDescription({
    required int qn,
    required String desc,
  }) = _LiveQualityDescription;

  factory LiveQualityDescription.fromJson(Map<String, dynamic> json) =>
      _$LiveQualityDescriptionFromJson(json);
}

@freezed
sealed class LiveStreamUrl with _$LiveStreamUrl {
  const factory LiveStreamUrl({
    required String url,
    required int length,
    required int order,
    @JsonKey(name: 'stream_type') required int streamType,
    @JsonKey(name: 'p2p_type') required int p2pType,
  }) = _LiveStreamUrl;

  factory LiveStreamUrl.fromJson(Map<String, dynamic> json) =>
      _$LiveStreamUrlFromJson(json);
}
