import 'package:culcul/core/utils/json_utils.dart';

class UploadedImage {
  final String imageUrl;
  final int width;
  final int height;

  const UploadedImage({
    required this.imageUrl,
    required this.width,
    required this.height,
  });

  factory UploadedImage.fromJson(Map<String, dynamic> json) {
    return UploadedImage(
      imageUrl: JsonUtils.parseStringWithDefault(json['image_url']),
      width: JsonUtils.parseIntWithDefault(json['image_width']),
      height: JsonUtils.parseIntWithDefault(json['image_height']),
    );
  }
}
