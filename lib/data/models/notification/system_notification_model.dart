import 'package:freezed_annotation/freezed_annotation.dart';

part 'system_notification_model.freezed.dart';
part 'system_notification_model.g.dart';

@freezed
abstract class SystemNotificationItem with _$SystemNotificationItem {
  const factory SystemNotificationItem({
    required int id,
    String? title,
    String? text,
    required int time,
    String? uri,
    @JsonKey(name: 'jump_text') String? jumpText,
    // Add other fields as needed
  }) = _SystemNotificationItem;

  factory SystemNotificationItem.fromJson(Map<String, dynamic> json) =>
      _$SystemNotificationItemFromJson(json);
}
