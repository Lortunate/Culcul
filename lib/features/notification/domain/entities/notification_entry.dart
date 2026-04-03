class NotificationActor {
  final int mid;
  final String nickname;
  final String avatar;

  const NotificationActor({
    required this.mid,
    required this.nickname,
    required this.avatar,
  });
}

class NotificationEntryDetail {
  final int subjectId;
  final String type;
  final String business;
  final String title;
  final String image;
  final String uri;
  final String sourceContent;
  final String targetReplyContent;
  final String message;

  const NotificationEntryDetail({
    required this.subjectId,
    required this.type,
    required this.business,
    required this.title,
    required this.image,
    required this.uri,
    required this.sourceContent,
    required this.targetReplyContent,
    required this.message,
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
