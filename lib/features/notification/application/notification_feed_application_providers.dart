import 'package:culcul/features/notification/application/notification_feed_port.dart';
import 'package:culcul/features/notification/data/notification_repository_impl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'notification_feed_application_providers.g.dart';

@riverpod
NotificationFeedPort notificationFeedPort(Ref ref) {
  return ref.watch(notificationRepositoryProvider);
}
