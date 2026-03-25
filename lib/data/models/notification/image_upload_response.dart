import 'package:freezed_annotation/freezed_annotation.dart';

part 'image_upload_response.freezed.dart';
part 'image_upload_response.g.dart';

@freezed
sealed class ImageUploadResponse with _$ImageUploadResponse {
  const factory ImageUploadResponse({
    @JsonKey(name: 'image_url') required String imageUrl,
    @JsonKey(name: 'image_width') required int imageWidth,
    @JsonKey(name: 'image_height') required int imageHeight,
  }) = _ImageUploadResponse;

  factory ImageUploadResponse.fromJson(Map<String, dynamic> json) =>
      _$ImageUploadResponseFromJson(json);
}

