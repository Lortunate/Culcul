import 'package:culcul/core/utils/json_utils.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'dynamic_publish_response_dto.freezed.dart';
part 'dynamic_publish_response_dto.g.dart';

@freezed
sealed class DynamicPublishResponseDto with _$DynamicPublishResponseDto {
  const factory DynamicPublishResponseDto({
    @JsonKey(name: 'dyn_id_str', fromJson: JsonUtils.parseStringWithDefault)
    required String dynIdStr,
  }) = _DynamicPublishResponseDto;

  factory DynamicPublishResponseDto.fromJson(Map<String, dynamic> json) =>
      _$DynamicPublishResponseDtoFromJson(json);
}

@freezed
sealed class DynamicUploadImageResponseDto with _$DynamicUploadImageResponseDto {
  const factory DynamicUploadImageResponseDto({
    @JsonKey(name: 'image_url', fromJson: JsonUtils.parseStringWithDefault)
    required String imageUrl,
    @JsonKey(name: 'image_width') required int width,
    @JsonKey(name: 'image_height') required int height,
  }) = _DynamicUploadImageResponseDto;

  factory DynamicUploadImageResponseDto.fromJson(Map<String, dynamic> json) =>
      _$DynamicUploadImageResponseDtoFromJson(json);
}
