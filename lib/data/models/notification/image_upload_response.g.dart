// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_upload_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ImageUploadResponse _$ImageUploadResponseFromJson(Map<String, dynamic> json) =>
    _ImageUploadResponse(
      imageUrl: json['image_url'] as String,
      imageWidth: (json['image_width'] as num).toInt(),
      imageHeight: (json['image_height'] as num).toInt(),
    );

Map<String, dynamic> _$ImageUploadResponseToJson(
  _ImageUploadResponse instance,
) => <String, dynamic>{
  'image_url': instance.imageUrl,
  'image_width': instance.imageWidth,
  'image_height': instance.imageHeight,
};
