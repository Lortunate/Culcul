import 'package:culcul/features/notification/data/notification_repository_impl.dart';
import 'package:culcul/features/notification/domain/repositories/notification_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final notificationRepositoryEntryProvider = Provider<NotificationRepository>((ref) {
  return ref.watch(notificationRepositoryProvider);
});
