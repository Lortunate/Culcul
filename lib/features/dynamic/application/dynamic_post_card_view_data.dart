import 'package:culcul/features/dynamic/application/models/dynamic_item_extensions.dart';
import 'package:culcul/features/dynamic/application/models/dynamic_response.dart';
import 'package:culcul/features/dynamic/domain/entities/dynamic_content_entities.dart';

class DynamicPostCardViewData {
  final String id;
  final String? description;
  final String? contentText;
  final int authorMid;
  final String authorName;
  final String authorAvatar;
  final String timeText;
  final int forwardCount;
  final int commentCount;
  final int likeCount;
  final bool isLiked;
  final List<String>? images;
  final DynamicVideoContent? videoContent;
  final DynamicLinkCard? linkCard;
  final DynamicAdditional? additional;
  final DynamicPostCardViewData? orig;
  final String? topicName;
  final int? topicId;
  final bool preferLinkCardDisplay;

  const DynamicPostCardViewData({
    required this.id,
    required this.authorMid,
    required this.authorName,
    required this.authorAvatar,
    required this.timeText,
    this.description,
    this.contentText,
    this.forwardCount = 0,
    this.commentCount = 0,
    this.likeCount = 0,
    this.isLiked = false,
    this.images,
    this.videoContent,
    this.linkCard,
    this.additional,
    this.orig,
    this.topicName,
    this.topicId,
    this.preferLinkCardDisplay = false,
  });
}

extension DynamicPostCardViewDataMapper on DynamicItem {
  DynamicPostCardViewData toDynamicPostCardViewData() {
    return DynamicPostCardViewData(
      id: id,
      description: description,
      contentText: contentText,
      authorMid: authorMid,
      authorName: authorName,
      authorAvatar: authorAvatar,
      timeText: timeText,
      forwardCount: forwardCount,
      commentCount: commentCount,
      likeCount: likeCount,
      isLiked: isLiked,
      images: images,
      videoContent: videoContent,
      linkCard: linkCard,
      additional: additional,
      orig: orig?.toDynamicPostCardViewData(),
      topicName: topicName,
      topicId: topicId,
      preferLinkCardDisplay: preferLinkCardDisplay,
    );
  }
}
