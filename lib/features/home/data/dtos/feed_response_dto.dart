import 'package:json_annotation/json_annotation.dart';

part 'feed_response_dto.g.dart';

@JsonSerializable(createToJson: false)
class FeedResponseDto {
  @_FeedItemListConverter()
  final List<Map<String, dynamic>> item;

  const FeedResponseDto({this.item = const []});

  factory FeedResponseDto.fromJson(Map<String, dynamic> json) =>
      _$FeedResponseDtoFromJson(json);
}

class _FeedItemListConverter
    implements JsonConverter<List<Map<String, dynamic>>, Object?> {
  const _FeedItemListConverter();

  @override
  List<Map<String, dynamic>> fromJson(Object? json) {
    if (json is! List<dynamic>) return const [];
    return json
        .whereType<Map<dynamic, dynamic>>()
        .map(Map<String, dynamic>.from)
        .toList();
  }

  @override
  Object? toJson(List<Map<String, dynamic>> object) => object;
}
