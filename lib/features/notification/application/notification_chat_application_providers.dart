import 'package:culcul/features/notification/application/notification_chat_port.dart';
import 'package:culcul/features/notification/data/notification_repository_impl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'notification_chat_application_providers.g.dart';

@riverpod
NotificationChatPort notificationChatPort(Ref ref) {
  return ref.watch(notificationRepositoryProvider);
}
