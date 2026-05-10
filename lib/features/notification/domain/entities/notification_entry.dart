class NotificationActor {
  final int mid;
  final int fans;
  final String nickname;
  final String avatar;
  final String midLink;
  final bool follow;

  const NotificationActor({
    required this.mid,
    this.fans = 0,
    required this.nickname,
    required this.avatar,
    this.midLink = '',
    this.follow = false,
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
    this.rootId = 0,
    this.sourceId = 0,
    this.targetId = 0,
    required this.type,
    this.businessId = 0,
    required this.business,
    this.title = '',
    this.desc = '',
    this.image = '',
    this.uri = '',
    this.nativeUri = '',
    this.rootReplyContent = '',
    this.sourceContent = '',
    this.targetReplyContent = '',
    this.atDetails = const <NotificationActor>[],
    this.hideReplyButton = false,
    this.hideLikeButton = false,
    this.likeState = 0,
    this.message = '',
  });
}

class NotificationEntry {
  final int id;
  final List<NotificationActor> actors;
  final NotificationEntryDetail detail;
  final int? replyTime;
  final int? likeTime;

  const NotificationEntry({
    required this.id,
    required this.actors,
    required this.detail,
    required this.replyTime,
    required this.likeTime,
  });

  NotificationActor? get primaryActor => actors.isEmpty ? null : actors.first;
  int get eventTime => replyTime ?? likeTime ?? 0;
}
