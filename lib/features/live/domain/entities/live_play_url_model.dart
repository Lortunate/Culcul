import 'package:freezed_annotation/freezed_annotation.dart';

part 'live_play_url_model.freezed.dart';

@freezed
sealed class LivePlayUrlModel with _$LivePlayUrlModel {
  const factory LivePlayUrlModel({
    required int currentQuality,
    required List<String> acceptQuality,
    required int currentQn,
    required List<LiveQualityDescription> qualityDescription,
    required List<LiveStreamUrl> durl,
  }) = _LivePlayUrlModel;
}

@freezed
sealed class LiveQualityDescription with _$LiveQualityDescription {
  const factory LiveQualityDescription({required int qn, required String desc}) =
      _LiveQualityDescription;
}

@freezed
sealed class LiveStreamUrl with _$LiveStreamUrl {
  const factory LiveStreamUrl({
    required String url,
    required int length,
    required int order,
    required int streamType,
    required int p2pType,
  }) = _LiveStreamUrl;
}
