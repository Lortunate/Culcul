import 'package:culcul/features/notification/data/dtos/reply_model.dart';

typedef NotificationActor = ReplyUser;
typedef NotificationEntryDetail = ReplyItemDetail;

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
