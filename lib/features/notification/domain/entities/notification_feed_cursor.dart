import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_feed_cursor.freezed.dart';

@freezed
sealed class NotificationFeedCursor with _$NotificationFeedCursor {
  const factory NotificationFeedCursor({required int id, required int time}) =
      _NotificationFeedCursor;
}
