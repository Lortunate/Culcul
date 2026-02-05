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
  final DynamicLinkCard? linkCard;
  final String? commentId;
  final int? commentType;

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
    this.linkCard,
    this.commentId,
    this.commentType,
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
    DynamicLinkCard? linkCard,
    String? commentId,
    int? commentType,
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
      linkCard: linkCard ?? this.linkCard,
      commentId: commentId ?? this.commentId,
      commentType: commentType ?? this.commentType,
    );
  }
}

class DynamicVideoContent {
  final String title;
  final String cover;
  final String duration;
  final String playCount;
  final String danmakuCount;
  final String aid;
  final String bvid;

  DynamicVideoContent({
    required this.title,
    required this.cover,
    required this.duration,
    required this.playCount,
    required this.danmakuCount,
    required this.aid,
    required this.bvid,
  });
}

class DynamicLinkCard {
  final String title;
  final String cover;
  final String? desc;
  final String? url;

  DynamicLinkCard({
    required this.title,
    required this.cover,
    this.desc,
    this.url,
  });
}
