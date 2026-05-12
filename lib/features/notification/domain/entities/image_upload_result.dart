import 'package:freezed_annotation/freezed_annotation.dart';

part 'image_upload_result.freezed.dart';

@freezed
sealed class ImageUploadResult with _$ImageUploadResult {
  const factory ImageUploadResult({
    required String imageUrl,
    required int imageWidth,
    required int imageHeight,
  }) = _ImageUploadResult;
}
