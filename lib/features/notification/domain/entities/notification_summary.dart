import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_summary.freezed.dart';

@freezed
sealed class NotificationSummary with _$NotificationSummary {
  const factory NotificationSummary({
    @Default(0) int at,
    @Default(0) int chat,
    @Default(0) int coin,
    @Default(0) int danmu,
    @Default(0) int favorite,
    @Default(0) int like,
    @Default(0) int recvLike,
    @Default(0) int recvReply,
    @Default(0) int reply,
    @Default(0) int system,
    @Default(0) int up,
  }) = _NotificationSummary;
}
