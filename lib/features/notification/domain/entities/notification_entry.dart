class NotificationActor {
  final int mid;
  final int fans;
  final String nickname;
  final String avatar;
  final String midLink;
  final bool follow;

  const NotificationActor({
    required this.mid,
    required this.fans,
    required this.nickname,
    required this.avatar,
    required this.midLink,
    required this.follow,
  });
}

class NotificationEntryDetail {
  final int subjectId;
  final int rootId;
  final int sourceId;
  final int targetId;
  final String type;
  final int businessId;
  final String business;
  final String title;
  final String desc;
  final String image;
  final String uri;
  final String nativeUri;
  final String rootReplyContent;
  final String sourceContent;
  final String targetReplyContent;
  final List<NotificationActor> atDetails;
  final bool hideReplyButton;
  final bool hideLikeButton;
  final int likeState;
  final String message;

  const NotificationEntryDetail({
    required this.subjectId,
    required this.rootId,
    required this.sourceId,
    required this.targetId,
    required this.type,
    required this.businessId,
    required this.business,
    required this.title,
    required this.desc,
    required this.image,
    required this.uri,
    required this.nativeUri,
    required this.rootReplyContent,
    required this.sourceContent,
    required this.targetReplyContent,
    required this.atDetails,
    required this.hideReplyButton,
    required this.hideLikeButton,
    required this.likeState,
    required this.message,
  });
}

class NotificationEntry {
  final int id;
  final List<NotificationActor> actors;
  final NotificationEntryDetail detail;
  final int counts;
  final int isMulti;
  final int? replyTime;
  final int? likeTime;

  const NotificationEntry({
    required this.id,
    required this.actors,
    required this.detail,
    required this.counts,
    required this.isMulti,
    required this.replyTime,
    required this.likeTime,
  });

  NotificationActor? get primaryActor => actors.isEmpty ? null : actors.first;
  int get eventTime => replyTime ?? likeTime ?? 0;
}
