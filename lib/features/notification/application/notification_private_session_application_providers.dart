import 'package:culcul/features/notification/application/notification_private_session_port.dart';
import 'package:culcul/features/notification/data/notification_repository_impl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'notification_private_session_application_providers.g.dart';

@riverpod
NotificationPrivateSessionPort notificationPrivateSessionPort(Ref ref) {
  return ref.watch(notificationRepositoryProvider);
}
