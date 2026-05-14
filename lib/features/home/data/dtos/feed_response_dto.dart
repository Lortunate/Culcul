class FeedResponseDto {
  final List<Map<String, dynamic>> item;

  const FeedResponseDto({this.item = const []});

  factory FeedResponseDto.fromJson(Map<String, dynamic> json) {
    final rawItem = json['item'];
    if (rawItem is! List<dynamic>) return const FeedResponseDto();
    final items = rawItem
        .whereType<Map<dynamic, dynamic>>()
        .map(Map<String, dynamic>.from)
        .toList();
    return FeedResponseDto(item: items);
  }
}
