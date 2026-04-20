class FeedResponseDto {
  final List<Map<String, dynamic>> item;

  const FeedResponseDto({this.item = const []});

  factory FeedResponseDto.fromJson(Map<String, dynamic> json) {
    final normalized = Map<String, dynamic>.from(json);

    final rawItem = normalized['item'];
    if (rawItem is List) {
      normalized['item'] = rawItem
          .whereType<Map>()
          .map((e) => Map<String, dynamic>.from(e))
          .toList();
    } else {
      normalized['item'] = const <Map<String, dynamic>>[];
    }

    return FeedResponseDto(
      item: (normalized['item'] as List).cast<Map<String, dynamic>>(),
    );
  }
}
