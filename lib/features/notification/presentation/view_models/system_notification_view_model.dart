import 'package:culcul/features/notification/application/use_case/notification_use_cases.dart';
import 'package:culcul/features/notification/domain/entities/system_notice.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'system_notification_view_model.g.dart';

@riverpod
class SystemNotificationList extends _$SystemNotificationList {
  @override
  Future<List<SystemNotice>> build() async {
    final result = await ref.read(notificationUseCasesProvider).getSystemNotifications();
    return result.when(success: (value) => value, failure: (error) => throw error);
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => build());
  }
}
