import 'package:culcul/features/notification/application/notification_unread_count_port.dart';
import 'package:culcul/features/notification/data/notification_repository_impl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'notification_unread_count_application_providers.g.dart';

@riverpod
NotificationUnreadCountPort notificationUnreadCountPort(Ref ref) {
  return ref.watch(notificationRepositoryProvider);
}
