import 'package:culcul/core/providers/api_provider.dart';
import 'package:culcul/data/models/notification/system_notification_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'system_notification_provider.g.dart';

@riverpod
class SystemNotificationList extends _$SystemNotificationList {
  @override
  Future<List<SystemNotificationItem>> build() async {
    return ref.read(notificationRepositoryProvider).fetchSystemNotifications();
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => build());
  }
}
