class DynamicFeed {
  final bool hasMore;
  final List<DynamicPost> items;
  final String offset;

  DynamicFeed({
    required this.hasMore,
    required this.items,
    required this.offset,
  });
}

class DynamicPost {
  final String id;
  final String type;
  final int authorMid;
  final String authorName;
  final String authorAvatar;
  final String timeText;
  final String? description;
  final List<String>? images;
  final int likeCount;
  final bool isLiked;
  final int commentCount;
  final int forwardCount;
  final DynamicVideoContent? video;
  final DynamicPost? orig;
  final String? topicName;
  final int? topicId;
  final DynamicLinkCard? linkCard;
  final String? commentId;
  final int? commentType;
  final DynamicAdditional? additional;

  DynamicPost({
    required this.id,
    required this.type,
    required this.authorMid,
    required this.authorName,
    required this.authorAvatar,
    required this.timeText,
    this.description,
    this.images,
    required this.likeCount,
    this.isLiked = false,
    required this.commentCount,
    required this.forwardCount,
    this.video,
    this.orig,
    this.topicName,
    this.topicId,
    this.linkCard,
    this.commentId,
    this.commentType,
    this.additional,
  });

  DynamicPost copyWith({
    String? id,
    String? type,
    int? authorMid,
    String? authorName,
    String? authorAvatar,
    String? timeText,
    String? description,
    List<String>? images,
    int? likeCount,
    bool? isLiked,
    int? commentCount,
    int? forwardCount,
    DynamicVideoContent? video,
    DynamicPost? orig,
    String? topicName,
    int? topicId,
    DynamicLinkCard? linkCard,
    String? commentId,
    int? commentType,
    DynamicAdditional? additional,
  }) {
    return DynamicPost(
      id: id ?? this.id,
      type: type ?? this.type,
      authorMid: authorMid ?? this.authorMid,
      authorName: authorName ?? this.authorName,
      authorAvatar: authorAvatar ?? this.authorAvatar,
      timeText: timeText ?? this.timeText,
      description: description ?? this.description,
      images: images ?? this.images,
      likeCount: likeCount ?? this.likeCount,
      isLiked: isLiked ?? this.isLiked,
      commentCount: commentCount ?? this.commentCount,
      forwardCount: forwardCount ?? this.forwardCount,
      video: video ?? this.video,
      orig: orig ?? this.orig,
      topicName: topicName ?? this.topicName,
      topicId: topicId ?? this.topicId,
      linkCard: linkCard ?? this.linkCard,
      commentId: commentId ?? this.commentId,
      commentType: commentType ?? this.commentType,
      additional: additional ?? this.additional,
    );
  }
}

class DynamicVideoContent {
  final String cover;
  final String title;
  final String playCount;
  final String danmakuCount;
  final String duration;
  final String? aid;
  final String? bvid;

  DynamicVideoContent({
    required this.cover,
    required this.title,
    required this.playCount,
    required this.danmakuCount,
    required this.duration,
    this.aid,
    this.bvid,
  });
}

class DynamicLinkCard {
  final String title;
  final String cover;
  final String? desc;
  final String url;

  DynamicLinkCard({
    required this.title,
    required this.cover,
    this.desc,
    required this.url,
  });
}

class DynamicAdditional {
  final String type;
  final String? title;
  final String? cover;
  final String? desc1;
  final String? desc2;
  final String? jumpUrl;
  
  // Vote specific
  final int? voteId;
  final int? voteJoinNum;
  final int? voteChoiceCnt;
  final int? voteStatus;
  
  // Reserve specific
  final int? reserveTotal;
  final int? state; // 0: unreserved, 1: reserved
  
  // Goods specific
  final String? headText;
  final List<DynamicGoodsItem>? goodsItems;

  DynamicAdditional({
    required this.type,
    this.title,
    this.cover,
    this.desc1,
    this.desc2,
    this.jumpUrl,
    this.voteId,
    this.voteJoinNum,
    this.voteChoiceCnt,
    this.voteStatus,
    this.reserveTotal,
    this.state,
    this.headText,
    this.goodsItems,
  });
}

class DynamicGoodsItem {
  final String name;
  final String price;
  final String cover;
  final String jumpUrl;

  DynamicGoodsItem({
    required this.name,
    required this.price,
    required this.cover,
    required this.jumpUrl,
  });
}
