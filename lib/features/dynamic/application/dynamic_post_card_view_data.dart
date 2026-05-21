import 'package:culcul/features/dynamic/data/dtos/dynamic_item_extensions.dart';
import 'package:culcul/features/dynamic/data/dtos/dynamic_response.dart';

class DynamicPostCardViewData {
  final String id;
  final String? description;
  final int forwardCount;
  final int commentCount;
  final int likeCount;
  final bool isLiked;

  const DynamicPostCardViewData({
    required this.id,
    this.description,
    this.forwardCount = 0,
    this.commentCount = 0,
    this.likeCount = 0,
    this.isLiked = false,
  });
}

extension DynamicPostCardViewDataMapper on DynamicItem {
  DynamicPostCardViewData toDynamicPostCardViewData() {
    return DynamicPostCardViewData(
      id: id,
      description: description,
      forwardCount: forwardCount,
      commentCount: commentCount,
      likeCount: likeCount,
      isLiked: isLiked,
    );
  }
}
