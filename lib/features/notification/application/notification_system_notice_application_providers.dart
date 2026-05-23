import 'package:culcul/features/notification/application/notification_system_notice_port.dart';
import 'package:culcul/features/notification/data/notification_repository_impl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'notification_system_notice_application_providers.g.dart';

@riverpod
NotificationSystemNoticePort notificationSystemNoticePort(Ref ref) {
  return ref.watch(notificationRepositoryProvider);
}
