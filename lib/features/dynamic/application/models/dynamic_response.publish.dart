part of 'dynamic_response.dart';

@freezed
sealed class DynamicPublishData with _$DynamicPublishData {
  const factory DynamicPublishData({
    @JsonKey(name: 'dyn_id_str', fromJson: JsonUtils.parseStringWithDefault)
    required String dynIdStr,
  }) = _DynamicPublishData;

  factory DynamicPublishData.fromJson(Map<String, dynamic> json) =>
      _$DynamicPublishDataFromJson(json);
}

@freezed
sealed class DynamicUploadImageData with _$DynamicUploadImageData {
  const factory DynamicUploadImageData({
    @JsonKey(name: 'image_url', fromJson: JsonUtils.parseStringWithDefault)
    required String imageUrl,
    @JsonKey(name: 'image_width') required int width,
    @JsonKey(name: 'image_height') required int height,
  }) = _DynamicUploadImageData;

  factory DynamicUploadImageData.fromJson(Map<String, dynamic> json) =>
      _$DynamicUploadImageDataFromJson(json);
}
