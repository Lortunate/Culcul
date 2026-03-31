class FeedResponseDto {
  final List<Map<String, dynamic>> item;
  final dynamic businessCard;
  final List<dynamic> floorInfo;
  final int userFeature;
  final String sideBarColumn;

  const FeedResponseDto({
    this.item = const [],
    this.businessCard,
    this.floorInfo = const [],
    this.userFeature = 0,
    this.sideBarColumn = '',
  });

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

    if (normalized['floor_info'] is! List) {
      normalized['floor_info'] = const <dynamic>[];
    }

    if (normalized['user_feature'] is! num) {
      normalized['user_feature'] = 0;
    }

    if (normalized['side_bar_column'] is! String) {
      normalized['side_bar_column'] = '';
    }

    return FeedResponseDto(
      item: (normalized['item'] as List).cast<Map<String, dynamic>>(),
      businessCard: normalized['business_card'],
      floorInfo: (normalized['floor_info'] as List).cast<dynamic>(),
      userFeature: (normalized['user_feature'] as num).toInt(),
      sideBarColumn: normalized['side_bar_column'] as String,
    );
  }
}
