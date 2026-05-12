class FeedResponseDto {
  final List<Map<String, dynamic>> item;

  const FeedResponseDto({this.item = const []});

  factory FeedResponseDto.fromJson(Map<String, dynamic> json) {
    final rawItem = json['item'];
    final List<Map<String, dynamic>> items;
    if (rawItem is List<dynamic>) {
      items = rawItem
          .whereType<Map<dynamic, dynamic>>()
          .map((e) => Map<String, dynamic>.from(e))
          .toList();
    } else {
      items = const <Map<String, dynamic>>[];
    }

    return FeedResponseDto(item: items);
  }
}
