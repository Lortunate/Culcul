import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_entry.freezed.dart';

@freezed
sealed class NotificationActor with _$NotificationActor {
  const factory NotificationActor({
    required int mid,
    @Default(0) int fans,
    required String nickname,
    required String avatar,
    @Default('') String midLink,
    @Default(false) bool follow,
  }) = _NotificationActor;
}

@freezed
sealed class NotificationEntryDetail with _$NotificationEntryDetail {
  const factory NotificationEntryDetail({
    required int subjectId,
    @Default(0) int rootId,
    @Default(0) int sourceId,
    @Default(0) int targetId,
    required String type,
    @Default(0) int businessId,
    required String business,
    @Default('') String title,
    @Default('') String desc,
    @Default('') String image,
    @Default('') String uri,
    @Default('') String nativeUri,
    @Default('') String rootReplyContent,
    @Default('') String sourceContent,
    @Default('') String targetReplyContent,
    @Default(<NotificationActor>[]) List<NotificationActor> atDetails,
    @Default(false) bool hideReplyButton,
    @Default(false) bool hideLikeButton,
    @Default(0) int likeState,
    @Default('') String message,
  }) = _NotificationEntryDetail;
}

@freezed
sealed class NotificationEntry with _$NotificationEntry {
  const NotificationEntry._();

  const factory NotificationEntry({
    required int id,
    required List<NotificationActor> actors,
    required NotificationEntryDetail detail,
    required int? replyTime,
    required int? likeTime,
  }) = _NotificationEntry;

  NotificationActor? get primaryActor => actors.isEmpty ? null : actors.first;
  int get eventTime => replyTime ?? likeTime ?? 0;
}
